//
//  TermsAndConditionsViewController.m
//  Smart Secure
//
//  Created by Constanza Areco on 08/07/13.
//  Copyright (c) 2013 Smart Secure. All rights reserved.
//

#import "TermsAndConditionsViewController.h"
#import "AppDelegate.h"
#import "AutoSizeManager.h"
#import "ChooseNetScreenViewController.h"
#import "ViewController.h"

@interface TermsAndConditionsViewController ()

@end

@implementation TermsAndConditionsViewController
@synthesize titleLabel, welcomeLabel, usernameLabel, termsText, acceptButton;

- (void) loadTexts {
    self.titleLabel.text = NSLocalizedString(@"TermsAndContitionsTitle", @"");

    
    self.welcomeLabel.text = NSLocalizedString(@"WelcomeText", @"");
    [self.welcomeLabel setTextColor:[UIColor colorWithRed:112/255.0 green:187/255.0 blue:230/255.0 alpha:1.0f]];
    
    self.termsText.text =  NSLocalizedString(@"TermsAndConditionsText", @"");
    [self.acceptButton setTitle:NSLocalizedString(@"Accept", @"") forState:UIControlStateNormal];
    NSString * userName = [NSString stringWithFormat:@"%@ %@", [self.superViewController getUserName], [self.superViewController getUserLastName]];
    self.usernameLabel.text = userName;
    [self.usernameLabel setTextColor:[UIColor colorWithRed:112/255.0 green:187/255.0 blue:230/255.0 alpha:1.0f]];
    
}

- (void) loadButton {
    UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[acceptButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTexts];
    [self loadButton];
}

- (IBAction) acceptTermsAndConditions:(id)sender {
    [self.superViewController updateUserInfoAndLoadApplication];
}

@end
