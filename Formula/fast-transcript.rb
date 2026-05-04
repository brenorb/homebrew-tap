class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  version "0.2.6"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.6/fast-transcript-v0.2.6-macos-arm64.tar.gz"
    sha256 "8e62f7309d0499ac3a110c900a62b6120f3bc142f0114da572153217f2450eb3"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.6/fast-transcript-v0.2.6-linux-x86_64.tar.gz"
    sha256 "3fe342e874044da92bc4975004d6483a5a58b9ed2a4c0e5bb0480e3e5bf40f73"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v0.2.6.tar.gz"
    sha256 "a8b9cecc2aede14f087f5339292751c19c9563beb117764306066473fe03af35"
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
