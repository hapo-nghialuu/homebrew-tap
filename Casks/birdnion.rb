cask "birdnion" do
  version "0.3.1"
  sha256 "63b97244651db265655003959f445a50da877dc0c5c5efa3fb92f108ef12a7ad"

  url "https://github.com/hapo-nghialuu/BirdNion/releases/download/v#{version}/BirdNion-#{version}.zip"
  name "BirdNion"
  desc "AI quota menu bar app — tracks MiniMax, Codex, Claude, Hapo AI Hub and more"
  homepage "https://github.com/hapo-nghialuu/BirdNion"

  livecheck do
    url :homepage
    strategy :github_latest_release
  end

  depends_on :macos

  app "BirdNion.app"

  # Ad-hoc signed, so macOS Gatekeeper blocks the first launch with
  # "Apple could not verify … is free of malware". Strip the
  # quarantine flag automatically after the cask copies the app into
  # /Applications so users don't have to Right-click → Open the
  # first time. Until we get a Developer ID + notarization, this is
  # the cleanest free UX we can offer.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/BirdNion.app"]
  end

  zap trash: [
    # BirdNion config + tokens
    "~/.config/birdnion",
    "~/.birdnion",
    "~/Library/Preferences/com.local.birdnion.plist",
    # Legacy (old app name AIStatusbar — kept for migration cleanup)
    "~/Library/Application Support/AIStatusbar",
    "~/Library/Preferences/com.local.aistatusbar.plist",
  ]
end
