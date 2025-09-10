class Sake < Formula
  desc "Swift-based utility for managing project commands, inspired by Make"
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "1.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-arm64-apple-macosx.zip"
      sha256 "78592ac8d802e0c795ab1b406a7bb5567a8304fafa8a71b0255b177b73fcc668"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-apple-macosx.zip"
      sha256 "0df752452e10d99205ffb32cff4922f7c462c078b5042febfc11839b8c7263e9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-aarch64-unknown-linux-gnu.zip"
      sha256 "e5e45a2f7aa5feedb226484f1af4baef3c2bc8e038c76a667a6e2667db335a8f"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-unknown-linux-gnu.zip"
      sha256 "c5067e58c415ed11d7827a797361d1f20583ebde9868bba3eefde214dcf086db"
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
