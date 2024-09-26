class Sake < Formula
  desc "Swift-based utility for managing CLI command execution with dependencies and conditions, inspired by Make."
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "0.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-arm64-apple-macosx.zip"
      sha256 "5851241993c8735bf29de08d263f8aaf69f55369f9ed1c5ee12dd902305030fa"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-x86_64-apple-macosx.zip"
      sha256 "1959637824f48dfd0e9e7d4f406b148339995204205103c6db56673c336e6a3b"
    end
  end

  def install
    bin.install "sake"
  end

  test do
    system "#{bin}/sake", "--help"
  end
end
