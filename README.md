encFS with osxfuse
==================

Be aware that the patches are already inside the official homebrew encfs package. So no need to use this if you are on Mavericks. For 10.8 it might be helpful.

1.7.4 Version of encfs (http://www.arg0.net/encfs) has problems with links on Mac OS X. This is a script to get a working version of encfs on Mavericks. Checkout git version 36d6c6cbd for a version that works on Mountain Lion.

It uses Homebrew (http://mxcl.github.com/homebrew/) and osxfuse (http://osxfuse.github.com).

Installing with Homebrew
------------------------

    brew update              && \
    brew tap jollyjinx/encfs && \
    brew install jollyjinx/encfs/encfs

Be sure to follow the instructions in the caveats for osxfuse, similar to:

> The new osxfuse file system bundle needs to be installed by the root user:
>
>     sudo /bin/cp -RfX /usr/local/Cellar/osxfuse/2.6.2/Library/Filesystems/osxfusefs.fs /Library/Filesystems
>     sudo chmod +s /Library/Filesystems/osxfusefs.fs/Support/load_osxfusefs

After that you should have a working encfs in /usr/local/bin/.

Example
-------

If you want to use it for your Dropbox Documents directory you could use it like this:

    encfs ~/Dropbox/Documents.encfs ~/Documents.secure -- -o volname="Documents"
