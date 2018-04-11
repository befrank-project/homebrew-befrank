class BefrankWallet < Formula
  desc "GUI wallet for the Belgian eFrank. A crypto-currency made for and by Belgians and anyone who feels part of our community."
  homepage "http://getfrank.be"
  url "https://github.com/befrank-project/befrank-wallet/archive/v0.1.1-alpha.4.tar.gz"
  sha256 "a55870836017492df406de4b588544b388a9878ab42913cbe2a4d9b4d5d54788"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "qt"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    prefix.install "befrank-wallet-qt.app"
    bin.write_exec_script "#{prefix}/befrank-wallet-qt.app/Contents/MacOS/befrank-wallet-qt"
  end

  test do
    assert_predicate testpath/"#{bin}/befrank-wallet-qt.app", :exist?, "I'm an untestable GUI app."
  end
end
