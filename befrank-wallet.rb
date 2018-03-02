class BefrankWallet < Formula
  desc "GUI wallet for the Belgian eFrank. A crypto-currency made for and by Belgians and anyone who feels part of our community."
  homepage "http://getfrank.be"
  url "https://github.com/befrank-project/befrank-wallet/releases/download/v0.1.1-alpha.3/befrank-wallet-v0.1.1-alpha.3.tar.gz"
  sha256 "c2d8a0dcc2d8066417669daeed7c48363d4ecf81b23518a7c73eaa316366ab2b"
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
