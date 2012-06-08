//
//  AppDelegate.m
//  UIKitSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "AccountsViewController.h"
#import <Delight/Delight.h>

@implementation AppDelegate

@synthesize window;
@synthesize navigationController;

- (void)dealloc
{
    [window release];
    [navigationController release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    AccountsViewController *accountsViewController = [[AccountsViewController alloc] initWithStyle:UITableViewStylePlain];
    navigationController = [[UINavigationController alloc] initWithRootViewController:accountsViewController];
    [accountsViewController release];
    
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];

    [Delight setDebugLogEnabled:YES];
    [Delight startWithAppToken:@"3bf8398f83f16b82d8d3cd9e18" annotation:1];

    return YES;
}

@end
