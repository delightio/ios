//
//  AccountsViewController.h
//  UIKitSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAccountViewController.h"
#import "ViewAccountViewController.h"

@interface AccountsViewController : UITableViewController <AddAccountViewControllerDelegate, ViewAccountViewControllerDelegate> {
    NSMutableArray *accounts;
}

- (void)addAccount:(id)sender;

@end
