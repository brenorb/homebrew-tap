class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  version "0.2.2"
  license "MIT"

  bottle do
    root_url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "51358a60e917ae1fe38cdec0d1bc56af9820bb49a370e58a5251c6c1c6e68329"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.2/fast-transcript-v0.2.2-macos-arm64.tar.gz"
    sha256 "66ea3a52c107371f23920ffa4077c90e4075f3a3c2f3e3191533b47edb53e00a"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.2/fast-transcript-v0.2.2-linux-x86_64.tar.gz"
    sha256 "af59bab693357e309e5c6bf67694942c9dc90c4337c00df4dd0b5795d94a44ef"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v0.2.2.tar.gz"
    sha256 "9ef8c728ce094b63086d55c4440113cf0e97e32ca8af9f2cbe9050af7796a178"
    depends_on "rust" => :build
  end

  depends_on "ffmpeg"

  def install
    if buildpath.join("Cargo.toml").exist?
      system "cargo", "install", *std_cargo_args(path: ".")
    else
      bin.install "fscript"
      prefix.install "README.md", "LICENSE"
    end
  end

  test do
    output = shell_output("#{bin}/fscript --help")
    assert_match "usage: fscript", output
  end
end
