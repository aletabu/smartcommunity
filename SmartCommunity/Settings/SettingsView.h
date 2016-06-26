//
//  SettingsView.h
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsView : UIView
@property (strong, nonatomic)  NSDictionary *model;
@property (strong, nonatomic) IBOutlet UILabel *affinityName;
@property (strong, nonatomic) IBOutlet UISwitch *switchState;
@property (strong, nonatomic)  id affinityId;

@end
