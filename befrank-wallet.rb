class BefrankWallet < Formula
  desc "GUI wallet for the Belgian eFrank. A crypto-currency made for and by Belgians and anyone who feels part of our community."
  homepage "http://getfrank.be"
  url "https://github.com/befrank-project/befrank-wallet/archive/v0.1.1-alpha.4.tar.gz"
  sha256 "9a482013ddb6a7b3f1c396b5a760d63ded76006e3269d2d403eddc702a1843b2"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "qrencode" => :build
  depends_on "befrank"=> :build
  depends_on "boost"
  depends_on "qt"

  resource "cryptonote" do
    url "https://github.com/befrank-project/befrank.git", :tag => "v0.1.1-alpha.4"
  end
  
   resource "libqrencode" do
    url "https://github.com/fukuchi/libqrencode.git", :tag => "v3.4.4"
  end
  
  def install
    resource("libqrencode").stage do
      ENV.append "LDFLAGS", "-lintl"

      # Reset ARCHFLAGS to match how we build
      ENV["ARCHFLAGS"] = "-arch #{MacOS.preferred_arch}"

      system "./autogen.sh"
      system "./configure", "--prefix=#{libexec}/fontforge",
                            "--without-libzmq",
                            "--without-x",
                            "--without-iconv",
                            "--disable-python-scripting",
                            "--disable-python-extension"
      system "make"
      system "make", "install"
    end
    
    resource("cryptonote").stage do
      ENV.append "LDFLAGS", "-lintl"

      # Reset ARCHFLAGS to match how we build
      ENV["ARCHFLAGS"] = "-arch #{MacOS.preferred_arch}"

      system "cmake", ".", *std_cmake_args
      system "make", "install"
    end

    system "cmake", ".", *std_cmake_args
    system "make", "install"
    prefix.install "befrank-wallet-qt.app"
    bin.write_exec_script "#{prefix}/befrank-wallet-qt.app/Contents/MacOS/befrank-wallet-qt"
  end

  test do
    assert_predicate testpath/"#{bin}/befrank-wallet-qt.app", :exist?, "I'm an untestable GUI app."
  end
end
