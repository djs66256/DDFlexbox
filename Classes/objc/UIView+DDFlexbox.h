//
//  UIView+DDFlexbox.h
//  DDFlexbox
//
//  Created by Daniel on 2019/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DDFlexbox;
@interface UIView (DDFlexbox)

#ifndef USE_NO_DD_PREFIX
#define USE_NO_DD_PREFIX 1
#endif

#if USE_NO_DD_PREFIX

@property (nonatomic, readonly, getter=isFlexboxEnable) BOOL flexboxEnable;
@property (nonatomic, readonly) DDFlexbox *flexbox;

- (void)setNeedsUpdateFlexboxLayout;
- (void)updateFlexboxLayoutIfNeeded;

// For override
- (void)updateFlexboxLayout;

#else

@property (nonatomic, readonly, getter=dd_isFlexboxEnable) BOOL dd_flexboxEnable;
@property (nonatomic, readonly) DDFlexbox *dd_flexbox;

- (void)dd_setNeedsUpdateFlexboxLayout;
- (void)dd_updateFlexboxLayoutIfNeeded;

// For override
- (void)dd_updateFlexboxLayout;

#endif

@end

/// Cell的flexbox默认使用的contentView作为布局容器，cell本身仅作为宿主触发重新layout
/// 所以在cell中使用 self.flexbox 时，默认就是 contentView
/// 如果需要使用cell作为容器，可以使用 self.flexboxWithoutHostView
/// We use contentView as container in cell. So we bind flexbox to contentView, not cell self.
@interface UITableViewCell (DDFlexbox)

#if USE_NO_DD_PREFIX

@property (nonatomic, readonly) DDFlexbox *flexbox;
@property (nonatomic, readonly, getter=isFlexboxEnable) BOOL flexboxWithoutHostViewEnable;
@property (nonatomic, readonly) DDFlexbox *flexboxWithoutHostView;

#else

@property (nonatomic, readonly) DDFlexbox *dd_flexbox;
@property (nonatomic, readonly, getter=dd_isFlexboxEnable) BOOL dd_flexboxWithoutHostViewEnable;
@property (nonatomic, readonly) DDFlexbox *dd_flexboxWithoutHostView;

#endif

@end

@interface UICollectionViewCell (DDFlexbox)

#if USE_NO_DD_PREFIX

@property (nonatomic, readonly) DDFlexbox *flexbox;
@property (nonatomic, readonly, getter=isFlexboxEnable) BOOL flexboxWithoutHostViewEnable;
@property (nonatomic, readonly) DDFlexbox *flexboxWithoutHostView;

#else

@property (nonatomic, readonly) DDFlexbox *dd_flexbox;
@property (nonatomic, readonly, getter=dd_isFlexboxEnable) BOOL dd_flexboxWithoutHostViewEnable;
@property (nonatomic, readonly) DDFlexbox *dd_flexboxWithoutHostView;

#endif

@end

NS_ASSUME_NONNULL_END
