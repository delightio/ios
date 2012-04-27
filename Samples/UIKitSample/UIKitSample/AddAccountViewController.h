//
//  AddAccountViewController.h
//  UIKitSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Account;
@protocol AddAccountViewControllerDelegate;

@interface AddAccountViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, assign) id<AddAccountViewControllerDelegate> delegate;

@end

@protocol AddAccountViewControllerDelegate
- (void)addAccountViewController:(AddAccountViewController *)viewController didAddAccount:(Account *)account;
@end