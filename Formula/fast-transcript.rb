class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  version "0.2.7"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.7/fast-transcript-v0.2.7-macos-arm64.tar.gz"
    sha256 "75237bb982d9c5e2a91dd6d07968202b409dd166099a01f2ca88a95f851e3e4c"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v0.2.7/fast-transcript-v0.2.7-linux-x86_64.tar.gz"
    sha256 "a582210b12038eb992243c20f18011115a4102c7d649a19321923d7bb5768b33"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v0.2.7.tar.gz"
    sha256 "186ca9f6c85b7f1ed96eb51ec9b43ce8342e110cc243d4bc4fb7843ed5a02058"
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
