class Tendermint < Formula
  desc "BFT replicated state machines in any programming language"
  homepage "https://tendermint.com/"
  url "https://github.com/tendermint/tendermint/archive/v0.22.5.tar.gz"
  sha256 "b34916fc3f943da46715903d0e87b9fb0ba9cdd6eabc4d96ab7569d48a6e8443"

  bottle do
    cellar :any_skip_relocation
  end

  head do
    url "https://github.com/tendermint/tendermint.git",
      :branch => "develop"
  end

  depends_on "go" => :build
  depends_on "glide" => :build

  def install
    ENV["GOPATH"] = buildpath
    tendermintpath = buildpath/"src/github.com/tendermint/tendermint"
    tendermintpath.install buildpath.children
    cd tendermintpath do
      system "make", "get_vendor_deps"
      system "make", "build"
      bin.install "build/tendermint"
    end
  end

  test do
    tendermint_version_without_hash = shell_output("#{bin}/tendermint version").partition("-").first
    assert_match version.to_s, tendermint_version_without_hash
  end
end
