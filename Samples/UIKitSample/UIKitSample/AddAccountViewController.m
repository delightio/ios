//
//  AddAccountViewController.m
//  UIKitSample
//
//  Copyright (c) 2012 Pipely Inc. All rights reserved.
//

#import "AddAccountViewController.h"
#import "Account.h"
#import <Delight/Delight.h>

@interface AddAccountViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)createAccount:(id)sender;
@end

@implementation AddAccountViewController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Add Account";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(createAccount:)] autorelease];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // Unregister all private views
    for (UIView *view in [Delight privateViews]) {
        [Delight unregisterPrivateView:view];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UITextField *textField = (UITextField *)cell.accessoryView;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Name";
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            textField.secureTextEntry = NO;
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyNext;
            textField.placeholder = @"Account Name";
            
            // This cell could have been recycled from a password field cell.
            // In that case, we no longer want it to be private.
            [Delight unregisterPrivateView:textField];
            break;
        case 1:
            cell.textLabel.text = @"Email";
            textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            textField.secureTextEntry = NO;
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            textField.returnKeyType = UIReturnKeyNext;
            textField.placeholder = @"example@example.com";
            
            // This cell could have been recycled from a password field cell.
            // In that case, we no longer want it to be private.
            [Delight unregisterPrivateView:textField];
            break;
        case 2:
            cell.textLabel.text = @"Password";
            textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            textField.secureTextEntry = YES;
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyDone;
            textField.placeholder = @"Required";
            
            // We want the password text field to be private in the recording.
            [Delight registerPrivateView:textField description:@"Password"];
            break;
    }
}

- (void)createAccount:(id)sender
{
    UITextField *nameTextField = (UITextField *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].accessoryView;
    UITextField *emailTextField = (UITextField *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryView;
    UITextField *passwordTextField = (UITextField *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].accessoryView;
    
    if ([nameTextField.text length] && [passwordTextField.text length]) {
        Account *account = [Account accountWithName:nameTextField.text email:emailTextField.text password:passwordTextField.text];
        [delegate addAccountViewController:self didAddAccount:account];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please Try Again" message:@"Name and password cannot be blank." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"For demonstration purposes only. The password field and password keyboard will be hidden in the recording.";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 2, CGRectGetWidth(tableView.bounds) * 0.75 - 44, CGRectGetHeight(cell.bounds) - 2)];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.delegate = self;
        cell.accessoryView = textField;
        [textField release];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Don't record the keyboard if the text field is secure
    [Delight setHidesKeyboardInRecording:textField.secureTextEntry];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField *nameTextField = (UITextField *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].accessoryView;
    UITextField *emailTextField = (UITextField *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].accessoryView;
    UITextField *passwordTextField = (UITextField *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].accessoryView;

    if (textField == nameTextField) {
        [emailTextField becomeFirstResponder];
    } else if (textField == emailTextField) {
        [passwordTextField becomeFirstResponder];
    } else {
        [self createAccount:nil];
    }
    
    return YES;
}

@end
