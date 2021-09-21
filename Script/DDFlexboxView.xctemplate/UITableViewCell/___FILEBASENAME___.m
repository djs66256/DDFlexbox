//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

#import <DDFlexbox/DDFlexbox.h>
#import "___VARIABLE_productName___.h"

@interface ___VARIABLE_productName___ ()

@end

@implementation ___VARIABLE_productName___

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
    
    [self.flexbox setupLayout:^(id<DDFlexbox> _Nonnull box) {
        // config flexbox here.
    }];
}

@end
