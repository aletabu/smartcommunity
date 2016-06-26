//
//  EnterCredentialsViewController.m
//  Smart Secure
//
//  Created by Constanza Areco on 08/07/13.
//  Copyright (c) 2013 Smart Secure. All rights reserved.
//

#import "EnterCredentialsViewController.h"
#import "AppDelegate.h"
#import "TermsAndConditionsViewController.h"
#import "AutoSizeManager.h"
#import "ViewController.h"

@interface EnterCredentialsViewController ()

@end

@implementation EnterCredentialsViewController
@synthesize enterCredentialsText, userText, passwordText, loginButton, activityIndicator;


- (void) loadTexts {
    self.enterCredentialsText.text = NSLocalizedString(@"EnterCredentialsText", @"");
    [self.enterCredentialsText setTextColor:[UIColor colorWithRed:112/255.0 green:187/255.0 blue:230/255.0 alpha:1.0f]];
    
    self.userText.placeholder = NSLocalizedString(@"UserText", @"");
    self.passwordText.placeholder = NSLocalizedString(@"PasswordText", @"");
    [self.loginButton setTitle:NSLocalizedString(@"LoginButtonText", @"") forState:UIControlStateNormal];

}

- (void) loadButton {
    UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[loginButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTexts];
    [self loadButton];
}

- (void)showActivityIndicator:(BOOL)yesNo {
	if (yesNo == YES) {
		[self.activityIndicator startAnimating];
	}
	else {
		[self.activityIndicator stopAnimating];
	}
	UIApplication *application = [UIApplication sharedApplication];
	application.networkActivityIndicatorVisible = yesNo;
}

- (void) enableFields : (BOOL) enable {
    self.userText.enabled = enable;
    self.passwordText.enabled = enable;
    self.loginButton.enabled = enable;
    [self showActivityIndicator:!enable];
}

- (void) showErrorAlert {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@"Error", @"")
                              message:NSLocalizedString(@"UserPasswordEmptyError", @"")
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"OK", @"")
                              otherButtonTitles:nil];
    [alertView show];
}

- (BOOL) fieldsAreEmpty {
    BOOL empty = YES;
    
    if ((![self.userText.text isEqualToString:@""])
        && (! [self.passwordText.text isEqualToString:@""]))
    {
        empty = NO;
    }
    
    if (empty) {
        [self showErrorAlert];
    }
    return empty;
}

- (IBAction) login:(id)sender {
    
    [self enableFields: NO];

    if ([self fieldsAreEmpty]) {
        [self enableFields: YES];
    } else {
        [self.serverRequestController login:self.userText.text
                                           :self.passwordText.text
                                           :self];

    }
}

- (void) requestFailed {
    [self enableFields: YES];
    self.userText.text = @"";
    self.passwordText.text = @"";
}

- (IBAction)dismissKeyboard:(id)sender {
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.enterCredentialsText = nil;
    self.userText = nil;
    self.passwordText = nil;
    self.loginButton = nil;
}
@end
