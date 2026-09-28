class Ralph < Formula
  desc "Ralph loop for Claude Code: fresh claude -p per iteration, git decides what shipped"
  homepage "https://github.com/vkuprin/ralph-harness"
  url "https://github.com/vkuprin/ralph-harness/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "42b8dde838e009e546bdbda8aeccbadef67fb2731ecc6d53710f9281d6abaad4"
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
