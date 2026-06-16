class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v1.0.1/fast-transcript-v1.0.1-macos.tar.gz"
    sha256 "e354ffd88fe03e39f1d5a4cbbf968d7728794ef3a05c5a07c2f8b3f4310246d5"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v1.0.1/fast-transcript-v1.0.1-linux.tar.gz"
    sha256 "ac012fd951086c1f644f83b14b53c6c102171ccb754a72f244494ecbd5ae1c24"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v1.0.1.tar.gz"
    sha256 "870a7880fc2ebecc8cf092e6493383eafd55c6d360797bfdb90da39ca9a875ef"
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
    assert_match version.to_s, shell_output("#{bin}/fscript --version")
    if OS.mac? && Hardware::CPU.arm?
      assert_path_exists Formula["fluidaudio-cli"].opt_bin/"fluidaudiocli"
      helper_help = shell_output("#{Formula["fluidaudio-cli"].opt_bin}/fluidaudiocli process --help 2>&1")
      assert_match "Process Command Usage", helper_help
    end
  end
end
