class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "504ff8082fe457f3775459a28ec022066a58ce7be571889f11075280bc562e80"
  license "MIT"

  depends_on "rust" => :build
  depends_on "ffmpeg"

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    output = shell_output("#{bin}/fscript --help")
    assert_match "usage: fscript", output
  end
end
