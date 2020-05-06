class TincAT11 < Formula
  desc "Virtual Private Network (VPN) tool"
  homepage "https://www.tinc-vpn.org/"
  url "https://tinc-vpn.org/packages/tinc-1.1pre17.tar.gz"
  sha256 "61b9c9f9f396768551f39216edcc41918c65909ffd9af071feb3b5f9f9ac1c27"

  depends_on "lzo"
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  # fix openssl usage
  patch do
    url "https://raw.githubusercontent.com/xen0n/homebrew-tinc-1.1/fd288b7fb2ae1d00970d0f6676d7ba2eae68601b/patches/0025-fix-use-EVP_DecryptUpdate-while-decrypting.patch"
    sha256 "57dc7938ae31467da5bc7d139d0ec118c5e3e81809b00f9321c5fefbe1dae3c5"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{etc}",
                          "--with-openssl=#{Formula["openssl@1.1"].opt_prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/tincd --version")
  end
end
