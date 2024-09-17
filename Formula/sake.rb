class Sake < Formula
  desc "Swift-based utility for managing CLI command execution with dependencies and conditions, inspired by Make."
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "0.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-arm64-apple-macosx.zip"
      sha256 "921b1657852d2de1484bf0e46c82ff6f9362a25beeb683ea119f07c3e6db63ee"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-x86_64-apple-macosx.zip"
      sha256 "6651abad0705fb9205d6ac3f1150b119c1b4884746b6e9c717a33189e1df4fa1"
    end
  end

  def install
    bin.install "sake"
  end

  test do
    system "#{bin}/sake", "--help"
  end
end
