//
//  SettingsView.m
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView
@synthesize  switchState, affinityName, affinityId;




- (void) setColors {

    [self.affinityName setTextColor :[UIColor colorWithRed:153/255.0 green:153/255.0 blue:154/255.0 alpha:1.0f]];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}

- (void) setModel : (NSDictionary *) messageModel {
    
    [self setColors];
    
    self.affinityName.text = [messageModel objectForKey:@"name"];
    [self.switchState setOn:[[messageModel objectForKey:@"is_followed"] boolValue]];
    self.affinityId = [messageModel objectForKey:@"id"];
    
}

@end
