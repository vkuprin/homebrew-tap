class Ralph < Formula
  desc "Long-running Claude Code loop: fresh claude -p each iteration, gated by git"
  homepage "https://github.com/vkuprin/ralph-harness"
  url "https://github.com/vkuprin/ralph-harness/archive/refs/tags/v2.3.1.tar.gz"
  sha256 "fd06aeb920f8bd7a22b28a098ee881af813ce96c372187eccf5f68a1e69b98ba"
  license "MIT"

  depends_on "bun"

  def install
    # ralph runs from its source tree: the loop is spawned as src/loop/main.ts
    # and the hooks run as files, so these ship as they are, not compiled.
    libexec.install "bin", "src", "hooks", "template", "skills", "package.json"
    bin.install_symlink libexec/"bin/ralph"
  end

  def caveats
    <<~EOS
      ralph also needs the claude CLI on PATH.

      After upgrading ralph or bun, restart running loops:
        ralph stop NAME && ralph start NAME

      For /ralph-new in any Claude session:
        ln -s #{opt_libexec}/skills/ralph-new ~/.claude/skills/ralph-new
    EOS
  end

  test do
    assert_match "ralph #{version}", shell_output("#{bin}/ralph --version")
  end
end
