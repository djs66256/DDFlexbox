//
//  DDNewsWithImageCell.m
//  Example
//
//  Created by daniel on 2021/9/17.
//  Copyright © 2021 daniel. All rights reserved.
//

#import <DDFlexbox/DDFlexbox.h>
#import "DDNewsWithImageCell.h"

@interface DDNewsWithImageCell ()

@end

@implementation DDNewsWithImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"习近平出席上合组织会议 出席阿富汗问题联合峰会";
        
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [UIImageView new];
            imageView.backgroundColor = [UIColor grayColor];
            [array addObject:imageView];
        }
        _imageViews = array.copy;
        
        _detailDescLabel = [UILabel new];
        _detailDescLabel.font = [UIFont systemFontOfSize:12];
        _detailDescLabel.textColor = [UIColor lightGrayColor];
        _detailDescLabel.text = @"2021-09-17 22:12:34　来源: 央视网";
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.flexbox layoutSubviews];
}

- (CGSize)intrinsicContentSize {
    return [self.flexbox intrinsicContentSize];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self.flexbox sizeThatFits:size];
}

- (void)updateFlexboxLayout {
    [super updateFlexboxLayout];
    
    [self.flexbox.column setupLayout:^(id<DDFlexbox> _Nonnull box) {
        box.paddingVertical = YGPointValue(10);
        box.paddingHorizontal = YGPointValue(20);
        
        [_titleLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
            
        }];
        
        [DDFlexbox blockerWithHeight:5];
        
        [DDFlexbox.row setupLayout:^(id<DDFlexbox>  _Nonnull box) {
            box.alignItems = YGAlignStretch;
            
            for (UIImageView *imageView in self.imageViews) {
                if (imageView != self.imageViews.firstObject) {
                    [DDFlexbox blockerWithWidth:5];
                }
                [imageView.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                    box.flexGrow = 1;
                    box.aspectRatio = 1;
                }];
            }
        }];
        
        [DDFlexbox blockerWithHeight:5];
        
        [_detailDescLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
            
        }];
    }];
}

@end
