//
//  DDFlexbox.m
//  DDFlexbox
//
//  Created by Daniel on 2019/11/8.
//

#if __has_include(<yoga/YGNodePrint.h>)
#import <yoga/YGNodePrint.h>
#endif
#import "DDFlexbox.h"
#import "DDFlexbox+Private.h"
#import "UIView+DDFlexbox.h"
#import "DDFlexboxIsolate.h"
#include <vector>

BOOL _DDFlexboxDebug = NO;
void DDFlexboxSetDebug(BOOL b) {
    _DDFlexboxDebug = b;
}


#define YG_PROPERTY(type, lowercased_name, capitalized_name)    \
- (type)lowercased_name                                         \
{                                                               \
  return YGNodeStyleGet##capitalized_name(self.node);           \
}                                                               \
                                                                \
- (void)set##capitalized_name:(type)lowercased_name             \
{                                                               \
  YGNodeStyleSet##capitalized_name(self.node, lowercased_name); \
}

#define YG_VALUE_PROPERTY(lowercased_name, capitalized_name)                       \
- (YGValue)lowercased_name                                                         \
{                                                                                  \
  return YGNodeStyleGet##capitalized_name(self.node);                              \
}                                                                                  \
                                                                                   \
- (void)set##capitalized_name:(YGValue)lowercased_name                             \
{                                                                                  \
  switch (lowercased_name.unit) {                                                  \
     case YGUnitUndefined:                                                         \
      YGNodeStyleSet##capitalized_name(self.node, lowercased_name.value);          \
      break;                                                                       \
    case YGUnitPoint:                                                              \
      YGNodeStyleSet##capitalized_name(self.node, lowercased_name.value);          \
      break;                                                                       \
    case YGUnitPercent:                                                            \
      YGNodeStyleSet##capitalized_name##Percent(self.node, lowercased_name.value); \
      break;                                                                       \
    default:                                                                       \
      NSAssert(NO, @"Not implemented");                                            \
  }                                                                                \
}

#define YG_AUTO_VALUE_PROPERTY(lowercased_name, capitalized_name)                  \
- (YGValue)lowercased_name                                                         \
{                                                                                  \
  return YGNodeStyleGet##capitalized_name(self.node);                              \
}                                                                                  \
                                                                                   \
- (void)set##capitalized_name:(YGValue)lowercased_name                             \
{                                                                                  \
  switch (lowercased_name.unit) {                                                  \
    case YGUnitPoint:                                                              \
      YGNodeStyleSet##capitalized_name(self.node, lowercased_name.value);          \
      break;                                                                       \
    case YGUnitPercent:                                                            \
      YGNodeStyleSet##capitalized_name##Percent(self.node, lowercased_name.value); \
      break;                                                                       \
    case YGUnitAuto:                                                               \
      YGNodeStyleSet##capitalized_name##Auto(self.node);                           \
      break;                                                                       \
    default:                                                                       \
      NSAssert(NO, @"Not implemented");                                            \
  }                                                                                \
}

#define YG_EDGE_PROPERTY_GETTER(type, lowercased_name, capitalized_name, property, edge) \
- (type)lowercased_name                                                                  \
{                                                                                        \
  return YGNodeStyleGet##property(self.node, edge);                                      \
}

#define YG_EDGE_PROPERTY_SETTER(lowercased_name, capitalized_name, property, edge) \
- (void)set##capitalized_name:(CGFloat)lowercased_name                             \
{                                                                                  \
  YGNodeStyleSet##property(self.node, edge, lowercased_name);                      \
}

#define YG_EDGE_PROPERTY(lowercased_name, capitalized_name, property, edge)         \
YG_EDGE_PROPERTY_GETTER(CGFloat, lowercased_name, capitalized_name, property, edge) \
YG_EDGE_PROPERTY_SETTER(lowercased_name, capitalized_name, property, edge)

#define YG_VALUE_EDGE_PROPERTY_SETTER(objc_lowercased_name, objc_capitalized_name, c_name, edge) \
- (void)set##objc_capitalized_name:(YGValue)objc_lowercased_name                                 \
{                                                                                                \
  switch (objc_lowercased_name.unit) {                                                           \
    case YGUnitUndefined:                                                                        \
      YGNodeStyleSet##c_name(self.node, edge, objc_lowercased_name.value);                       \
      break;                                                                                     \
    case YGUnitPoint:                                                                            \
      YGNodeStyleSet##c_name(self.node, edge, objc_lowercased_name.value);                       \
      break;                                                                                     \
    case YGUnitPercent:                                                                          \
      YGNodeStyleSet##c_name##Percent(self.node, edge, objc_lowercased_name.value);              \
      break;                                                                                     \
    default:                                                                                     \
      NSAssert(NO, @"Not implemented");                                                          \
  }                                                                                              \
}

#define YG_VALUE_EDGE_PROPERTY(lowercased_name, capitalized_name, property, edge)   \
YG_EDGE_PROPERTY_GETTER(YGValue, lowercased_name, capitalized_name, property, edge) \
YG_VALUE_EDGE_PROPERTY_SETTER(lowercased_name, capitalized_name, property, edge)

#define YG_VALUE_EDGES_PROPERTIES(lowercased_name, capitalized_name)                                                  \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Left, capitalized_name##Left, capitalized_name, YGEdgeLeft)                   \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Top, capitalized_name##Top, capitalized_name, YGEdgeTop)                      \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Right, capitalized_name##Right, capitalized_name, YGEdgeRight)                \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Bottom, capitalized_name##Bottom, capitalized_name, YGEdgeBottom)             \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Start, capitalized_name##Start, capitalized_name, YGEdgeStart)                \
YG_VALUE_EDGE_PROPERTY(lowercased_name##End, capitalized_name##End, capitalized_name, YGEdgeEnd)                      \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Horizontal, capitalized_name##Horizontal, capitalized_name, YGEdgeHorizontal) \
YG_VALUE_EDGE_PROPERTY(lowercased_name##Vertical, capitalized_name##Vertical, capitalized_name, YGEdgeVertical)       \
YG_VALUE_EDGE_PROPERTY(lowercased_name, capitalized_name, capitalized_name, YGEdgeAll)

#define YG_AUTO_VALUE_EDGE_PROPERTY_SETTER(objc_lowercased_name, objc_capitalized_name, c_name, edge) \
- (void)set##objc_capitalized_name:(YGValue)objc_lowercased_name                                      \
{                                                                                                     \
  switch (objc_lowercased_name.unit) {                                                                \
    case YGUnitUndefined:                                                                             \
      YGNodeStyleSet##c_name(self.node, edge, objc_lowercased_name.value);                            \
      break;                                                                                          \
    case YGUnitPoint:                                                                                 \
      YGNodeStyleSet##c_name(self.node, edge, objc_lowercased_name.value);                            \
      break;                                                                                          \
    case YGUnitPercent:                                                                               \
      YGNodeStyleSet##c_name##Percent(self.node, edge, objc_lowercased_name.value);                   \
      break;                                                                                          \
    case YGUnitAuto:                                                                                  \
      YGNodeStyleSet##c_name##Auto(self.node, edge);                                                  \
      break;                                                                                          \
    default:                                                                                          \
      NSAssert(NO, @"Not implemented");                                                               \
  }                                                                                                   \
}

#define YG_AUTO_VALUE_EDGE_PROPERTY(lowercased_name, capitalized_name, property, edge)   \
YG_EDGE_PROPERTY_GETTER(YGValue, lowercased_name, capitalized_name, property, edge)      \
YG_AUTO_VALUE_EDGE_PROPERTY_SETTER(lowercased_name, capitalized_name, property, edge)

#define YG_AUTO_VALUE_EDGES_PROPERTIES(lowercased_name, capitalized_name)                                                  \
YG_AUTO_VALUE_EDGE_PROPERTY(lowercased_name##Left, capitalized_name##Left, capitalized_name, YGEdgeLeft)                   \
YG_AUTO_VALUE_EDGE_PROPERTY(lowercased_name##Top, capitalized_name##Top, capitalized_name, YGEdgeTop)                      \
YG_AUTO_VALUE_EDGE_PROPERTY(lowercased_name##Right, capitalized_name##Right, capitalized_name, YGEdgeRight)                \
YG_AUTO_VALUE_EDGE_PROPERTY(lowercased_name##Bottom, capitalized_name##Bottom, capitalized_name, YGEdgeBottom)             \
YG_AUTO_VALUE_EDGE_PROPERTY(lowercased_name##Start, capitalized_name##Start, capitalized_name, YGEdgeStart)                \
YG_AUTO_VALUE_EDGE_PROPERTY(lowercased_name##End, capitalized_name##End, capitalized_name, YGEdgeEnd)                      \
YG_AUTO_VALUE_EDGE_PROPERTY(lowercased_name##Horizontal, capitalized_name##Horizontal, capitalized_name, YGEdgeHorizontal) \
YG_AUTO_VALUE_EDGE_PROPERTY(lowercased_name##Vertical, capitalized_name##Vertical, capitalized_name, YGEdgeVertical)       \
YG_AUTO_VALUE_EDGE_PROPERTY(lowercased_name, capitalized_name, capitalized_name, YGEdgeAll)

static struct DDFlexboxContext {
    void cacheView(UIView *view) {
        if (viewCache == nil) {
            viewCache = [NSMutableArray new];
        }
        [viewCache addObject:view];
    }
    void push(DDFlexbox *box) { stack.push_back(box); }
    DDFlexbox *top() { return stack.back(); }
    void pop() {
        stack.pop_back();
        if (stack.empty()) {
            [viewCache removeAllObjects];
        }
    }
    bool empty() { return stack.empty(); }
private:
    NSMutableArray *viewCache;
    std::vector<DDFlexbox *> stack;
} g_flexboxContext;

@interface DDFlexbox () <DDFlexbox> {
    NSMutableArray<DDFlexbox *> *_children;
    NSMutableArray<DDFlexbox *> *_tempChildren;
    UIView *_debugView;
    BOOL _needsUpdateLayout;
    BOOL _isFlexboxHostView;    // 用于实现排版的view，内部会实现 updateFlexbox
    BOOL _updateFlexboxLayoutTransaction;
}
@end

@implementation DDFlexbox

static YGConfigRef globalConfig;

static inline CGFloat YGSanitizeMeasurement(CGFloat constrainedSize, CGFloat measuredSize, YGMeasureMode measureMode)
{
    CGFloat result;
    if (measureMode == YGMeasureModeExactly) {
        result = constrainedSize;
    } else if (measureMode == YGMeasureModeAtMost) {
        result = MIN(constrainedSize, measuredSize);
    } else {
        result = measuredSize;
    }
    
    return result;
}

YGSize YGMeasureView(YGNodeRef node, float width, YGMeasureMode widthMode, float height, YGMeasureMode heightMode)
{
    const CGFloat constrainedWidth = (widthMode == YGMeasureModeUndefined) ? CGFLOAT_MAX : width;
    const CGFloat constrainedHeight = (heightMode == YGMeasureModeUndefined) ? CGFLOAT_MAX: height;
    
    DDFlexbox *box = (__bridge DDFlexbox *)YGNodeGetContext(node);
    CGSize sizeThatFits = [box calculateViewSizeThatFits:(CGSize){
        .width = constrainedWidth,
        .height = constrainedHeight,
    }];
    
    return (YGSize) {
        .width = static_cast<float>(YGSanitizeMeasurement(constrainedWidth, sizeThatFits.width, widthMode)),
        .height = static_cast<float>(YGSanitizeMeasurement(constrainedHeight, sizeThatFits.height, heightMode)),
    };
}

static CGFloat globalScale = 1;
#define USE_DOUBLE_ROUND 0
static inline CGFloat DDFlexboxRound(float num) {
#if USE_DOUBLE_ROUND
    return round(static_cast<CGFloat>(num) * globalScale) / globalScale;
#else
    return static_cast<CGFloat>(num);
#endif
}

static inline CGFloat DDFlexboxCeil(float num) {
#if USE_DOUBLE_ROUND
    return ceil(static_cast<CGFloat>(num) * globalScale) / globalScale;
#else
    return static_cast<CGFloat>(num);
#endif
}

//static inline CGFloat DDFlexboxCeil(float num) {
//    return ceil(num * globalScale) / globalScale;
//}

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalConfig = YGConfigNew();
        globalScale = [UIScreen mainScreen].scale;
        YGConfigSetExperimentalFeatureEnabled(globalConfig, YGExperimentalFeatureWebFlexBasis, true);
        YGConfigSetPointScaleFactor(globalConfig, globalScale);
    });
}

- (void)dealloc {
    if (_node) YGNodeFree(_node);
}

- (instancetype)init
{
    self = [self initWithView:nil textNode:NO];
    return self;
}

- (instancetype)initWithView:(UIView *)view textNode:(BOOL)textNode {
    return [self initWithView:view hostView:view textNode:textNode];
}

- (instancetype)initWithView:(UIView *)view hostView:(UIView *)hostView textNode:(BOOL)textNode {
    self = [super init];
    if (self) {
        if (_DDFlexboxDebug) {
            if (view == nil) {
                view = [UIView new];
                _debugView = view; // store it, not be dealloc
            }
            view.layer.borderColor = [UIColor blueColor].CGColor;
            view.layer.borderWidth = 1 / UIScreen.mainScreen.scale;
        }
        _node = YGNodeNewWithConfig(globalConfig);
        YGNodeSetContext(_node, (__bridge void *)self);
        _children = [NSMutableArray new];
        _tempChildren = [NSMutableArray new];
        _needsUpdateLayout = YES;
        
        _view = view;
        _hostView = hostView;
        _textNode = textNode;
        if (textNode) {
            YGNodeSetNodeType(_node, YGNodeTypeText);
        }
    }
    return self;
}

- (void)markDirty {
    YGNodeMarkDirty(_node);
}

- (BOOL)isRootNode {
    return _parent == nil;
}

- (BOOL)isLeafNode {
    return _children.count == 0 || _isolated;
}

- (DDFlexbox *)rootNode {
    if (_parent) {
        return [_parent rootNode];
    }
    else {
        return self;
    }
}

#pragma mark - Style

- (YGPositionType)position
{
  return YGNodeStyleGetPositionType(self.node);
}

- (void)setPosition:(YGPositionType)position
{
  YGNodeStyleSetPositionType(self.node, position);
}

YG_PROPERTY(YGDirection, direction, Direction)
YG_PROPERTY(YGFlexDirection, flexDirection, FlexDirection)
YG_PROPERTY(YGJustify, justifyContent, JustifyContent)
YG_PROPERTY(YGAlign, alignContent, AlignContent)
YG_PROPERTY(YGAlign, alignItems, AlignItems)
YG_PROPERTY(YGAlign, alignSelf, AlignSelf)
YG_PROPERTY(YGWrap, flexWrap, FlexWrap)
YG_PROPERTY(YGOverflow, overflow, Overflow)
YG_PROPERTY(YGDisplay, display, Display)

YG_PROPERTY(CGFloat, flex, Flex)
YG_PROPERTY(CGFloat, flexGrow, FlexGrow)
YG_PROPERTY(CGFloat, flexShrink, FlexShrink)
YG_AUTO_VALUE_PROPERTY(flexBasis, FlexBasis)

YG_VALUE_EDGE_PROPERTY(left, Left, Position, YGEdgeLeft)
YG_VALUE_EDGE_PROPERTY(top, Top, Position, YGEdgeTop)
YG_VALUE_EDGE_PROPERTY(right, Right, Position, YGEdgeRight)
YG_VALUE_EDGE_PROPERTY(bottom, Bottom, Position, YGEdgeBottom)
YG_VALUE_EDGE_PROPERTY(start, Start, Position, YGEdgeStart)
YG_VALUE_EDGE_PROPERTY(end, End, Position, YGEdgeEnd)
YG_VALUE_EDGES_PROPERTIES(padding, Padding)
YG_AUTO_VALUE_EDGES_PROPERTIES(margin, Margin)

YG_EDGE_PROPERTY(borderLeftWidth, BorderLeftWidth, Border, YGEdgeLeft)
YG_EDGE_PROPERTY(borderTopWidth, BorderTopWidth, Border, YGEdgeTop)
YG_EDGE_PROPERTY(borderRightWidth, BorderRightWidth, Border, YGEdgeRight)
YG_EDGE_PROPERTY(borderBottomWidth, BorderBottomWidth, Border, YGEdgeBottom)
YG_EDGE_PROPERTY(borderStartWidth, BorderStartWidth, Border, YGEdgeStart)
YG_EDGE_PROPERTY(borderEndWidth, BorderEndWidth, Border, YGEdgeEnd)
YG_EDGE_PROPERTY(borderWidth, BorderWidth, Border, YGEdgeAll)

YG_AUTO_VALUE_PROPERTY(width, Width)
YG_AUTO_VALUE_PROPERTY(height, Height)
YG_VALUE_PROPERTY(minWidth, MinWidth)
YG_VALUE_PROPERTY(minHeight, MinHeight)
YG_VALUE_PROPERTY(maxWidth, MaxWidth)
YG_VALUE_PROPERTY(maxHeight, MaxHeight)
YG_PROPERTY(CGFloat, aspectRatio, AspectRatio)

#pragma mark - children
- (NSArray<DDFlexbox *> *)children {
    return _children.copy;
}

- (void)addChild:(DDFlexbox *)node {
    if (node->_parent != self) {
        [node removeFromParent];
    }
    if (auto superview = [self superview]) {
        [node addToSuperview:superview];
    }
    if ([_children containsObject:node]) {
        [_children removeObject:node];
        [_children addObject:node];
    }
    else {
        [_children addObject:node];
        node->_parent = self;
    }
}

- (void)removeChild:(DDFlexbox *)node {
    if ([_children containsObject:node]) {
        [node removeFromSuperview];
        node->_parent = nil;
        [_children removeObject:node];
    }
}

- (void)removeAllChildren {
    for (DDFlexbox *node in _children) {
        [node removeFromSuperview];
        node->_parent = nil;
    }
    [_children removeAllObjects];
}

- (void)removeFromParent {
    if (_parent) {
        [_parent removeChild:self];
    }
}

- (UIView *)superview {
    if (_view) {
        return _view;
    }
    else {
        return [_parent superview];
    }
}

- (DDFlexbox *)findRootNode {
    if (_parent == nil) {
        return self;
    }
    else {
        return [_parent findRootNode];
    }
}

- (void)addToSuperview:(UIView *)superview {
    if (_view) {
        [superview addSubview:_view];
    }
    else {
        for (DDFlexbox *child in _children) {
            [child addToSuperview:superview];
        }
    }
}

- (void)bringViewToFront:(UIView *)superview {
    if (_view) {
        [superview bringSubviewToFront:_view];
    }
    else {
        for (DDFlexbox *child in _children) {
            [child bringViewToFront:superview];
        }
    }
}

- (void)removeFromSuperview {
    if (_view) {
        [_view removeFromSuperview];
    }
    else {
        for (DDFlexbox *child in _children) {
            [child removeFromSuperview];
        }
    }
}

#pragma mark - calculate
- (CGSize)calculateLayoutWithSize:(CGSize)size {
    NSAssert([NSThread isMainThread], @"MUST call on main.");
    NSAssert(self.isRootNode, @"Flexbox MUST calculate layout from root node!");
    
    float width = size.width;
    if (size.width == CGFLOAT_MAX) {
        width = YGUndefined;
    }
    float height = size.height;
    if (size.height == CGFLOAT_MAX) {
        height = YGUndefined;
    }
    
    const YGNodeRef node = _node;
    YGNodeCalculateLayout(node, width, height, YGNodeStyleGetDirection(node));
    
    return (CGSize) {
        .width = YGNodeLayoutGetWidth(node),
        .height = YGNodeLayoutGetHeight(node),
    };
}

- (void)applyLayoutToViewHierarchy {
    [self applyLayoutToViewHierarchyWithOrigin:CGPointZero];
}

- (void)applyLayoutToSubviewsHierarchy {
    for (DDFlexbox *box in _children) {
        [box applyLayoutToViewHierarchy];
    }
}

- (void)applyLayoutToViewHierarchyWithOrigin:(CGPoint)origin {
    CGPoint subviewOrigin = CGPointZero;
    if (auto view = self.view) {
        auto node = _node;
        view.frame = (CGRect){
            .origin = {
                .x = DDFlexboxRound(YGNodeLayoutGetLeft(node) + origin.x),
                .y = DDFlexboxRound(YGNodeLayoutGetTop(node) + origin.y)
            },
            .size = {
                .width = DDFlexboxCeil(YGNodeLayoutGetWidth(node)),
                .height = DDFlexboxCeil(YGNodeLayoutGetHeight(node))
            }
        };
    }
    else {
        auto node = _node;
        subviewOrigin = {
            .x = YGNodeLayoutGetLeft(node) + origin.x,
            .y = YGNodeLayoutGetTop(node) + origin.y
        };
    }
    for (DDFlexbox *child in _children) {
        [child applyLayoutToViewHierarchyWithOrigin:subviewOrigin];
    }
}

- (CGSize)calculateViewSizeThatFits:(CGSize)size {
    if (_view == nil) {
        return CGSizeZero;
    }
    else if ([_view isMemberOfClass:UIView.class]) {
        // The default implementation of sizeThatFits: returns the existing size of
        // the view. That means that if we want to layout an empty UIView, which
        // already has got a frame set, its measured size should be CGSizeZero, but
        // UIKit returns the existing size.
        //
        // See https://github.com/facebook/yoga/issues/606 for more information.
        return CGSizeZero;
    }
    else {
#define ROUND_SIZE_THAT_FITS 1 // 确实在某些场景下，文字存在半像素问题，这里统一开启取整吧
#if ROUND_SIZE_THAT_FITS
        CGSize retSize = [_view sizeThatFits:size];
        return (CGSize) {
            ceil(retSize.width), ceil(retSize.height)
        };
#else
        return [_view sizeThatFits:size];
#endif
    }
}

#pragma mark - UIView
- (CGSize)intrinsicContentSize {
    return [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (CGSize)sizeThatFits:(CGSize)size {
    if (self.isRootNode) {
        [self updateFlexboxLayoutIfNeeded];
        return [self calculateLayoutWithSize:size];
    }
    return CGSizeZero;
}

- (void)layoutSubviews {
    _isFlexboxHostView = YES;
    if (self.isRootNode) {
        [self updateFlexboxLayoutIfNeeded];
        [self calculateLayoutWithSize:_view.bounds.size];
        [self applyLayoutToSubviewsHierarchy];
    }
}

- (void)updateFlexboxLayout {
    _updateFlexboxLayoutTransaction = YES;
#if USE_NO_DD_PREFIX
    [_hostView updateFlexboxLayout];
#else
    [_hostView dd_updateFlexboxLayout];
#endif
    _updateFlexboxLayoutTransaction = NO;
}

- (void)setNeedsUpdateFlexboxLayout {
    _needsUpdateLayout = YES;
    _isFlexboxHostView = YES;
    [_hostView setNeedsLayout];
}

- (void)updateFlexboxLayoutIfNeeded {
    if (_needsUpdateLayout && _view) {
        [self updateFlexboxLayout];
        _needsUpdateLayout = NO;
    }
    for (DDFlexbox *child in _children) {
        [child updateFlexboxLayoutIfNeeded];
    }
}

#pragma mark - setup layout
- (void)addTempChild:(DDFlexbox *)box {
    [_tempChildren addObject:box];
}

- (void)willBeginSetupLayout {
    [_tempChildren removeAllObjects];
}

- (void)didEndSetupLayout {
    // 如果是一个子view，并且不在其内部的flexbox更新排版过程中，则忽略其对child的影响
    if (_isFlexboxHostView && !_updateFlexboxLayoutTransaction) {
        return;
    }
    auto superview = [self superview];
    BOOL childrenDidChanged = ![_tempChildren isEqualToArray:_children];
    if (childrenDidChanged) {
        for (DDFlexbox *node in _tempChildren) {
            if ([_children containsObject:node]) {
                [_children removeObject:node];
                if (superview) {
                    [node bringViewToFront:superview];
                }
            }
            else {
                if (node.parent) {
                    [node removeFromParent];
                }
                node->_parent = self;
                if (superview) {
                    [node addToSuperview:superview];
                }
            }
        }
        for (DDFlexbox *node in _children) {
            [node removeFromSuperview];
            node->_parent = nil;
        }
        [_children removeAllObjects];
        std::swap(_children, _tempChildren);
    }
    
    // If it's a leaf node, setup measure func
    if (_children.count == 0) {
        YGNodeRemoveAllChildren(_node);
        YGNodeSetMeasureFunc(_node, YGMeasureView);
        YGNodeMarkDirty(_node);
    }
    else {
        YGNodeSetMeasureFunc(_node, NULL);
        
        if (childrenDidChanged) {
            // Setup YGNode children.
            std::vector<YGNodeRef> children;
            for (DDFlexbox *child in _children) {
                // Must remove from owner. Otherwise node will clone a new one.
                auto node = child->_node;
                auto owner = YGNodeGetOwner(node);
                if (owner) {
                    YGNodeRemoveChild(owner, node);
                }
                children.push_back(child->_node);
            }
            YGNodeSetChildren(_node, children);
        }
    }
}

- (id<DDFlexbox>)setupLayout:(void (^NS_NOESCAPE)(id<DDFlexbox> _Nonnull))block {
    auto& context = g_flexboxContext;
    
    // 1. Reset children node
    [self willBeginSetupLayout];
    
    // 2. Setup flexbox context
    if (!context.empty()) {
        // If has context, then add self to context.
        DDFlexbox *ctx = context.top();
        if (_isolated) {
            // Isolated node copy a abstract node.
            DDFlexboxIsolate *isolateNode = [[DDFlexboxIsolate alloc] initWithNode:self];
            [isolateNode willBeginSetupLayout];
            [ctx addTempChild:isolateNode];
            [isolateNode didEndSetupLayout];
        }
        else {
            [ctx addTempChild:self];
        }
        if (_view) {
            context.cacheView(_view);
        }
    }
    
    // Set self as current context, and add subnodes.
    context.push(self);
    
    if (block) block(self);
    
    // Setup mearsure func or add children to superview.
    [self didEndSetupLayout];
    
    // Pop at last, avoiding release cached views.
    context.pop();
    
    if (context.empty() && YGNodeHasMeasureFunc(self->_node)) {
        // root node cannot be leaf node.
        YGNodeSetMeasureFunc(self->_node, NULL);
    }
    
    return self;
}

#pragma mark - Helper function

+ (instancetype)row {
    DDFlexbox *box = [self new];
    box.flexDirection = YGFlexDirectionRow;
    return box;
}

+ (instancetype)column {
    DDFlexbox *box = [self new];
    box.flexDirection = YGFlexDirectionColumn;
    return box;
}

+ (instancetype)absolute {
    DDFlexbox *box = [self new];
    box.position = YGPositionTypeAbsolute;
    return box;
}

+ (instancetype)spacer {
    DDFlexbox *box = [self new];
    box.flexGrow = 1;
    box.flexShrink = 1;
    [box setupLayout:^(id<DDFlexbox>  _Nonnull box) {
        
    }];
    return box;
}

+ (instancetype)blockerWithWidth:(CGFloat)width {
    DDFlexbox *box = [self new];
    box.flexGrow = 0;
    box.flexShrink = 0;
    box.width = YGPointValue(width);
    [box setupLayout:^(id<DDFlexbox>  _Nonnull box) {
        
    }];
    return box;
}

+ (instancetype)blockerWithHeight:(CGFloat)height {
    DDFlexbox *box = [self new];
    box.flexGrow = 0;
    box.flexShrink = 0;
    box.height = YGPointValue(height);
    [box setupLayout:^(id<DDFlexbox>  _Nonnull box) {
        
    }];
    return box;
}

+ (instancetype)blockerWithSize:(CGSize)size {
    DDFlexbox *box = [self new];
    box.flexGrow = 0;
    box.flexShrink = 0;
    box.height = YGPointValue(size.height);
    box.width = YGPointValue(size.width);
    [box setupLayout:^(id<DDFlexbox>  _Nonnull box) {
        
    }];
    return box;
}

- (DDFlexbox *)row {
    self.flexDirection = YGFlexDirectionRow;
    return self;
}

- (DDFlexbox *)column {
    self.flexDirection = YGFlexDirectionColumn;
    return self;
}

- (DDFlexbox *)absolute {
    self.position = YGPositionTypeAbsolute;
    return self;
}

- (NSString *)debugDescription {
#if __has_include(<yoga/YGNodePrint.h>) && DEBUG
    std::string description;
    auto options = YGPrintOptionsLayout|YGPrintOptionsStyle|YGPrintOptionsChildren;
    facebook::yoga::YGNodeToString(description, _node, static_cast<YGPrintOptions>(options), 0);
    NSString *stream = [NSString stringWithFormat:@"<%@ %p>\n%s", NSStringFromClass(self.class), self, description.c_str()];
    return stream;
#else
    return [super debugDescription];
#endif
}

@end

