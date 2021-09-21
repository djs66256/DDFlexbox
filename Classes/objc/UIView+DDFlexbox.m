//
//  UIView+DDFlexbox.m
//  DDFlexbox
//
//  Created by Daniel on 2019/11/8.
//

#import <objc/runtime.h>
#import "UIView+DDFlexbox.h"
#import "DDFlexbox.h"
#import "DDFlexbox+Private.h"

@implementation UIView (DDFlexbox)

#if USE_NO_DD_PREFIX

- (BOOL)isFlexboxEnable {
    return objc_getAssociatedObject(self, @selector(flexbox)) != nil;
}

- (DDFlexbox *)flexbox {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(flexbox));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self textNode:NO];
        objc_setAssociatedObject(self, @selector(flexbox), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}

- (void)updateFlexboxLayout {
    
}

- (void)setNeedsUpdateFlexboxLayout {
    [self.flexbox setNeedsUpdateFlexboxLayout];
}

- (void)updateFlexboxLayoutIfNeeded {
    [self.flexbox updateFlexboxLayoutIfNeeded];
}

#else

- (BOOL)dd_isFlexboxEnable {
    return objc_getAssociatedObject(self, @selector(dd_flexbox)) != nil;
}

- (DDFlexbox *)dd_flexbox {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(dd_flexbox));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self textNode:NO];
        objc_setAssociatedObject(self, @selector(dd_flexbox), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}

- (void)dd_updateFlexboxLayout {
    
}

- (void)dd_setNeedsUpdateFlexboxLayout {
    [self.dd_flexbox setNeedsUpdateFlexboxLayout];
}

- (void)dd_updateFlexboxLayoutIfNeeded {
    [self.dd_flexbox updateFlexboxLayoutIfNeeded];
}

#endif

@end

@interface UILabel (DDFlexbox)

@end

@implementation UILabel (DDFlexbox)

#if USE_NO_DD_PREFIX
- (DDFlexbox *)flexbox {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(flexbox));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self textNode:YES];
        objc_setAssociatedObject(self, @selector(flexbox), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}
#else
- (DDFlexbox *)dd_flexbox {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(dd_flexbox));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self textNode:YES];
        objc_setAssociatedObject(self, @selector(dd_flexbox), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}
#endif

@end

@implementation UITableViewCell (DDFlexbox)

#if USE_NO_DD_PREFIX
- (DDFlexbox *)flexbox {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(flexbox));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self.contentView hostView:self textNode:NO];
        objc_setAssociatedObject(self, @selector(flexbox), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}

- (BOOL)isFlexboxWithoutHostViewEnable {
    return objc_getAssociatedObject(self, @selector(flexboxWithoutHostView)) != nil;
}

- (DDFlexbox *)flexboxWithoutHostView {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(flexboxWithoutHostView));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self textNode:NO];
        objc_setAssociatedObject(self, @selector(flexboxWithoutHostView), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}
#else
- (DDFlexbox *)dd_flexbox {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(dd_flexbox));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self.contentView hostView:self textNode:NO];
        objc_setAssociatedObject(self, @selector(dd_flexbox), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}

- (BOOL)dd_isFlexboxWithoutHostViewEnable {
    return objc_getAssociatedObject(self, @selector(dd_flexboxWithoutHostView)) != nil;
}

- (DDFlexbox *)dd_flexboxWithoutHostView {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(dd_flexboxWithoutHostView));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self textNode:NO];
        objc_setAssociatedObject(self, @selector(dd_flexboxWithoutHostView), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}
#endif

@end

@implementation UICollectionViewCell (DDFlexbox)

#if USE_NO_DD_PREFIX
- (DDFlexbox *)flexbox {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(flexbox));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self.contentView hostView:self textNode:NO];
        objc_setAssociatedObject(self, @selector(flexbox), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}

- (BOOL)isFlexboxWithoutHostViewEnable {
    return objc_getAssociatedObject(self, @selector(flexboxWithoutHostView)) != nil;
}

- (DDFlexbox *)flexboxWithoutHostView {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(flexboxWithoutHostView));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self textNode:NO];
        objc_setAssociatedObject(self, @selector(flexboxWithoutHostView), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}
#else
- (DDFlexbox *)dd_flexbox {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(dd_flexbox));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self.contentView hostView:self textNode:NO];
        objc_setAssociatedObject(self, @selector(dd_flexbox), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}

- (BOOL)dd_isFlexboxWithoutHostViewEnable {
    return objc_getAssociatedObject(self, @selector(dd_flexboxWithoutHostView)) != nil;
}

- (DDFlexbox *)dd_flexboxWithoutHostView {
    DDFlexbox *box = objc_getAssociatedObject(self, @selector(dd_flexboxWithoutHostView));
    if (box == nil) {
        box = [[DDFlexbox alloc] initWithView:self textNode:NO];
        objc_setAssociatedObject(self, @selector(dd_flexboxWithoutHostView), box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return box;
}
#endif

@end
