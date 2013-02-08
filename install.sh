#!/bin/zsh

if [[ ! -e /usr/local/bin/brew ]];
then 
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

if [[ ! -d /usr/local/include/osxfuse ]];
then
	if [[ ! -e OSXFUSE-2.5.4.dmg ]];
	then
		curl -L 'https://github.com/downloads/osxfuse/osxfuse/OSXFUSE-2.5.4.dmg' -o OSXFUSE-2.5.4.dmg
	fi
	
	if [[ ! -e OSXFUSE-2.5.4.dmg ]];
	then
		echo "Can't find OSXFUSE-2.5.4.dmg"
		exit 1;
	fi

	hdiutil attach OSXFUSE-2.5.4.dmg -nobrowse -mountpoint osxfuse
	
	if [[ ! -e osxfuse/Install\ OSXFUSE\ 2.5.pkg ]];
	then
		echo "Can't find osxfuse/Install\ OSXFUSE\ 2.5.pkg"
		exit 1;
	fi
	
	echo "Installing OSXFuse requires admin privilges:"
	sudo installer  -pkg osxfuse/Install\ OSXFUSE\ 2.5.pkg -target  /
	hdiutil detach osxfuse
	rm -f OSXFUSE-2.5.4.dmg
fi

cp encfsmacosxfuse.rb /usr/local/Library/Formula/
brew install encfsmacosxfuse


