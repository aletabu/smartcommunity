//
//  ChooseNetScreenViewController.h
//  Smart Secure
//
//  Created by Constanza Areco on 12/07/13.
//  Copyright (c) 2013 CIDWAY Security. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartCommunityViewController.h"

@interface ChooseNetScreenViewController : SmartCommunityViewController

@property (strong, nonatomic) IBOutlet UILabel *netTitle;
@property (strong, nonatomic) IBOutlet UILabel *specificationsTitle;
@property (strong, nonatomic) IBOutlet UITextField *messageTextField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) NSString *previousScreen;

@end
