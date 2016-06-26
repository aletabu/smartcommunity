//
//  ViewController.m
//  Smart Secure
//
//  Created by Constanza Areco on 07/07/13.
//  Copyright (c) 2013 Smart Secure. All rights reserved.
//

#import "ViewController.h"
#import "EnterCredentialsViewController.h"
#import "AppDelegate.h"
#import "ConfigurationData.h"
#import "XMLParser.h"
#import "ChooseNetScreenViewController.h"
#import "TermsAndConditionsViewController.h"
#import "AffinityMessagesViewController.h"
#import "AutoSizeManager.h"
#import "KeyChainHelper.h"
#import "SettingsViewController.h"

NSString * uniqueIdentifier;

@interface ViewController ()

@end

@implementation ViewController
@synthesize location, locationManager, serverRequestController, model;

- (BOOL) isUserRegistered {
// TODO
    
    return NO;
}

- (void) updateModel : (id) newModel {
    [self storeUserInfo : newModel];
}

- (void)updateLocation {
    [locationManager startUpdatingLocation];
}

- (void) initLocalizationManager {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    [self updateLocation];

}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    location = newLocation;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}

- (void) loadChooseNetScreen : (NSString *) prevScreen {
    ChooseNetScreenViewController *chooseNetController = [[ChooseNetScreenViewController alloc] initWithNibName:@"ChooseNetScreenViewController" bundle:nil];
    chooseNetController.superViewController = self;
    chooseNetController.serverRequestController = self.serverRequestController;
    chooseNetController.previousScreen = prevScreen;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = chooseNetController;


}


- (void) loadTermsAndConditionsScreen {
    
    TermsAndConditionsViewController *termsController = [[TermsAndConditionsViewController alloc] initWithNibName:[AutoSizeManager getCorrectNibFileName:@"TermsAndConditionsViewController"] bundle:nil];
    termsController.superViewController = self;
    termsController.serverRequestController = self.serverRequestController;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = termsController;
}

- (void) loadMessagesScreen {
    AffinityMessagesViewController *messagesController = [[AffinityMessagesViewController alloc] initWithNibName:@"AffinityMessagesViewController" bundle:nil];
    messagesController.superViewController = self;
    messagesController.serverRequestController = self.serverRequestController;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = messagesController;
  
  
}

- (void) loadSettingsScreen {
      SettingsViewController *settingsController = [[SettingsViewController alloc] initWithNibName:[AutoSizeManager getCorrectNibFileName: @"SettingsViewController"] bundle:nil];
     settingsController.superViewController = self;
     settingsController.serverRequestController = self.serverRequestController;
     
     AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
     appDelegate.window.rootViewController = settingsController;
     
}

- (BOOL) hasManyNetworks {
    BOOL manyNetworks = NO;
    NSDictionary * networks;
    networks = [self getUserNetworks];
    if ([networks count] > 1) {
        manyNetworks = YES;
    }
    return manyNetworks;
}

- (void) getUserInfoFromServer {
    [self.serverRequestController updateUserNetwork];
}


- (void) startRegisteredApplication {
    [self getUserInfoFromServer];
    [self loadRegisteredAppScreen];
}


- (void) loadEnterCredentialsScreen {
    
    EnterCredentialsViewController *credentialsController = [[EnterCredentialsViewController alloc] initWithNibName:@"EnterCredentialsViewController" bundle:nil];
    credentialsController.superViewController = self;
    credentialsController.serverRequestController = self.serverRequestController;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = credentialsController;
}

- (void) startRegistrationProcess {
    [self loadEnterCredentialsScreen];
}


- (void) loadConfigurationData {
	if(![self parseXMLConfiguration])
	{
		[self showErrorAlert];
		[self performSelector:@selector(exit) withObject:nil afterDelay:1.5];
	}
}

- (BOOL)parseXMLConfiguration {
    
	NSString *paths = [[NSBundle mainBundle] resourcePath];
    NSString *xmlFile = [paths
						 stringByAppendingPathComponent:@"configuration.xml"];
    NSURL *xmlURL = [NSURL fileURLWithPath:xmlFile isDirectory:NO];
	
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
	XMLParser *parser = [[XMLParser alloc] initXMLParser];
	[xmlParser setDelegate:parser];
	
	BOOL success = [xmlParser parse];
	
	return success;
}

- (BOOL) isApplicationFirstRun {
    BOOL firstRun = NO;
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"FirstRun"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"1strun" forKey:@"FirstRun"];
        firstRun = YES;
    }
    
    return firstRun;
}


- (NSString *) getUserToken {
    KeyChainHelper * keyChainHelper = [[KeyChainHelper alloc] init];
    return [keyChainHelper loadStoredToken];
}

- (NSString *) getUserName {
    return [self.model objectForKey:@"first_name"];
}

- (NSString *) getUserLastName {
    return [self.model objectForKey:@"last_name"];
}

- (NSDictionary *) getUserNetworks {
    KeyChainHelper * keyChainHelper = [[KeyChainHelper alloc] init];
    return [[keyChainHelper loadNetworks] propertyList];
}

- (CLLocation *) getLocation {
    return location;
}

- (NSString *) generateUniqueIdentifier {
    int identifier = arc4random_uniform(29);
    
    NSDate *date = [NSDate date];
    ;
    uniqueIdentifier = [NSString stringWithFormat: @"%d-%f", identifier, ([date timeIntervalSince1970] * 1000)];
    return uniqueIdentifier;
    
}

- (NSString *) getUniqueIdentifier {
    if (uniqueIdentifier) {
        return uniqueIdentifier;
    } else {
        return [self generateUniqueIdentifier];
    }
}



- (BOOL) affinityMessagesScreenIsVisible : (UIViewController *) controller{
    BOOL isVisible = NO;
    
    if([controller isKindOfClass:[AffinityMessagesViewController class]])
    {
        isVisible = YES;
    }
    
    return isVisible;
}


- (BOOL) settingsScreenIsVisible : (UIViewController *) controller{
    BOOL isVisible = NO;
    
    if([controller isKindOfClass:[SettingsViewController class]])
    {
        isVisible = YES;
    }
    
    return isVisible;
}

- (void) saveActivityInfoInKeyChain : (NSDictionary *) eventsInfo : (NSString *) networkId  {
    
    KeyChainHelper * keyChainHelper = [[KeyChainHelper alloc] init];
    [keyChainHelper saveEventsInfoForNetwork :networkId :[eventsInfo description]];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    UIViewController *controller = appDelegate.window.rootViewController;
    
    if ([self affinityMessagesScreenIsVisible : controller]) {
        [((AffinityMessagesViewController *) controller) updateInfo:eventsInfo];
    }
}

- (void) saveInfoInKeyChain {
    KeyChainHelper * keyChainHelper = [[KeyChainHelper alloc] init];
    [keyChainHelper saveToken:[self.model objectForKey:@"token"]];
    [self saveNetworkInfoInKeyChain: [self.model objectForKey:@"networks"]];
}

- (void) saveNetworkInfoInKeyChain : (NSDictionary *) networks {
    KeyChainHelper * keyChainHelper = [[KeyChainHelper alloc] init];
    [keyChainHelper saveNetworks:[networks description]];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    UIViewController *controller = appDelegate.window.rootViewController;

    if ([self settingsScreenIsVisible : controller]) {
        [((SettingsViewController *) controller) updateInfo:networks];
    }
}

- (void) loadRegisteredAppScreen {
    [self loadMessagesScreen];
}

- (void) updateUserInfoAndLoadApplication {
    [self saveInfoInKeyChain];
    [self updatePushNotificationsId];
    [self loadChooseNetScreen : @"MESSAGES"];
}

- (void) storeUserInfo : (id)  newModel {
    self.model = newModel;
    if ([self userIsRegistered]) {
        [self updateUserInfoAndLoadApplication];
    } else {
        [self loadTermsAndConditionsScreen];
    }
}

- (void) cleanKeyChain {
    
    if ([self getUserToken]) {
        KeyChainHelper * keyChainHelper = [[KeyChainHelper alloc] init];
        [keyChainHelper removeAllKeyChain];
    }
}


- (BOOL) userIsRegistered {
    
    BOOL haveCredentials = NO;
    
    if ([self getUserToken])
    {
        haveCredentials = YES;
    }
    
    return haveCredentials;
}

- (void) updatePushNotificationsId {
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (appDelegate.pushToken
            && [self userIsRegistered]) {
        
        [self.serverRequestController sendPushNotificationsToken: appDelegate.pushToken];
    }

}

- (void) updateAffinityMessages : (NSString *) networkId {
    [self.serverRequestController getActivityInfoForNetwork:networkId :self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    uniqueIdentifier = nil;
    self.serverRequestController = [[ServerRequestController alloc] init];
    self.serverRequestController.viewController = self;

    [self loadConfigurationData];
    
   // [self initLocalizationManager];
    
    if ([self isApplicationFirstRun]) {
        [self cleanKeyChain];
    }
    
    if ([self userIsRegistered]) {
        [self startRegisteredApplication];
    } else {
        [self startRegistrationProcess];
    }
}

- (void) showErrorAlert {
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:NSLocalizedString(@"Error", @"")
						  message:NSLocalizedString(@"XMLConfigurationFileError", @"")
						  delegate:self
						  cancelButtonTitle:nil
						  otherButtonTitles:nil];
	[alert show];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [locationManager stopUpdatingLocation];
}
@end
