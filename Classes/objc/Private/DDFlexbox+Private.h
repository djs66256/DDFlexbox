//
//  DDFlexbox+Private.h
//  DDFlexbox
//
//  Created by Daniel on 2019/11/11.
//

#import "DDFlexbox.h"

NS_ASSUME_NONNULL_BEGIN

extern YGSize YGMeasureView(YGNodeRef node, float width, YGMeasureMode widthMode, float height, YGMeasureMode heightMode);

@interface DDFlexbox ()

@property (nonatomic, readonly) DDFlexbox *rootNode;
@property (nonatomic, weak, readonly) DDFlexbox *parent;
@property (nonatomic, readonly) NSArray<DDFlexbox *> *children;

@property (nonatomic, assign, getter=isTextNode) BOOL textNode;
@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, weak, readonly) UIView *hostView;
@property (nonatomic, assign, readonly) YGNodeRef node;

- (instancetype)initWithView:(nullable UIView *)view textNode:(BOOL)textNode;
- (instancetype)initWithView:(nullable UIView *)view hostView:(nullable UIView *)hostView textNode:(BOOL)textNode;

- (void)addChild:(DDFlexbox *)node;
- (void)removeChild:(DDFlexbox *)node;
- (void)removeAllChildren;
- (void)removeFromParent;
- (nullable UIView *)superview;
- (DDFlexbox *)findRootNode;

- (CGSize)calculateLayoutWithSize:(CGSize)size;

- (void)setNeedsUpdateFlexboxLayout;
- (void)updateFlexboxLayoutIfNeeded;

#pragma mark - override
- (void)addToSuperview:(UIView *)superview;
- (void)removeFromSuperview;
- (CGSize)calculateViewSizeThatFits:(CGSize)size;
- (void)applyLayoutToViewHierarchyWithOrigin:(CGPoint)origin;

- (void)willBeginSetupLayout;
- (void)didEndSetupLayout;

@end

NS_ASSUME_NONNULL_END
