class Sake < Formula
  desc "Swift-based utility for managing CLI command execution with dependencies and conditions, inspired by Make."
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "0.1.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-arm64-apple-macosx.zip"
      sha256 "81b5b58fa10f514cca355b41148bac308c7c570dc46f222cc6f22e0cf7ca0dec"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-apple-macosx.zip"
      sha256 "3f0d44e1e5305b02fdd83e77beaac4d99a0cf09d78d3601959bb0659b062e503"
    end
  end

  def install
    bin.install "sake"
  end

  test do
    system "#{bin}/sake", "--help"
  end
end
