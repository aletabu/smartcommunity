//
//  ViewController.h
//  Smart Secure
//
//  Created by Constanza Areco on 07/07/13.
//  Copyright (c) 2013 Smart Secure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ServerRequestController.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic)  CLLocationManager *locationManager;
@property (strong, nonatomic)  CLLocation *location;
@property (strong, nonatomic)  id model;
@property (strong, nonatomic)  ServerRequestController *serverRequestController;

- (void) loadEnterCredentialsScreen;
- (void) loadTermsAndConditionsScreen;
- (void) loadChooseNetScreen : (NSString *) prevScreen;
- (void) loadMessagesScreen;
- (void) loadSettingsScreen;

- (NSString *) getUniqueIdentifier;
- (NSString *) generateUniqueIdentifier;

- (NSString *) getUserToken;
- (NSString *) getUserName;
- (NSString *) getUserLastName;
- (NSDictionary *) getUserNetworks;
- (CLLocation *) getLocation;

- (void) saveNetworkInfoInKeyChain : (NSDictionary *) networks;

- (void) saveActivityInfoInKeyChain : (NSDictionary *) eventsInfo : (NSString *) networkId;
- (void) saveInfoInKeyChain;
- (void) storeUserInfo : (id) model;
- (void) updateUserInfoAndLoadApplication;
- (void) updatePushNotificationsId;
- (void) updateAffinityMessages : (NSString *) networkId;

/*- (void) saveNetworkInfoInKeyChain : (id) networks;
- (void) saveIncidentInfoInKeyChain : (NSDictionary *) eventsInfo : (NSString *) networkId;
- (void) updateEventMessages;
 */
@end
