class Suhyeok < Formula
  desc "Command local Claude Code and Codex sessions from a pixel RPG guild hall"
  homepage "https://github.com/oyhoyhk/suhyeok"
  url "https://github.com/oyhoyhk/suhyeok/releases/download/v0.1.6/suhyeok-0.1.6-arm64.zip"
  sha256 "0071ef2429b6f6b96daf28181a624f64d0bcc887852fa4b9109862bc20f6f2be"
  version "0.1.6"

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
