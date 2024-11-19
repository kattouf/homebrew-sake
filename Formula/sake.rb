class Sake < Formula
  desc "Swift-based utility for managing project commands, inspired by Make"
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "0.2.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-arm64-apple-macosx.zip"
      sha256 "6ae02d01b1387c12d52257cbc961858225c392faaf9d1e1c87db6eb4f3ae9a0a"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-apple-macosx.zip"
      sha256 "b148e4b5c49359a55cf8d06d823438cdec0fb525afd303b3b11a06d5eac2c45b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-aarch64-unknown-linux-gnu.zip"
      sha256 "7fb1af54bfa14ec03e8d644742952189e62727dfcfd73babb33585d12f9889ba"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-unknown-linux-gnu.zip"
      sha256 "60b2a18cf2145d02b58022c4ec0a8dcbb4b35866bbc368b95e21da78c384711a"
    end
  end

  def install
    bin.install "sake"
  end

  def caveats
    return if system("swift --version > /dev/null 2>&1")

    if OS.linux?
      <<~EOS
        This tool requires Swift to be installed.
        Please download and install Swift from the official website:
        https://swift.org/download#releases
      EOS
    elsif OS.mac?
      <<~EOS
        This tool requires Swift to be installed.
        On macOS, you can install Swift via:
          1. Xcode: Swift is included with Xcode, which can be downloaded from the App Store.
          2. Homebrew: brew install swift
        Alternatively, download Swift directly from the official website:
        https://swift.org/download#releases
      EOS
    end
  end

  test do
    system bin/"sake", "--help"
  end
end
