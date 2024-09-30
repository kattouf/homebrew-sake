class Sake < Formula
  desc "Swift-based utility for managing CLI command execution with dependencies and conditions, inspired by Make."
  homepage "https://github.com/kattouf/Sake"
  license "MIT"

  version = "0.1.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-arm64-apple-macosx.zip"
      sha256 "4efdabde2314151cc73690881905aa6c7d9aa18dcbbb01c570057548e3bb9f40"
    else
      url "https://github.com/kattouf/Sake/releases/download/#{version}/sake-#{version}-x86_64-apple-macosx.zip"
      sha256 "f1c98410cd91ff7077d64ab9bc737e9da5a8fac9e40cc4006d91758172b782b5"
    end
  end

  def install
    bin.install "sake"
  end

  test do
    system "#{bin}/sake", "--help"
  end
end
