//
//  DDFlexboxIsolate.m
//  DDFlexbox
//
//  Created by Daniel on 2019/11/12.
//

#import "DDFlexboxIsolate.h"
#import "DDFlexbox+Private.h"

@implementation DDFlexboxIsolate

- (instancetype)initWithNode:(DDFlexbox *)box
{
    self = [super init];
    if (self) {
        _flexbox = box;
        YGNodeCopyStyle(self.node, box.node);
    }
    return self;
}

- (CGSize)calculateViewSizeThatFits:(CGSize)size {
    CGSize retSize = [_flexbox sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    return retSize;
}

- (void)addToSuperview:(UIView *)superview {
    [_flexbox addToSuperview:superview];
}

- (void)removeFromSuperview {
    [_flexbox removeFromSuperview];
}

- (void)willBeginSetupLayout {
}

- (void)didEndSetupLayout {
    YGNodeRef node = self.node;
    YGNodeSetMeasureFunc(node, YGMeasureView);
    YGNodeMarkDirty(node);
}

- (void)applyLayoutToViewHierarchyWithOrigin:(CGPoint)origin {
    auto node = self.node;
    CGRect rect = {
        .origin = {
            .x = YGNodeLayoutGetLeft(node) + origin.x,
            .y = YGNodeLayoutGetTop(node) + origin.y
        },
        .size = {
            .width = YGNodeLayoutGetWidth(node),
            .height = YGNodeLayoutGetHeight(node)
        }
    };
    if (auto view = _flexbox.view) {
        view.frame = rect;
    }
    else {
        [_flexbox updateFlexboxLayoutIfNeeded];
        [_flexbox calculateLayoutWithSize:rect.size];
        [_flexbox applyLayoutToViewHierarchyWithOrigin:rect.origin];
    }
}

@end
