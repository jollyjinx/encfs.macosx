#!/bin/zsh

OSXFUSE="osxfuse-2.5.5"

if [[ ! -e /usr/local/bin/brew ]];
then 
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

if [[ ! -d /usr/local/include/osxfuse ]];
then
	if [[ ! -e $OSXFUSE ]];
	then
		curl -L "http://downloads.sourceforge.net/project/osxfuse/$OSXFUSE/$OSXFUSE.dmg?use_mirror=autoselect" -o $OSXFUSE.dmg
	fi
	
	if [[ ! -e $OSXFUSE.dmg ]];
	then
		echo "Can't find $OSXFUSE.dmg"
		exit 1;
	fi

	hdiutil attach $OSXFUSE.dmg -nobrowse -mountpoint osxfuse
	
	if [[ ! -e osxfuse/Install\ OSXFUSE\ 2.5.pkg ]];
	then
		echo "Can't find osxfuse/Install package"
		exit 1;
	fi
	
	echo "Installing OSXFuse requires admin privilges:"
	sudo installer  -pkg osxfuse/Install\ OSXFUSE\ 2.5.pkg -target  /
	hdiutil detach osxfuse
	rm -f $OSXFUSE.dmg
fi

cp encfsmacosxfuse.rb /usr/local/Library/Formula/
brew install encfsmacosxfuse


