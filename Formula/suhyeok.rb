class Suhyeok < Formula
  desc "Command local Claude Code and Codex sessions from a pixel RPG guild hall"
  homepage "https://github.com/oyhoyhk/suhyeok"
  url "https://github.com/oyhoyhk/suhyeok/releases/download/v0.1.7/suhyeok-0.1.7-arm64.zip"
  sha256 "fdee91131b95f865fcfbb2eabf859447ebc252d84ea1eacb75ecf63e04f48ebd"
  version "0.1.7"

  depends_on arch: :arm64
  depends_on macos: :sonoma
  depends_on "tmux"

  def install
    # Homebrew enters a lone top-level directory when unpacking, so the bundle may arrive already opened.
    if File.directory?("Contents")
      (prefix/"수혁.app").install "Contents"
    else
      prefix.install "수혁.app"
    end
    (bin/"suhyeok").write <<~SH
      #!/bin/bash
      exec open "#{opt_prefix}/수혁.app" "$@"
    SH
  end

  def caveats
    <<~EOS
      Launch with:  suhyeok
      To show 수혁 in Launchpad and Spotlight:
        ln -sf "#{opt_prefix}/수혁.app" ~/Applications/수혁.app
    EOS
  end

  test do
    assert_predicate prefix/"수혁.app/Contents/MacOS/AgentDeck", :executable?
  end
end
