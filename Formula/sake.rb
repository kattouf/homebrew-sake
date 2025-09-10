class Sake < Formula
  desc "Swift-based utility for managing project commands, inspired by Make"
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "1.0.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-arm64-apple-macosx.zip"
      sha256 "4294014a5450956f85177610f5c87de6c51cfc39d104aa898fc8d7258b3ebf02"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-apple-macosx.zip"
      sha256 "65b8b04147c7d6aa270f5bc209ade82879de62951ca0863624645f2113840b73"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-aarch64-unknown-linux-gnu.zip"
      sha256 "4dbcc8efd02c4d12995c181671e07f3e7d208b3bc843461e54a5e78ae477fff1"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-unknown-linux-gnu.zip"
      sha256 "384616cbe99ca5fa6304617ac859906cdfdc386f2053ddc09a4b2bdd6ebfb80f"
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
