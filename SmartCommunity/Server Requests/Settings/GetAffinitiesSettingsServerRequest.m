//
//  GetAffinitiesSettingsServerRequest.m
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "GetAffinitiesSettingsServerRequest.h"

@implementation GetAffinitiesSettingsServerRequest
@synthesize networkId, messagesViewController;

- (NSDictionary *) getRequestParameters {
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            networkId, @"network_id",
            @"true", @"first_time",
            nil];
}

- (NSURL *) getRequestURL {
    NSURL * url = [[NSURL alloc] initWithString:[kUserInfoUpdate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
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
    [self.viewController saveNetworkInfoInKeyChain :model];
}

- (void) requestFailed {
    
    [self showErrorAlert: NSLocalizedString(@"SettingsFetchErrorText", @"")];
    [self.smartSecureController requestFailed];
}

@end
