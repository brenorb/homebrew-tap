class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v1.0.3/fast-transcript-v1.0.3-macos-arm64.tar.gz"
    sha256 "1814b62ca5a3a6e713f47e15b5d4e0eef9ec2b169f7484e56a92982ec2e0a969"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v1.0.3/fast-transcript-v1.0.3-linux-x86_64.tar.gz"
    sha256 "d6b76108ccdf2d444b6f072497a1d95405784922f31f3ac8764e0861be865f2d"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v1.0.3.tar.gz"
    sha256 "5df8a344dbfb0b79333b980f3fdad6278d0f87f45dc839e8068bd0098f0b6a3a"
    depends_on "rust" => :build
  end

  depends_on "ffmpeg"
  depends_on "fluidaudio-cli" if OS.mac? && Hardware::CPU.arm?

  def install
    if buildpath.join("Cargo.toml").exist?
      system "cargo", "install", *std_cargo_args(path: ".")
    else
      bin.install "fscript"
      prefix.install "README.md", "LICENSE"
    end
  end

  def caveats
    <<~EOS
      Speaker diarization is enabled automatically when `fluidaudiocli` is available.
      This tap installs it for Apple Silicon macOS via the `fluidaudio-cli` formula.

      On other platforms, `fscript` still works for plain transcription. To enable
      speaker labels there, install a compatible `fluidaudiocli` binary and set
      FSCRIPT_DIARIZATION_BINARY if it is not already on PATH.
    EOS
  end

  test do
    output = shell_output("#{bin}/fscript --help")
    assert_match "Usage:", output
    assert_match "<media-or-url>", output
    assert_match version.to_s, shell_output("#{bin}/fscript --version")
    if OS.mac? && Hardware::CPU.arm?
      assert_path_exists Formula["fluidaudio-cli"].opt_bin/"fluidaudiocli"
      helper_help = shell_output("#{Formula["fluidaudio-cli"].opt_bin}/fluidaudiocli process --help 2>&1")
      assert_match "Process Command Usage", helper_help
    end
  end
end
