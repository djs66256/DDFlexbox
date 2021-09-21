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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
