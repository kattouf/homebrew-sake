class Sake < Formula
  desc "Swift-based utility for managing project commands, inspired by Make"
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "0.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-arm64-apple-macosx.zip"
      sha256 "a5e7e17d22c9dc6f0b1c2e6a31bffdbe390154ab3bc8592d89172ec6a9360314"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-apple-macosx.zip"
      sha256 "cc2e114f43a4a9551c312e2bad2077c252d009c9ef219aa64d924c069243b1a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-aarch64-unknown-linux-gnu.zip"
      sha256 "8fc62699181947ca4b409387dd6267c6541d93ddf0b02f2a663a36ac69dc6af1"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-unknown-linux-gnu.zip"
      sha256 "daf134f90d56bb70d766173157c44876162fb4f487e32bc7c9e6199148dcd07b"
    end
  end

  def install
    bin.install "sake"
  end

  require "open3"

  def post_install
    stdout, _, status = Open3.capture3("swift --version")
    warn_missing_swift if !status.success? || stdout.strip.empty?
  rescue Errno::ENOENT
    warn_missing_swift
  end

  def warn_missing_swift
    if OS.linux?
      opoo <<~EOS
        Swift is not installed. Please install Swift to use this tool.
        The recommended way is to install it via Homebrew:
          brew install swift
        Alternatively, you can download it from the official website:
          https://swift.org/download#releases

        After installation, ensure that the Swift runtime libraries are available by setting:
          export LD_LIBRARY_PATH=$(swift -print-target-info | jq -r ".paths.runtimeLibraryPaths[]"):$LD_LIBRARY_PATH

        To make this permanent, add the above command to your shell configuration file (e.g., ~/.bashrc or ~/.zshrc).
      EOS
    elsif OS.mac?
      opoo <<~EOS
        Swift is not installed. Please install Swift to use this tool.
        On macOS, you can install Swift via:
          1. Xcode: Swift is included with Xcode, which can be downloaded from the App Store.
          2. Homebrew: brew install swift
        Alternatively, download it from the official website:
          https://swift.org/download#releases
      EOS
    end
  end

  test do
    system bin/"sake", "--help"
  end
end
