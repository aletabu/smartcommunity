//
//  EnterCredentialsViewController.h
//  Smart Secure
//
//  Created by Constanza Areco on 08/07/13.
//  Copyright (c) 2013 Smart Secure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartCommunityViewController.h"

@interface EnterCredentialsViewController : SmartCommunityViewController

@property (strong, nonatomic) IBOutlet UILabel *enterCredentialsText;
@property (strong, nonatomic) IBOutlet UITextField *userText;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) UIActivityIndicatorView * activityIndicator;

@end
