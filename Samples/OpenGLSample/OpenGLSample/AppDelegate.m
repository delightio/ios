//
//  AppDelegate.m
//  OpenGLSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "TeapotViewController.h"
#import <DelightPrivate/Delight.h>

@implementation AppDelegate

@synthesize window;
@synthesize teapotViewController;

- (void)dealloc
{
    [window release];
    [teapotViewController release];

    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.teapotViewController = [[[TeapotViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    self.window.rootViewController = teapotViewController;
    [self.window makeKeyAndVisible];

    [Delight setDebugLogEnabled:YES];
    [Delight startWithAppToken:@"Get your token at http://delight.io"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self.teapotViewController.teapotView stopAnimation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.teapotViewController.teapotView startAnimation];
}

@end
