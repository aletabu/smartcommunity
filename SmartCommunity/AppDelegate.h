//
//  AppDelegate.h
//  SmartCommunity
//
//  Created by Constanza Areco on 12/01/14.
//  Copyright (c) 2014 Topgrade Solutions S.A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BOOL pushNotificationReceived;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *pushToken;

@property (strong, nonatomic) ViewController *viewController;

@end
