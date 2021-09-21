//
//  DDDynamicTableViewCell.h
//  Example
//
//  Created by daniel on 2021/9/15.
//  Copyright © 2021 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDDynamicTableViewCellModel : NSObject

@property (nonatomic, strong, nullable) UIImage *image;
@property (nonatomic, strong, nullable) NSString *text;
@property (nonatomic, strong, nullable) NSString *detailText;

@end

@interface DDDynamicTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *myImageView;
@property (nonatomic, strong, readonly) UILabel *myTextLabel;
@property (nonatomic, strong, readonly) UILabel *myDetailTextLabel;

@property (nonatomic, strong, nullable) DDDynamicTableViewCellModel *model;

@end

NS_ASSUME_NONNULL_END
