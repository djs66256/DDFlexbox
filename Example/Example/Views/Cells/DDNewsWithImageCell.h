//
//  DDNewsWithImageCell.h
//  Example
//
//  Created by daniel on 2021/9/17.
//  Copyright © 2021 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDNewsWithImageCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray<UIImageView *> *imageViews;
@property (nonatomic, strong) UILabel *detailDescLabel;

@end

NS_ASSUME_NONNULL_END
