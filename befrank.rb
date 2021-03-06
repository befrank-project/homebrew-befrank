class Befrank < Formula
  desc "Command line tools (daemon, wallet and miner) for the Belgian eFrank. A crypto-currency made for and by Belgium and anyone who feels part of our community."
  homepage "http://getfrank.be"
  url "https://github.com/befrank-project/befrank/archive/1.0.1-beta-1-g.tar.gz"
  sha256 "ca2a8ce1edf0aed5368adbe1708fca057486ca27324918c2e3bbc2b869bef9ca"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "openssl"
  depends_on "readline"
  depends_on "libevent"
  depends_on "miniupnpc"
  depends_on "zeromq"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    cmd = "#{bin}befrank-wallet-cli --restore-deterministic-wallet "\
    "--password brew-test --restore-height 1 --generate-new-wallet wallet "\
    "--electrum-seed 'buffet jagged spiders cabin anybody fully gifts thaw"\
    " maps ember ghetto pencil wetsuit vinegar match alerts upright wade "\
    "benches vinegar bugs knapsack enraged fuel jagged'"\
    "--command address"
    address = "FX1vEdZf6dmA6SKgwxSeng12Uvza6i4GMUZmeS4No3j7HzYAkoRKQ74G3nogEKsfoy4P5dvT77BCZZRwYb9UXwWTHzygVji"
    assert_equal address, shell_output(cmd).split[-1]
  end
end
