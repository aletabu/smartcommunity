//
//  GetAffinitiesSettingsServerRequest.h
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "AbstractGETServerRequest.h"
#import "SettingsViewController.h"

@interface GetAffinitiesSettingsServerRequest: AbstractGETServerRequest {
    BOOL *loadScreen;
}

@property (strong, nonatomic)  NSString *networkId;

@property (strong, nonatomic)  SettingsViewController *messagesViewController;

@end
