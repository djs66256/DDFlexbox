//
//  DDPushStyleTableCell.m
//  Example
//
//  Created by daniel on 2021/9/18.
//  Copyright © 2021 daniel. All rights reserved.
//

#import <DDFlexbox/DDFlexbox.h>
#import "DDPushStyleTableCell.h"

@interface DDPushStyleTableCell ()

@end

@implementation DDPushStyleTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconImageView = [UIImageView new];
        _iconImageView.layer.cornerRadius = 5;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.backgroundColor = [UIColor redColor];
        
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont boldSystemFontOfSize:12];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.text = @"网易新闻";
        
        
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont boldSystemFontOfSize:12];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.text = @"昨天 下午10:01";
        
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont boldSystemFontOfSize:15];
        _contentLabel.numberOfLines = 3;
        _contentLabel.text = @"“因为我是从国外回来的，正好我们被检测的家长当中只有我一人是国外返莆人员，所以我被怀疑成为本轮疫情的源头。”林某某说，“我结束居家隔离后我妻子出现了咳嗽、鼻塞等感冒症状，因为没有发烧，当时我们就以为只是普通感冒，也没有去看医生。”";
        
        _contentImageView = [UIImageView new];
        _contentImageView.layer.cornerRadius = 5;
        _contentImageView.clipsToBounds = YES;
        _contentImageView.backgroundColor = [UIColor greenColor];
        
        
        _detailDescLabel = [UILabel new];
        _detailDescLabel.font = [UIFont systemFontOfSize:12];
        _detailDescLabel.textColor = [UIColor lightGrayColor];
        _detailDescLabel.text = @"还有10个通知";
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
        
        [DDFlexbox.row setupLayout:^(id<DDFlexbox>  _Nonnull box) {
            box.alignItems = YGAlignCenter;
            
            [self.iconImageView.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                box.width = box.height = YGPointValue(20);
            }];
            
            [DDFlexbox blockerWithWidth:5];
            
            [self.nameLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                box.flexShrink = box.flexGrow = 1;
            }];
            
            [DDFlexbox blockerWithWidth:5];
            
            [self.timeLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                
            }];
        }];

        [DDFlexbox blockerWithHeight:10];
        
        [DDFlexbox.row setupLayout:^(id<DDFlexbox>  _Nonnull box) {
            [self.contentLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                box.flexGrow = box.flexShrink = 1;
            }];
            
            [DDFlexbox blockerWithWidth:10];
            
            [self.contentImageView.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                box.width = box.height = YGPointValue(35);
            }];
        }];

        [DDFlexbox blockerWithHeight:10];
        
        [self.detailDescLabel.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
            
        }];
    }];
}

@end
