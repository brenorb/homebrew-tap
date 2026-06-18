class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v1.1.2/fast-transcript-v1.1.2-macos-arm64.tar.gz"
    sha256 "3351665fa344e83c8b493e1dd22e7b243b43a609df079742dd73b5f8227da610"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v1.1.2/fast-transcript-v1.1.2-linux-x86_64.tar.gz"
    sha256 "b229a8ccdb1cefd4dcec3bac0a1932f1dc73afe4b69e3e082ee6cb56392b3912"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v1.1.2.tar.gz"
    sha256 "3594817157f612140be01231432263508a1eedb5514195fc1dee4ca743d6c118"
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
