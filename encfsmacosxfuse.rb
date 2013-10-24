require 'formula'

class Encfsmacosxfuse < Formula
  version "1.7.4p2"
  homepage 'http://www.arg0.net/encfs'
  url 'http://encfs.googlecode.com/files/encfs-1.7.4.tgz'
  sha1 '3d824ba188dbaabdc9e36621afb72c651e6e2945'

  depends_on 'pkg-config' => :build
  depends_on 'gettext'
  depends_on 'boost'
  depends_on 'rlog'

  def patches
    # fixes link times and xattr on links for mac os x
    DATA
  end

  def install
    ENV['CPPFLAGS'] = '-I/usr/local/include/osxfuse -stdlib=libstdc++'
    ENV['LDFLAGS'] = '-stdlib=libstdc++'
	system "mkdir encfs/sys"
	system "cp \"$HOMEBREW_SDKROOT/usr/include/sys/_endian.h\" encfs/sys/endian.h"
    inreplace "configure", "-lfuse", "-losxfuse"
	inreplace "configure", "include <memory.h>", "include <tr1/memory.h>"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-boost=#{HOMEBREW_PREFIX}"
    system "make"
    system "make install"
  end

  def caveats; <<-EOS.undent
    Make sure to install osxfuse (successor to fuse4x)
    Can be downloaded at http://osxfuse.github.com/
    EOS
  end
end



__END__
diff --git a/encfs/encfs.cpp b/encfs/encfs.cpp
index dac15bd..911728a 100644
--- a/encfs/encfs.cpp
+++ b/encfs/encfs.cpp
@@ -489,7 +489,11 @@ int encfs_rename(const char *from, const char *to)
 
 int _do_chmod(EncFS_Context *, const string &cipherPath, mode_t mode)
 {
+#ifdef __APPLE__
+    return lchmod( cipherPath.c_str(), mode );
+#else
     return chmod( cipherPath.c_str(), mode );
+#endif
 }
 
 int encfs_chmod(const char *path, mode_t mode)
@@ -706,7 +710,11 @@ int encfs_statfs(const char *path, struct statvfs *st)
 int _do_setxattr(EncFS_Context *, const string &cyName, 
 	tuple<const char *, const char *, size_t, uint32_t> data)
 {
-    int options = 0;
+#ifdef __APPLE__
+    int options = XATTR_NOFOLLOW;
+#else
+	int options = 0;
+#endif
     return ::setxattr( cyName.c_str(), data.get<0>(), data.get<1>(), 
 	    data.get<2>(), data.get<3>(), options );
 }
diff --git a/configure.ac b/configure.ac
index 72d3b9b..2307f42 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,7 +1,7 @@
 dnl Process this file with autoconf to produce a configure script.
 
 AC_INIT(encfs/encfs.h) dnl a source file from your sub dir
-AM_INIT_AUTOMAKE(encfs, 1.7.4) dnl searches for some needed programs
+AM_INIT_AUTOMAKE(encfs, 1.7.4p2) dnl searches for some needed programs
 
 AC_CANONICAL_HOST
 AM_CONDITIONAL([DARWIN],
diff --git a/configure b/configure
index 91b8f15..1bec2e8 100755
--- a/configure
+++ b/configure
@@ -2990,7 +3003,7 @@ fi
 
 # Define the identity of the package.
  PACKAGE=encfs
- VERSION=1.7.4
+ VERSION=1.7.4p2
 
 
 cat >>confdefs.h <<_ACEOF

