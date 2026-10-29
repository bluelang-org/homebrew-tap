# The Homebrew formula for Blue. The release workflow fills in https://github.com/bluelang-org/releases/releases/download/v0.7.0-rc.2/blue-0.7.0-rc.2.tar.gz,
# b523beb6cd8d299758bcd5c67d7134b151dc8f5741d5bf2811c19b49a3d58e2f and 0.7.0-rc.2 and pushes it to the tap. It installs the portable
# download (Java bytecode) and runs it with Homebrew's own openjdk, as
# homebrew-core asks of JVM software, so moving it to core needs no rewrite.
class Blue < Formula
  desc "Language for durable, distributed programs: actors, effects and streams"
  homepage "https://bluelang.org"
  url "https://github.com/bluelang-org/releases/releases/download/v0.7.0-rc.2/blue-0.7.0-rc.2.tar.gz"
  sha256 "b523beb6cd8d299758bcd5c67d7134b151dc8f5741d5bf2811c19b49a3d58e2f"
  version "0.7.0-rc.2"
  # license "Apache-2.0"   # when the licence is decided

  depends_on "openjdk"

  def install
    libexec.install "bin", "lib"
    (bin/"blue").write_env_script libexec/"bin/blue", BLUE_JAVA_HOME: Language::Java.java_home
  end

  test do
    assert_match "Blue #{version}", shell_output("#{bin}/blue --version")
    (testpath/"hello.blue").write "fn main () = print \"hello\"\n"
    assert_equal "hello", shell_output("#{bin}/blue run hello.blue").strip
  end
end
