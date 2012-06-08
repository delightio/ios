//
//  TeapotViewController.m
//  OpenGLSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import "TeapotViewController.h"

@implementation TeapotViewController

@synthesize teapotView;

- (void)dealloc
{
    [teapotView release];
    
    [super dealloc];
}

- (void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
    
    teapotView = [[TeapotView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:teapotView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [teapotView startAnimation];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [teapotView stopAnimation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    [teapotView release]; teapotView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
