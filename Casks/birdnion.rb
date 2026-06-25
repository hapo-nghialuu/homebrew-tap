cask "birdnion" do
  version "0.1.0"

  # SHA256 của BirdNion-v0.1.0.zip
  # Tính bằng: shasum -a 256 ~/Desktop/BirdNion-v0.1.0.zip
  sha256 "7b517fb7d239ef225c5ad4443132bee2dd1b6089bf79c13dc170aed04e3c4284"

  url "https://github.com/hapo-nghialuu/homebrew-tap/releases/download/v#{version}/BirdNion-v#{version}.zip"
  name "BirdNion"
  desc "AI quota menu bar app — tracks MiniMax, Codex, Claude, Hapo AI Hub and more"
  homepage "https://github.com/hapo-nghialuu/ai-statusbar"

  livecheck do
    url :homepage
    strategy :github_latest_release
  end

  app "BirdNion.app"

  # Ad-hoc signed — recipients need to right-click → Open the first
  # time to bypass Gatekeeper. (Proper Developer ID notarization is
  # out of scope until the project has an Apple Developer Program
  # account.)
  zap trash: [
    "~/Library/Application Support/AIStatusbar",
    "~/Library/Preferences/com.local.aistatusbar.plist",
    "~/Library/Preferences/com.local.birdnion.plist",
  ]
end
