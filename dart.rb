class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.2.0"
  if Hardware::CPU.is_64_bit?
    url "https://storage.flutter-io.cn/dart-archive/channels/stable/release/2.2.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "9438afb49b69ac655882036c214e343232fdcd5af24607e6058e2def33261197"
  else
    url "https://storage.flutter-io.cn/dart-archive/channels/stable/release/2.2.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "78a2da74ea83ee092463a9901467492ef885f6e378353b0a44481fdf40ea81c7"
  end

  devel do
    version "2.2.1-dev.0.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.flutter-io.cn/dart-archive/channels/dev/release/2.2.1-dev.0.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "655d18897c958419ddc13c9adff3050ae4325b2d106063021c54d8ae8c5240f2"
    else
      url "https://storage.flutter-io.cn/dart-archive/channels/dev/release/2.2.1-dev.0.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "877ffa90ce6ce4d458ce98d3f07fb200fdd2d9ea87278f71147e92fffcb868fb"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<~EOS
    Please note the path to the Dart SDK:
      #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
