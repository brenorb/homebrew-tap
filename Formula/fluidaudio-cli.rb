class FluidaudioCli < Formula
  desc "Command-line diarization and audio inference helper for Apple Silicon Macs"
  homepage "https://github.com/FluidInference/FluidAudio"
  url "https://github.com/FluidInference/FluidAudio/archive/6ef369d079500ea3360721cb83a5650e0247d721.tar.gz"
  version "0.15.2-6ef369d"
  sha256 "470f534f2cb5ff1b24b6bcd51a7bb9fb27bdc70f1f138e3b6b803a82945e729a"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    ENV["SWIFTPM_DISABLE_SANDBOX"] = "1"
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "fluidaudiocli"
    bin.install ".build/release/fluidaudiocli"
    prefix.install "README.md", "LICENSE"
  end

  test do
    output = shell_output("#{bin}/fluidaudiocli process --help 2>&1")
    assert_match "Process Command Usage", output
  end
end
