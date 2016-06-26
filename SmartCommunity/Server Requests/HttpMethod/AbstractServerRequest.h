//
//  AbstractServerRequest.h
//  aurora-iphone
//
//  Created by Constanza Areco on 08/04/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "ServerRequestController.h"
#import "ViewController.h"
#import "SBJson.h"
#import "SmartCommunityViewController.h"

@interface AbstractServerRequest : NSObject <NSURLConnectionDelegate> {
    NSURLConnection *_connection;
    NSMutableData *responseData;
    ServerRequestController *requestController;

    BOOL requestOK;
}

@property (strong, nonatomic)   ViewController *viewController;
@property (strong, nonatomic)   SmartCommunityViewController *smartSecureController;
@property (strong, nonatomic)   NSTimer *retryTimer;


- (NSURL *) getRequestURL;
- (void) setRequestController : (ServerRequestController *) controller;
- (void) sendRequest;
- (void) showAlert : (NSString *) title : (NSString *) msg;
- (void) showErrorAlert : (NSString *) msg;
- (void) displayNextScreen;
- (void) communicate;
- (BOOL) successResult : (NSString *) result;

- (NSURL *)computeURLWithService:(NSString *)service andParameters:(NSDictionary *)parameters;

@end
