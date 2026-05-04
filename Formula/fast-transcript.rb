class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  version "0.2.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.1/fast-transcript-v0.2.1-macos-arm64.tar.gz"
    sha256 "812bd97169d865387fd4bb005d9f6b9bb86f1ea7b09409f2c842d54d2d333f0e"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.1/fast-transcript-v0.2.1-linux-x86_64.tar.gz"
    sha256 "4731d49e5c58cee63fa6f6fb77777bb482013a72ed538fce2fadfb5bd5a9493e"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v0.2.1.tar.gz"
    sha256 "06a0f7d3b7afa6bd6c806068b6c09e90d06db0f5f76bc0ba3c52c458ddc60cf9"
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
