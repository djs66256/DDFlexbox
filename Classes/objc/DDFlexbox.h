//
//  DDFlexbox.h
//  DDFlexbox
//
//  Created by Daniel on 2019/11/8.
//

#import <yoga/Yoga.h>
#import <UIKit/UIKit.h>
#import "UIView+DDFlexbox.h"

NS_ASSUME_NONNULL_BEGIN

#ifdef __cplusplus
extern "C"
{
#endif
void DDFlexboxSetDebug(BOOL);
#ifdef __cplusplus
} // extern "C"
#endif

static inline YGValue YGPointValue(CGFloat value)
{
  return (YGValue) { .value = (float)value, .unit = YGUnitPoint };
}

static inline YGValue YGPercentValue(CGFloat value)
{
  return (YGValue) { .value = (float)value, .unit = YGUnitPercent };
}

@protocol DDFlexbox <NSObject>

@property (nonatomic, readwrite, assign) YGDirection direction;
@property (nonatomic, readwrite, assign) YGFlexDirection flexDirection;
@property (nonatomic, readwrite, assign) YGJustify justifyContent;
@property (nonatomic, readwrite, assign) YGAlign alignContent;
@property (nonatomic, readwrite, assign) YGAlign alignItems;
@property (nonatomic, readwrite, assign) YGAlign alignSelf;
@property (nonatomic, readwrite, assign) YGPositionType position;
@property (nonatomic, readwrite, assign) YGWrap flexWrap;
@property (nonatomic, readwrite, assign) YGOverflow overflow;
@property (nonatomic, readwrite, assign) YGDisplay display;

@property (nonatomic, readwrite, assign) CGFloat flex;
@property (nonatomic, readwrite, assign) CGFloat flexGrow;
@property (nonatomic, readwrite, assign) CGFloat flexShrink;
@property (nonatomic, readwrite, assign) YGValue flexBasis;

@property (nonatomic, readwrite, assign) YGValue left;
@property (nonatomic, readwrite, assign) YGValue top;
@property (nonatomic, readwrite, assign) YGValue right;
@property (nonatomic, readwrite, assign) YGValue bottom;
@property (nonatomic, readwrite, assign) YGValue start;
@property (nonatomic, readwrite, assign) YGValue end;

@property (nonatomic, readwrite, assign) YGValue marginLeft;
@property (nonatomic, readwrite, assign) YGValue marginTop;
@property (nonatomic, readwrite, assign) YGValue marginRight;
@property (nonatomic, readwrite, assign) YGValue marginBottom;
@property (nonatomic, readwrite, assign) YGValue marginStart;
@property (nonatomic, readwrite, assign) YGValue marginEnd;
@property (nonatomic, readwrite, assign) YGValue marginHorizontal;
@property (nonatomic, readwrite, assign) YGValue marginVertical;
@property (nonatomic, readwrite, assign) YGValue margin;

@property (nonatomic, readwrite, assign) YGValue paddingLeft;
@property (nonatomic, readwrite, assign) YGValue paddingTop;
@property (nonatomic, readwrite, assign) YGValue paddingRight;
@property (nonatomic, readwrite, assign) YGValue paddingBottom;
@property (nonatomic, readwrite, assign) YGValue paddingStart;
@property (nonatomic, readwrite, assign) YGValue paddingEnd;
@property (nonatomic, readwrite, assign) YGValue paddingHorizontal;
@property (nonatomic, readwrite, assign) YGValue paddingVertical;
@property (nonatomic, readwrite, assign) YGValue padding;

@property (nonatomic, readwrite, assign) CGFloat borderLeftWidth;
@property (nonatomic, readwrite, assign) CGFloat borderTopWidth;
@property (nonatomic, readwrite, assign) CGFloat borderRightWidth;
@property (nonatomic, readwrite, assign) CGFloat borderBottomWidth;
@property (nonatomic, readwrite, assign) CGFloat borderStartWidth;
@property (nonatomic, readwrite, assign) CGFloat borderEndWidth;
@property (nonatomic, readwrite, assign) CGFloat borderWidth;

@property (nonatomic, readwrite, assign) YGValue width;
@property (nonatomic, readwrite, assign) YGValue height;
@property (nonatomic, readwrite, assign) YGValue minWidth;
@property (nonatomic, readwrite, assign) YGValue minHeight;
@property (nonatomic, readwrite, assign) YGValue maxWidth;
@property (nonatomic, readwrite, assign) YGValue maxHeight;

// Yoga specific properties, not compatible with flexbox specification
@property (nonatomic, readwrite, assign) CGFloat aspectRatio;

@end

@protocol DDFlexboxConfiguration <NSObject>

- (id<DDFlexbox>)setupLayout:(void(^NS_NOESCAPE)(id<DDFlexbox> box))block;

@end

@interface DDFlexbox : NSObject <DDFlexboxConfiguration>

@property (nonatomic, readonly) BOOL isRootNode;
@property (nonatomic, readonly) BOOL isLeafNode;

// When YES, regard this node as a single node.
// Super node will not see any children in this node.
// And this node will calculate separately.
@property (nonatomic, assign, getter=isIsolated) BOOL isolated;

@property(nonatomic, readonly) CGSize intrinsicContentSize;
- (CGSize)sizeThatFits:(CGSize)size;

// Must call in view's layoutSubviews.
- (void)layoutSubviews;

// Helper funcation
+ (instancetype)row;
+ (instancetype)column;
+ (instancetype)absolute;  // absolute
+ (instancetype)spacer;
+ (instancetype)blockerWithWidth:(CGFloat)width;
+ (instancetype)blockerWithHeight:(CGFloat)height;
+ (instancetype)blockerWithSize:(CGSize)size;

@property (readonly) DDFlexbox *row;
@property (readonly) DDFlexbox *column;
@property (readonly) DDFlexbox *absolute;

@end

NS_ASSUME_NONNULL_END
