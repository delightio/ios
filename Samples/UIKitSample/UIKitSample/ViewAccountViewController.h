//
//  ViewAccountViewController.h
//  UIKitSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Account;
@protocol ViewAccountViewControllerDelegate;

@interface ViewAccountViewController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic, retain) Account *account;
@property (nonatomic, assign) id<ViewAccountViewControllerDelegate> delegate;

@end

@protocol ViewAccountViewControllerDelegate
- (void)viewAccountViewController:(ViewAccountViewController *)viewController didDeleteAccount:(Account *)account;
@end
