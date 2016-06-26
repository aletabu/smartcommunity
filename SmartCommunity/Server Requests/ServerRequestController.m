//
//  ServerRequestController.m
//  aurora-iphone
//
//  Created by Constanza Areco on 08/04/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "ServerRequestController.h"
#import "LoginServerRequest.h"
#import "UserInfoServerRequest.h"
#import "GeoreferenciationServerRequest.h"
#import "SendPushNotificationTokenServerRequest.h"
#import "GetActivityMessagesServerRequest.h"
#import "GetAffinitiesSettingsServerRequest.h"
#import "SetAffinitiesSettingsServerRequest.h"

@implementation ServerRequestController
@synthesize viewController;

- (void) login : (NSString *) user : (NSString *) password : (SmartCommunityViewController *) smartSecureController{
    
    LoginServerRequest *loginRequest = [[LoginServerRequest alloc] init];
    [loginRequest setCredentials:user: password];
    [loginRequest setRequestController : self];
    loginRequest.viewController = self.viewController;
    loginRequest.smartSecureController = smartSecureController;
    [loginRequest communicate];
}

- (void) updateUserNetwork {
    UserInfoServerRequest *userInfoRequest = [[UserInfoServerRequest alloc] init];
    userInfoRequest.viewController = self.viewController;
    [userInfoRequest setRequestController : self];

    [userInfoRequest communicate];
}

- (void) sendCoordinates {
    GeoreferenciationServerRequest *gpsRequest = [[GeoreferenciationServerRequest alloc] init];
    gpsRequest.viewController = self.viewController;
    [gpsRequest setRequestController : self];
    
    [gpsRequest communicate];

}

- (void) sendPushNotificationsToken : (NSString *) pushToken {
    
    SendPushNotificationTokenServerRequest *sendPushTokenRequest = [[SendPushNotificationTokenServerRequest alloc] init];
    sendPushTokenRequest.viewController = self.viewController;
    sendPushTokenRequest.pushToken = pushToken;
    [sendPushTokenRequest setRequestController : self];
    
    [sendPushTokenRequest communicate];
}

- (void) getActivityInfoForNetwork : (NSString *) networkId : (ViewController *) superViewController {
    GetActivityMessagesServerRequest *getActivityInfoRequest = [[GetActivityMessagesServerRequest alloc] init];
    getActivityInfoRequest.viewController = superViewController;
    getActivityInfoRequest.networkId = networkId;
    
    [getActivityInfoRequest communicate];
    
}

- (void) getAffinitiesSettings : (NSString *) networkId : (ViewController *) superViewController {
    GetAffinitiesSettingsServerRequest *getActivityInfoRequest = [[GetAffinitiesSettingsServerRequest alloc] init];
    getActivityInfoRequest.viewController = superViewController;
    getActivityInfoRequest.networkId = networkId;
    
    [getActivityInfoRequest communicate];
}


- (void) updateAffinitiesSettings : (NSString *) networkId : (NSArray *) affinities : (ViewController *) superViewController : (SmartCommunityViewController *) currentController {
    
    SetAffinitiesSettingsServerRequest *setSettingsRequest = [[SetAffinitiesSettingsServerRequest alloc] init];
    setSettingsRequest.viewController = superViewController;
    setSettingsRequest.networkId = networkId;
    setSettingsRequest.affinities = affinities;
    setSettingsRequest.smartSecureController = currentController;
    
    [setSettingsRequest communicate];
}

@end
