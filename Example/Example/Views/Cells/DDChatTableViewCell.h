//
//  DDChatTableViewCell.h
//  Example
//
//  Created by daniel on 2021/9/17.
//  Copyright © 2021 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDChatTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *avatarImageView;
@property (nonatomic, strong, readonly) UIImageView *unreadView;
@property (nonatomic, strong, readonly) UILabel *nameLabel;
@property (nonatomic, strong, readonly) UILabel *timeLabel;
@property (nonatomic, strong, readonly) UILabel *descLabel;


@end

NS_ASSUME_NONNULL_END
