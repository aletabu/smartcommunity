//
//  GetActivityMessagesServerRequest.m
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "GetActivityMessagesServerRequest.h"

@implementation GetActivityMessagesServerRequest
@synthesize networkId, messagesViewController;

- (NSDictionary *) getRequestParameters {
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            networkId, @"network_id",
            @"true", @"first_time",
            nil];
}

- (NSURL *) getRequestURL {
    NSURL * url = [[NSURL alloc] initWithString:[kGetAffinityMessagesURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return url;
}


- (void) sendRequest {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSURL *requestURL = [self computeURLWithService:[[self getRequestURL] absoluteString]
                                      andParameters:[self getRequestParameters]];
    [request setURL:requestURL];
    [request setValue:[NSString stringWithFormat:@"%@ %@",@"Token" ,[self.viewController getUserToken] ] forHTTPHeaderField:@"Authorization"];
    [request setTimeoutInterval:1200];
    
    _connection = [[NSURLConnection alloc ]initWithRequest:request delegate:self];
}

- (void) requestSucceded {
    
    NSDictionary * model = [responseData JSONValue];
    [self.viewController saveActivityInfoInKeyChain:model :self.networkId];
}

- (void) requestFailed {
    
    [self showErrorAlert: NSLocalizedString(@"MessagesFetchErrorText", @"")];
    [self.smartSecureController requestFailed];
}

@end
