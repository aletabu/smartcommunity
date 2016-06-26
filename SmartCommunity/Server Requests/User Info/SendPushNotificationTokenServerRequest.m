//
//  SendPushNotificationTokenServerRequest.m
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "SendPushNotificationTokenServerRequest.h"

@implementation SendPushNotificationTokenServerRequest
@synthesize pushToken, userId;



- (NSData *) getRequestBody {
    NSMutableString *parameters;
    

    parameters = [[NSMutableString alloc] initWithFormat:@"token=%@&platform=%@&application=%@", self.pushToken, @"I", @"smart-community"];
        
    NSData *requestBody = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    return requestBody;
}


- (NSURL *) getRequestURL {
    NSURL * url = [[NSURL alloc] initWithString:[kSendPushNotificationTokenURL  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return url;
}

@end
