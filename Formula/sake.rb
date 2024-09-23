class Sake < Formula
  desc "Swift-based utility for managing CLI command execution with dependencies and conditions, inspired by Make."
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "0.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-arm64-apple-macosx.zip"
      sha256 "027e89c5e0c5dde68796d37e975fe44ef34b1b8abbb7599ba9cb8750177ce845"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-x86_64-apple-macosx.zip"
      sha256 "e97eb3d6c3ff7c2bda1364fe46cea37709502422f6bd9b682f0d160c23f32673"
    end
  end

  def install
    bin.install "sake"
  end

  test do
    system "#{bin}/sake", "--help"
  end
end
