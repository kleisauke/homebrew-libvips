class Vips < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.9.1/vips-8.9.1.tar.gz"
  sha256 "45633798877839005016c9d3494e98dee065f5cb9e20f4552d3b315b8e8bce91"

  # This formula is compiled from source, so there are no bottles.
  bottle :unneeded

  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "gettext"
  depends_on "giflib"
  depends_on "glib"
  depends_on "jpeg-turbo"
  depends_on "libexif"
  depends_on "libgsf"
  depends_on "libpng"
  depends_on "librsvg"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "orc"
  depends_on "pango"
  depends_on "webp"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-jpeg-includes=#{Formula["jpeg-turbo"].opt_include}
      --with-jpeg-libraries=#{Formula["jpeg-turbo"].opt_lib}
      --without-ppm
      --without-analyze
      --without-radiance
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/vips", "-l"
    cmd = "#{bin}/vipsheader -f width #{test_fixtures("test.png")}"
    assert_equal "8", shell_output(cmd).chomp
  end
end
