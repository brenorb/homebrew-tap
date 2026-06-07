class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  version "1.0.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v1.0.0/fast-transcript-v1.0.0-macos-arm64.tar.gz"
    sha256 "ddb44128f5215122243167ee7843fe0f18df081933daff2afc61c7b416181027"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v1.0.0/fast-transcript-v1.0.0-linux-x86_64.tar.gz"
    sha256 "05191223056baacd086d03b6f1885a971c489aec68402895f3d72971c4df1238"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v1.0.0.tar.gz"
    sha256 "078138c895f3c7d1eaf1d31a09f48d5181c4672967bec504a4b9114811e9ccba"
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
