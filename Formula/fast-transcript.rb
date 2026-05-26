class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  version "0.2.9"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.9/fast-transcript-v0.2.9-macos-arm64.tar.gz"
    sha256 "0ddf86f437635e1067ec1350d0098baa49d02ae31bd8a824fb1bea2708764493"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.9/fast-transcript-v0.2.9-linux-x86_64.tar.gz"
    sha256 "bda40c7f5da72c827342ba562eeb37ad49aa159747207a3aeee12d765964a60d"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v0.2.9.tar.gz"
    sha256 "e58d9c58b919a91c2b5b2a765a9809aa08ebbc88087f5c2f79127495fa09aa76"
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
