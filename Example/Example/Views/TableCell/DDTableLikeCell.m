//
//  DDTableLikeCell.m
//  Example
//
//  Created by daniel on 2021/9/15.
//  Copyright © 2021 daniel. All rights reserved.
//

#import <DDFlexbox/DDFlexbox.h>
#import "DDTableLikeCell.h"

@interface DDTableLikeCell ()

@end

@implementation DDTableLikeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _myImageView = [UIImageView new];
        _myImageView.layer.cornerRadius = 5;
        _myImageView.clipsToBounds = YES;
        _myImageView.backgroundColor = [UIColor redColor];
        
        _myTextLabel = [UILabel new];
        _myTextLabel.font = [UIFont boldSystemFontOfSize:20];
        _myTextLabel.text = @"My title label";
        _myTextLabel.backgroundColor = [UIColor grayColor];
        
        _myDetailTextLabel = [UILabel new];
        _myDetailTextLabel.font = [UIFont systemFontOfSize:14];
        _myDetailTextLabel.text = @"My detail text label";
        _myDetailTextLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Must trigger off layout here.
    [self.flexbox layoutSubviews];
}

// It is useful when using AutoLayout.
- (CGSize)intrinsicContentSize {
    return [self.flexbox intrinsicContentSize];
}

// It is useful when layout.
- (CGSize)sizeThatFits:(CGSize)size {
    return [self.flexbox sizeThatFits:size];
}

- (void)updateFlexboxLayout {
    [super updateFlexboxLayout];
    
    /*
     Flexbox Layout:
     
     +-(flex-row)---------------------------------------------------------------------------+
     |                                   +-(flex-column)-------------+                      |
     |            +-------+              |                           |                      |
     |-padding(10)-|<image>| blocker(10) |<[My text label]>          | spacer -padding(10)- |
     |            |       |              |<[My detail text label]>   |                      |
     |            +-------+              |                           |                      |
     |                                   +---------------------------+                      |
     +--------------------------------------------------------------------------------------+
     */
    
    // Container flexbox binding self.contentView
    [self.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
        // First we need a padding in the content at all edges.
        static const CGFloat contentPadding = 10;
        box.padding = YGPointValue(contentPadding);
        
        // The image and text are in a row, so we setup a row container without bind any view.
        // It is a virtual node, don't worry about the view inside, those will add to super view accurately.
        [DDFlexbox.row setupLayout:^(id<DDFlexbox>  _Nonnull box) {
            // We need all items center at vertical.
            box.alignItems = YGAlignCenter;
            
            [self.myImageView.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                // Our image's size is (40, 40)
                static const CGFloat imageWidth = 40;
                static const CGFloat imageHeight = 40;
                box.width = YGPointValue(imageWidth);
                box.height = YGPointValue(imageHeight);
            }];
            
            // Now we add a blocker between image and text, otherwise they are too close.
            static const CGFloat spacingBetweenImageAndText = 10;
            [DDFlexbox blockerWithWidth:spacingBetweenImageAndText];
            
            // The two labels are in a column.
            [DDFlexbox.column setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                [self.myTextLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                    // We don't need config anything, but setup layout is neccessory.
                    // So we can add to the super node.
                }];
                [self.myDetailTextLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                    
                }];
            }];
            
            // We need a spacer at last.
            [DDFlexbox spacer];
        }];
    }];
}

@end
