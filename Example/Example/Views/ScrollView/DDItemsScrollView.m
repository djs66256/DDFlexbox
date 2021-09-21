//
//  DDItemsScrollView.m
//  Example
//
//  Created by daniel on 2021/9/15.
//  Copyright © 2021 daniel. All rights reserved.
//

#import <DDFlexbox/DDFlexbox.h>
#import "DDItemsScrollView.h"

@interface DDItemsScrollView ()

@property (nonatomic, strong) NSArray<UIView *> *itemViews;

@end

@implementation DDItemsScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setupItemViews {
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        UIView *view = [UIView new];
        view.layer.cornerRadius = 5;
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor colorWithRed:(random()%255)/255.
                                               green:(random()%255)/255.
                                                blue:(random()%255)/255.
                                               alpha:1];
        
        [array addObject:view];
    }
    self.itemViews = array.copy;
    [self setNeedsUpdateFlexboxLayout];
    [self updateFlexboxLayoutIfNeeded];
    
    CGSize size = [self.flexbox sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    self.contentSize = size;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsUpdateFlexboxLayout];
    [self updateFlexboxLayoutIfNeeded];
    
    CGSize size = [self.flexbox sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    self.contentSize = size;
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
        box.padding = YGPointValue(5);
        box.flexWrap = YGWrapWrap;
        
        for (UIView *view in self.itemViews) {
            [view.flexbox setupLayout:^(id<DDFlexbox>  _Nonnull box) {
                box.margin = YGPointValue(5);
                box.width = box.height = YGPointValue(80);
            }];
        }
    }];
}

@end
