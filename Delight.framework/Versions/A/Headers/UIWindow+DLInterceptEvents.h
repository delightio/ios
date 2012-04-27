//
//  UIWindow+DLInterceptEvents.h
//  Delight
//
//  Created by Chris Haugli on 1/23/12.
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLWindowDelegate;

@interface UIWindow (DLInterceptEvents)

- (void)DLsetDelegate:(id<DLWindowDelegate>)delegate;
- (void)DLsendEvent:(UIEvent *)event;

@end

@protocol DLWindowDelegate <NSObject>
- (void)window:(UIWindow *)window sendEvent:(UIEvent *)event;
@end
