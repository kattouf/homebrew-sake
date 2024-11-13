class Sake < Formula
  desc "Swift-based utility for managing CLI command execution with dependencies and conditions, inspired by Make."
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "0.2.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-arm64-apple-macosx.zip"
      sha256 "9f6ec4599f904a7b1fd9fde09f91fcacc42418de7ed6017e5fce2b6f6236bbcb"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-apple-macosx.zip"
      sha256 "e3fb32bb458ddf4ccc6223cef1e10bd4680a77d25e7c46a7b41cf4a0ec85d92c"
    end
  end

  def install
    bin.install "sake"
  end

  test do
    system "#{bin}/sake", "--help"
  end
end
