cask "dau" do
  version "0.1.8"
  sha256 "c0b645eb0f77e564bf4c0918e70eb5f27b38d5dd4e9e54c61fd60d86465b5307"

  url "https://github.com/hapo-nghialuu/dau/releases/download/v#{version}/Dau-#{version}.zip"
  name "Dấu"
  desc "Vietnamese input method (Telex & VNI) for macOS, offline and private"
  homepage "https://github.com/hapo-nghialuu/dau"

  depends_on macos: :ventura

  livecheck do
    url :homepage
    strategy :github_latest_release
  end

  app "Dau.app"

  # Ad-hoc signed, not notarized. postflight strips the Gatekeeper quarantine
  # flag so a Homebrew install can open without Right-click → Open. This does
  # NOT grant Accessibility / Input Monitoring, which users must still enable
  # manually in System Settings (docs/release-macos.md).
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/Dau.app"]
  end

  caveats <<~EOS
    This build is ad-hoc signed and not notarized. Gatekeeper quarantine is
    cleared automatically by the cask postflight; if the app still won't open,
    right-click Dau.app in Finder → Open. Grant Accessibility + Input Monitoring
    in System Settings → Privacy & Security.
  EOS
end
