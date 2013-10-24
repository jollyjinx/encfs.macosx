#!/bin/zsh

OSXFUSE="osxfuse-2.6.1"

if [[ ! -e /usr/local/bin/brew ]];
then 
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
	/usr/local/bin/brew doctor
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
	
	if [[ ! -e osxfuse/Install\ OSXFUSE\ 2.6.pkg ]];
	then
		echo "Can't find osxfuse/Install package"
		exit 1;
	fi
	
	echo "Installing OSXFuse requires admin privilges:"
	sudo installer  -pkg osxfuse/Install\ OSXFUSE\ 2.6.pkg -target  /
	hdiutil detach osxfuse
	rm -f $OSXFUSE.dmg
	# OSXFuse changes permissions to some brew-managed directories; clean that up:
	sudo chown -R $USER\:admin /usr/local/include
	sudo chown -R $USER\:admin /usr/local/lib
	sudo chmod -R ug+rwX /usr/local/include
	sudo chmod -R ug+rwX /usr/local/lib
fi

cp encfsmacosxfuse.rb /usr/local/Library/Formula/
brew install encfsmacosxfuse


