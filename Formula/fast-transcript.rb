class FastTranscript < Formula
  desc "Fast local transcription for large lectures with NVIDIA Parakeet ONNX"
  homepage "https://github.com/brenorb/fast-transcript"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/brenorb/fast-transcript/releases/download/v1.1.3/fast-transcript-v1.1.3-macos-arm64.tar.gz"
    version "1.1.3"
    sha256 "dd52095d84bd3100106a325af087a0d068271a0785d4026eeed06712ce0a5ea6"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/brenorb/fast-transcript/releases/download/v1.1.3/fast-transcript-v1.1.3-linux-x86_64.tar.gz"
    version "1.1.3"
    sha256 "5ed7809448dfa4c4bbb2cb9f3da9dd0cf258b4897e0abfa987ddfb182814ed85"
  else
    url "https://github.com/brenorb/fast-transcript/archive/refs/tags/v1.1.3.tar.gz"
    sha256 "cb78bba0e9fb630798f858251cbe3eb8937fe05dc7046a289ed73b032f4280f3"
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
      assert_path_exists formula_opt_bin("fluidaudio-cli")/"fluidaudiocli"
      helper_help = shell_output("#{formula_opt_bin("fluidaudio-cli")}/fluidaudiocli process --help 2>&1")
      assert_match "Process Command Usage", helper_help
    end
  end
end
