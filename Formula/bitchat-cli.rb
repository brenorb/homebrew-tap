class BitchatCli < Formula
  include Language::Python::Virtualenv

  desc "Bluetooth mesh chat CLI with DMs and geohash channels"
  homepage "https://github.com/brenorb/bitchat-cli"
  url "https://files.pythonhosted.org/packages/10/c1/9b4522cffb61915a278270b91d12814d26870fdda02478421735ed3a3772/bitchat4agents-0.1.0-py3-none-any.whl"
  sha256 "6a2ebeb9bf268074befb627469339826efb02aba9e6033e7aadc0e9490943367"
  license "Unlicense"

  depends_on "python@3.12"

  on_macos do
    resource "cffi" do
      url "https://files.pythonhosted.org/packages/df/a2/781b623f57358e360d62cdd7a8c681f074a71d445418a776eef0aadb4ab4/cffi-2.0.0-cp312-cp312-macosx_11_0_arm64.whl"
      sha256 "8eca2a813c1cb7ad4fb74d368c2ffbbb4789d377ee5bb8df98373c2cc0dee76c"
    end

    resource "coincurve" do
      url "https://files.pythonhosted.org/packages/24/5a/2da75ee00a722ef1fa068ada3bc34c564595ead86fef573434e2f0cb0a5c/coincurve-21.0.0-cp312-cp312-macosx_11_0_arm64.whl"
      sha256 "1cb1cd19fb0be22e68ecb60ad950b41f18b9b02eebeffaac9391dc31f74f08f2"
    end

    resource "cryptography" do
      url "https://files.pythonhosted.org/packages/9b/22/adf66990e63584a68dfb50c24f48a125c07b1699899381c8151e63ed458c/cryptography-49.0.0-cp311-abi3-macosx_11_0_arm64.whl"
      sha256 "966fe0e9c67490071f14c0d2b1cb2dfb3023c5ce39457343931415f08382f2db"
    end

    resource "pyobjc-core" do
      url "https://files.pythonhosted.org/packages/8c/88/300ad283bed0c971c52dcac6f70113e138169d4ce6d856ddd03d16081e51/pyobjc_core-12.2.1-cp312-cp312-macosx_10_13_universal2.whl"
      sha256 "a64232bb27ed101d4adc7d42b0e64a6d3331aac7bee7861c037a6777a163f10b"
    end

    resource "pyobjc-framework-cocoa" do
      url "https://files.pythonhosted.org/packages/f7/cf/1b3b32b2f28f66cc053c3438ef4e6df36a1591945bf05e7399da18d74553/pyobjc_framework_cocoa-12.2.1-cp312-cp312-macosx_10_13_universal2.whl"
      sha256 "28b9b8bab1c36efb94744786918752d0c1842f5fbb67e7d5ca97b5f736512080"
    end

    resource "pyobjc-framework-corebluetooth" do
      url "https://files.pythonhosted.org/packages/c6/c4/7938016860850e28c001dc9b7c653352c43f7aebfffc6d3c5fd087281f22/pyobjc_framework_corebluetooth-12.2.1-cp312-cp312-macosx_10_13_universal2.whl"
      sha256 "2f8d2ed65c0e98ba044b6a7fc2f9a290a5c579a28d33a57c642f8617ccbcca0f"
    end

    resource "pyobjc-framework-libdispatch" do
      url "https://files.pythonhosted.org/packages/b3/8f/42cfa987c07a2b5ce8c236a42b0fb388b8807dac72c25e004cd4905ea9a3/pyobjc_framework_libdispatch-12.2.1-cp312-cp312-macosx_10_13_universal2.whl"
      sha256 "8f41b5021ff70bc51220a79b41ebd1eacb55fe3ceb67448594f30e491a2c42a5"
    end

    resource "websockets" do
      url "https://files.pythonhosted.org/packages/40/1e/9771421ac2286eaab95b8575b0cb701ae3663abf8b5e1f64f1fd90d0a673/websockets-16.0-cp312-cp312-macosx_11_0_arm64.whl"
      sha256 "86890e837d61574c92a97496d590968b23c2ef0aeb8a9bc9421d174cd378ae39"
    end
  end

  on_linux do
    resource "cffi" do
      url "https://files.pythonhosted.org/packages/78/2d/7fa73dfa841b5ac06c7b8855cfc18622132e365f5b81d02230333ff26e9e/cffi-2.0.0-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
      sha256 "3e17ed538242334bf70832644a32a7aae3d83b57567f9fd60a26257e992b79ba"
    end

    resource "coincurve" do
      url "https://files.pythonhosted.org/packages/b7/75/050b6fd08978de85a7b480f0f220ab6a30967c0910119f3096a8dd40befc/coincurve-21.0.0-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
      sha256 "1b04778b75339c6e46deb9ae3bcfc2250fbe48d1324153e4310fc4996e135715"
    end

    resource "cryptography" do
      url "https://files.pythonhosted.org/packages/e6/8b/43011f7ebe515a8aa20d61f290a326cd890c2e738e16e59eaff8d9c3a412/cryptography-49.0.0-cp311-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
      sha256 "0e959b578856a3924bc0cbb710fc12c387b9412a951389f3ca61704a9e25f325"
    end

    resource "dbus-fast" do
      url "https://files.pythonhosted.org/packages/68/e9/77bc23a6f5aebfb8f2c34489795e8517aed7eca31738438e1a4c4a4891d3/dbus_fast-5.0.22-cp312-cp312-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl"
      sha256 "4ffcf16034f71a801bd2108aeffb6337d104c9459e8b1a218d16a917c8a2d2e9"
    end

    resource "websockets" do
      url "https://files.pythonhosted.org/packages/18/29/71729b4671f21e1eaa5d6573031ab810ad2936c8175f03f97f3ff164c802/websockets-16.0-cp312-cp312-manylinux1_x86_64.manylinux_2_28_x86_64.manylinux_2_5_x86_64.whl"
      sha256 "9b5aca38b67492ef518a8ab76851862488a478602229112c4b0d58d63a7a4d5c"
    end
  end

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/b0/7b/90df4a0a816d98d6ea26f559d87836d494a2cf1fcf063be67df50a7bcc30/anyio-4.14.1-py3-none-any.whl"
    sha256 "4e5533c5b8ff0a24f5d7a176cbe6877129cd183893f66b537f8f227d10527d72"
  end

  resource "bleak" do
    url "https://files.pythonhosted.org/packages/26/54/05aceb9cd80073805b3ed8522e3196e8cb22f70e741873fa51406c31f4e7/bleak-3.0.2-py3-none-any.whl"
    sha256 "39092feb9e83f1df5ad2f88e837723c7211c982ce9e9cda6235104bc2ebe0d0d"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/ef/2f/c5464532e965badff2f4c4c1a3a83f5697f0d7c407ed0cda44aaa99bb451/certifi-2026.6.17-py3-none-any.whl"
    sha256 "2227dcbaafe0d2f59279d1762ddddc37783ed4354594f194ffc31d20f41fc3db"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/04/4b/29cac41a4d98d144bf5f6d33995617b185d14b22401f75ca86f384e87ff1/h11-0.16.0-py3-none-any.whl"
    sha256 "63cf8bbe7522de3bf65932fda1d9c2772064ffb3dae62d55932da54b31cb6c86"
  end

  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/7e/f5/f66802a942d491edb555dd61e3a9961140fd64c90bce1eafd741609d334d/httpcore-1.0.9-py3-none-any.whl"
    sha256 "2d400746a40668fc9dec9810239072b40b4484b640a8c38fd654a024c7a1bf55"
  end

  resource "httpx" do
    url "https://files.pythonhosted.org/packages/2a/39/e50c7c3a983047577ee07d2a9e53faf5a69493943ec3f6a384bdc792deb2/httpx-0.28.1-py3-none-any.whl"
    sha256 "d909fcccc110f8c7faf814ca82a9a4d816bc5a6dbfea25d6591d6985b8ba59ad"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/1e/5e/d4e9f1a599fb8e573b7b87160658329fbf28d19eac2718f51fc3def3aa5a/idna-3.18-py3-none-any.whl"
    sha256 "7f952cbe720b688055e3f87de14f5c3e5fdaa8bc3928985c4077ca689de849a2"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0c/c3/44f3fbbfa403ea2a7c779186dc20772604442dde72947e7d01069cbe98e3/pycparser-3.0-py3-none-any.whl"
    sha256 "b727414169a36b7d524c1c3e31839a521725078d7b2ff038656844266160a992"
  end

  resource "python-socks" do
    url "https://files.pythonhosted.org/packages/3d/18/23b981b1cf58c1e7b7e36fa1392daf12878b6a3c26c5e4248601647a6d09/python_socks-2.8.2-py3-none-any.whl"
    sha256 "7cf785d0631e0659384a773b3c402bc22cccdc23894ba1d65f8524748ace1193"
  end

  resource "socksio" do
    url "https://files.pythonhosted.org/packages/37/c3/6eeb6034408dac0fa653d126c9204ade96b819c936e136c5e8a6897eee9c/socksio-1.0.0-py3-none-any.whl"
    sha256 "95dc1f15f9b34e8d7b16f06d74b8ccf48f609af32ab33c608d08761c5dcbb1f3"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/18/67/36e9267722cc04a6b9f15c7f3441c2363321a3ea07da7ae0c0707beb2a9c/typing_extensions-4.15.0-py3-none-any.whl"
    sha256 "f0fa19c6845758ab08074a0cfa8b7aecb71c999ca73d62883bc25cc018c4e548"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      This formula installs the `bitchat` executable.
    EOS
  end

  test do
    output = shell_output("#{bin}/bitchat --help")
    assert_match "BitChat public BLE chat CLI", output
    assert_match "doctor", output
  end
end
