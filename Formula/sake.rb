class Sake < Formula
  desc "Swift-based utility for managing CLI command execution with dependencies and conditions, inspired by Make."
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "0.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-arm64-apple-macosx.zip"
      sha256 "b8788e09de95c70e70ce8a39bad96466b81674a4a107e1f1378687ace2dc53ac"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-apple-macosx.zip"
      sha256 "ddff47dd7c36848aa28d5db956fac9009c8862463784a5e73f8997934ce871f6"
    end
  end

  def install
    bin.install "sake"
  end

  test do
    system "#{bin}/sake", "--help"
  end
end
