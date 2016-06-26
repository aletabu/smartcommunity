//
//  ServerRequestController.h
//  aurora-iphone
//
//  Created by Constanza Areco on 08/04/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ViewController;
@class AbstractServerRequest;
@class SmartCommunityViewController;
@class ModeratorMessagesViewController;

@interface ServerRequestController : NSObject


@property (strong, nonatomic) ViewController * viewController;

- (void) login : (NSString *) user : (NSString *) password : (SmartCommunityViewController *) smartSecureController;
- (void) updateUserNetwork;
- (void) sendCoordinates;
- (void) getActivityInfoForNetwork : (NSString *) networkId : (ViewController *) superViewController;

- (void) getAffinitiesSettings : (NSString *) networkId : (ViewController *) superViewController;
- (void) updateAffinitiesSettings : (NSString *) networkId : (NSArray *) affinities : (ViewController *) superViewController : (SmartCommunityViewController *) currentController;

- (void) sendPushNotificationsToken : (NSString *) pushToken;
@end
