#!/bin/sh

if [ -d ~/Library/Developer/Xcode/Templates/Project\ Templates/DDKit/DDFlexboxView.xctemplate ]; then
    rm -rf ~/Library/Developer/Xcode/Templates/Project\ Templates/DDKit/DDFlexboxView.xctemplate
fi

mkdir -p ~/Library/Developer/Xcode/Templates/Project\ Templates/DDKit
cp -r ./DDFlexboxView.xctemplate ~/Library/Developer/Xcode/Templates/Project\ Templates/DDKit/DDFlexboxView.xctemplate
