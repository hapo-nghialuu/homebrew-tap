cask "birdnion" do
  version "0.1.1"

  # SHA256 của BirdNion-v0.1.1.zip
  # Tính bằng: shasum -a 256 ~/Desktop/BirdNion-v0.1.1.zip
  sha256 "9ddc3f1e7d50b968728bcce7ffcd30822e15991b4e8f5a492053113bb542cf21"

  url "https://github.com/hapo-nghialuu/homebrew-tap/releases/download/v#{version}/BirdNion-v#{version}.zip"
  name "BirdNion"
  desc "AI quota menu bar app — tracks MiniMax, Codex, Claude, Hapo AI Hub and more"
  homepage "https://github.com/hapo-nghialuu/ai-statusbar"

  livecheck do
    url :homepage
    strategy :github_latest_release
  end

  app "BirdNion.app"

  # Ad-hoc signed, so macOS Gatekeeper blocks the first launch with
  # "Apple could not verify … is free of malware". Strip the
  # quarantine flag automatically after the cask copies the app into
  # /Applications so users don't have to Right-click → Open the
  # first time. Until we get a Developer ID + notarization, this is
  # the cleanest free UX we can offer.
  post_install do
    system_command "/usr/bin/xattr",
                  args: ["-dr", "com.apple.quarantine", "#{staged_path}/BirdNion.app"]
    system_command "/usr/bin/open",
                  args: ["-a", "#{staged_path}/BirdNion.app"]
  end

  zap trash: [
    "~/Library/Application Support/AIStatusbar",
    "~/Library/Preferences/com.local.aistatusbar.plist",
    "~/Library/Preferences/com.local.birdnion.plist",
  ]
end
