//
//  SetAffinitiesSettingsServerRequest.m
//  SmartCommunity
//
//  Created by Constanza Areco on 13/01/14.
//  Copyright (c) 2014 Topgrade Solutions S.A. All rights reserved.
//

#import "SetAffinitiesSettingsServerRequest.h"
#import "NSString+stringWithUrlEncode.h"

@implementation SetAffinitiesSettingsServerRequest
@synthesize networkId, affinities;


- (NSURL *) getRequestURL {
    NSURL * url = [[NSURL alloc] initWithString:[kSettingsURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return url;
}

- (NSData *) getRequestBody {
    NSMutableString *parameters = [[NSMutableString alloc] initWithString:@"network_id="];
    [parameters appendString:networkId];
    
    for (NSString *parameter in affinities) {
        [parameters appendString:@"&"];
        
        [parameters appendString:@"affinities"];
        [parameters appendString:@"="];
        [parameters appendString: parameter];
    }
    
    NSData *requestBody = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    return requestBody;
}

- (void) sendRequest {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setURL:[self getRequestURL]];
    [request setValue:[NSString stringWithFormat:@"%@ %@",@"Token" ,[self.viewController getUserToken] ] forHTTPHeaderField:@"Authorization"];
    [request setTimeoutInterval:300];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[self getRequestBody]];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) requestSucceded {
    
    [self.viewController loadMessagesScreen];
}

- (void) requestFailed {
    
    [self showErrorAlert: NSLocalizedString(@"SettingsUpdateErrorText", @"")];
    [self.smartSecureController requestFailed];
}


@end
