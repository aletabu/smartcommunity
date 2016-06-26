//
//  TermsAndConditionsViewController.h
//  Smart Secure
//
//  Created by Constanza Areco on 08/07/13.
//  Copyright (c) 2013 Smart Secure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartCommunityViewController.h"

@interface TermsAndConditionsViewController : SmartCommunityViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UITextView *termsText;
@property (strong, nonatomic) IBOutlet UIButton *acceptButton;

@end
