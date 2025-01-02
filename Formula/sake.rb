class Sake < Formula
  desc "Swift-based utility for managing project commands, inspired by Make"
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-arm64-apple-macosx.zip"
      sha256 "3b031e70a8f0612288b5c8da1250ca86b5a89d576124dd1b319726e6787735bb"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-apple-macosx.zip"
      sha256 "20928b595be83b214c2e31cd4536c5d68def5fec516e44e10448b412f70d70ab"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-aarch64-unknown-linux-gnu.zip"
      sha256 "8bbc2b2f47074873a4e8c5d54767df79cf5a1b40e53a96a301ed8fdb69958c3b"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-unknown-linux-gnu.zip"
      sha256 "0ada978fa830d4269bdbc977d29a887add71f062817e017cfea2891f05442bca"
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
