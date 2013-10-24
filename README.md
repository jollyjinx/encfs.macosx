encFS with osxfuse
-------------------

1.7.4 Version of encfs (http://www.arg0.net/encfs) has problems with links on Mac OS X. This is a script to get a working version of encfs on Mavericks. Checkout git version 36d6c6cbd for a version that works on Mountain Lion.

It uses Homebrew (http://mxcl.github.com/homebrew/) and osxfuse (http://osxfuse.github.com).

The script does the following:
	- check if homebrew is installed and install it.
	- check if macosx.fuse is installed and install it.
	- install encmacosxfuse brew formula including patch in homebrew.
	- install encmacosxfuse by calling brew.

After that you should have a working encfs in /usr/local/bin/.

If you want to use it for your Dropbox Documents directory you could use it like this:

	encfs ~/Dropbox/Documents.encfs ~/Dropbox/Documents.secure -- -o volname="Documents"

