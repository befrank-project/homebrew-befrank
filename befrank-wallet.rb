class BefrankWallet < Formula
  desc "GUI wallet for the Belgian eFrank. A crypto-currency made for and by Belgians and anyone who feels part of our community."
  homepage "http://getfrank.be"
  url "https://github.com/befrank-project/befrank-wallet/archive/v0.1.1-alpha.5.tar.gz"
  sha256 "a2019ec5cb23e7a53ef2bc7d9d2de1e6b839805f64b2ac9bd439e0fe2af260d5"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "m4" => :build
  depends_on "qrencode"
  depends_on "boost"
  depends_on "qt"

  resource "cryptonote" do
    url "https://github.com/befrank-project/befrank.git", :tag => "v0.1.1-alpha.5"
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
      system "./configure"
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
