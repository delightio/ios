//
//  AccountsViewController.m
//  UIKitSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import "AccountsViewController.h"
#import "Account.h"
#import <Delight/Delight.h>

@implementation AccountsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        accounts = [[NSMutableArray alloc] init];

        // Pre-populate some fake accounts
        [accounts addObject:[Account accountWithName:@"Brian Blue" email:@"brian.blue@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Rebecca Red" email:@"rebecca.red@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Gary Green" email:@"gary.green@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Olga Orange" email:@"olga.orange@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Paul Purple" email:@"paul.purple@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Brianna Black" email:@"brianna.black@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Wade White" email:@"wade.white@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Yolanda Yellow" email:@"yolanda.yellow@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Michael Mauve" email:@"michael.mauve@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Penelope Pink" email:@"penelope.pink@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Gabriel Gray" email:@"gabriel.gray@example.com" password:@"12345"]];
        [accounts addObject:[Account accountWithName:@"Natalie Navy" email:@"natalie.navy@example.com" password:@"12345"]];
    }
    return self;
}

- (void)dealloc
{
    [accounts release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Accounts";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAccount:)] autorelease];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)addAccount:(id)sender
{
    AddAccountViewController *addAccountViewController = [[AddAccountViewController alloc] initWithStyle:UITableViewStyleGrouped];
    addAccountViewController.delegate = self;
    [self.navigationController pushViewController:addAccountViewController animated:YES];
    [addAccountViewController release];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [accounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    Account *account = [accounts objectAtIndex:indexPath.row];
    cell.textLabel.text = account.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Account *selectedAccount = [accounts objectAtIndex:indexPath.row];
    
    ViewAccountViewController *viewAccountViewController = [[ViewAccountViewController alloc] initWithStyle:UITableViewStyleGrouped];
    viewAccountViewController.account = selectedAccount;
    viewAccountViewController.delegate = self;
    [self.navigationController pushViewController:viewAccountViewController animated:YES];
    [viewAccountViewController release];
    
    [Delight setPropertyValue:selectedAccount.name forKey:@"last_account_viewed"];
}

#pragma mark - AddAccountViewControllerDelegate

- (void)addAccountViewController:(AddAccountViewController *)viewController didAddAccount:(Account *)account
{
    [accounts addObject:account];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[accounts count] - 1 inSection:0]
                          atScrollPosition:UITableViewScrollPositionBottom
                                  animated:YES];
    
    [Delight setPropertyValue:[NSNumber numberWithUnsignedInteger:[accounts count]] forKey:@"account_count"];
}

#pragma mark - ViewAccountViewControllerDelegate

- (void)viewAccountViewController:(ViewAccountViewController *)viewController didDeleteAccount:(Account *)account
{
    [accounts removeObject:account];
    [self.tableView reloadData];
    
    [Delight setPropertyValue:[NSNumber numberWithUnsignedInteger:[accounts count]] forKey:@"account_count"];
}

@end
