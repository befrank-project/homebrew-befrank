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
  end

  test do
    cmd = "#{bin}befrank-wallet --restore-deterministic-wallet "\
    "--password brew-test --restore-height 1 --generate-new-wallet wallet "\
    "--electrum-seed 'buffet jagged spiders cabin anybody fully gifts thaw"\
    " maps ember ghetto pencil wetsuit vinegar match alerts upright wade "\
    "benches vinegar bugs knapsack enraged fuel jagged'"\
    "--command address"
    address = "FX1vEdZf6dmA6SKgwxSeng12Uvza6i4GMUZmeS4No3j7HzYAkoRKQ74G3nogEKsfoy4P5dvT77BCZZRwYb9UXwWTHzygVji"
    assert_equal address, shell_output(cmd).split[-1]
  end
end
