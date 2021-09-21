//
//  DDChatTableViewCell.m
//  Example
//
//  Created by daniel on 2021/9/17.
//  Copyright © 2021 daniel. All rights reserved.
//

#import <DDFlexbox/DDFlexbox.h>
#import "DDChatTableViewCell.h"

@interface DDChatTableViewCell ()

@end

@implementation DDChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarImageView = [UIImageView new];
        _avatarImageView.layer.cornerRadius = 5;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.backgroundColor = [UIColor grayColor];
        
        _unreadView = [UIImageView new];
        _unreadView.backgroundColor = [UIColor redColor];
        _unreadView.layer.cornerRadius = 5;
        _unreadView.clipsToBounds = YES;
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont boldSystemFontOfSize:17];
        _nameLabel.text = @"Swift 高手交流群";
        
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont boldSystemFontOfSize:12];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.text = @"昨天";
        
        _descLabel = [UILabel new];
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.textColor = [UIColor lightGrayColor];
        _descLabel.text = @"[6条]福建省政府新闻办召开疫情防控工作新闻发布会，通报疫情防控最新情况。";
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
    
    [self.flexbox.row setupLayout:^(id<DDFlexbox> _Nonnull box) {
        box.paddingVertical = YGPointValue(10);
        box.paddingHorizontal = YGPointValue(20);
        box.alignItems = YGAlignStretch;
        
        [DDFlexbox.new setupLayout:^(id<DDFlexbox>  _Nonnull box) {
            static const CGFloat imageWidth = 40;
            static const CGFloat imageHeight = 40;
            box.width = YGPointValue(imageWidth);
            box.height = YGPointValue(imageHeight);
            
            [self.avatarImageView.flexbox.absolute setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                box.width = box.height = YGPercentValue(100);
            }];
            
            [self.unreadView.flexbox.absolute setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                box.width = box.height = YGPointValue(10);
                box.right = box.top = YGPointValue(-4);
            }];
        }];

        [DDFlexbox blockerWithWidth:10];
        
        [DDFlexbox.column setupLayout:^(id<DDFlexbox>  _Nonnull box) {
            box.flexGrow = box.flexShrink = 1;
            
            [DDFlexbox.row setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                [self.nameLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                    box.flexGrow = 1;
                }];
                
                [self.timeLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                    
                }];
            }];
            
            [DDFlexbox blockerWithHeight:5];
            
            [self.descLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                
            }];
        }];
    }];
}

@end
