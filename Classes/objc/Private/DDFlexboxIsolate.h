//
//  DDFlexboxIsolate.h
//  DDFlexbox
//
//  Created by Daniel on 2019/11/12.
//

#import "DDFlexbox.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDFlexboxIsolate : DDFlexbox

@property (nonatomic, strong) DDFlexbox *flexbox;

- (instancetype)initWithNode:(DDFlexbox *)box;

@end

NS_ASSUME_NONNULL_END
