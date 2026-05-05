class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  version "0.2.8"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.8/fast-transcript-v0.2.8-macos-arm64.tar.gz"
    sha256 "e746703c73b4d546ad18f9b2df3f3d33dd977dfe02d9c2ee3dab56b38dbdf827"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.8/fast-transcript-v0.2.8-linux-x86_64.tar.gz"
    sha256 "d9649abb5c5214793c0c1dc83bb02a396d533f659f17455d7dad7eb8fc489b27"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v0.2.8.tar.gz"
    sha256 "5572ae3f1721315d7ad09b3875f4b53aa07a31ea9eb770246a9237c6cd4de7ef"
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
