//
//  AppDelegate.m
//  SmartCommunity
//
//  Created by Constanza Areco on 12/01/14.
//  Copyright (c) 2014 Topgrade Solutions S.A. All rights reserved.
//

#import "AppDelegate.h"
#import "KeyChainHelper.h"

@implementation AppDelegate
@synthesize pushToken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Register this app, on this device
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeNone)];
    }
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeNone)];
#endif
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}


#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void) purgePushToken : (NSString *) token {
    
    if (([token characterAtIndex:0] == '<')
        && ([token characterAtIndex: ([token length] - 1)] == '>'))
    {
        pushToken = [token substringWithRange: NSMakeRange(1, [token length] - 2)];
    } else {
        pushToken = token;
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self purgePushToken: [NSString stringWithFormat:@"%@", deviceToken]];
    
    [self.viewController updatePushNotificationsId];
}

- (void) updateData :(NSDictionary *)userInfo {
    if (userInfo
        && [userInfo objectForKey:@"smart_message_type"])
    {
        if ([[userInfo objectForKey:@"smart_message_type"] isEqualToString:@"SYNC_COMMUNITY_MESSAGES"]) {
            [self.viewController updateAffinityMessages : [[userInfo objectForKey:@"network_id"] stringValue]];
        }
        
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    
    if ((state == UIApplicationStateActive)
        && self.viewController)
    {
        // event_id(long) smart_message_type SYNC_EVENTS (string) network_id (int)
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        [self updateData:userInfo];
    }
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"%@", str);
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // TODO Manage refresh when app is back from background.
    // Chequear que tipo de notificación es y llamar al refresh correspondiente.
    
    if (self.viewController)
    {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        KeyChainHelper * keyChain = [[KeyChainHelper alloc] init];
        NSString *networkId =[[[keyChain loadSelectedNetwork] propertyList] objectForKey:@"id"];
        if (networkId) {
            [self.viewController updateAffinityMessages : networkId];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
