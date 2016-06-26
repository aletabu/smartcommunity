//
//  GeoreferenciationServerRequest.m
//  Smart Secure
//
//  Created by Constanza Areco on 16/07/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "GeoreferenciationServerRequest.h"

@implementation GeoreferenciationServerRequest

@synthesize location;

- (NSURL *) getRequestURL {
    NSURL * url = [[NSURL alloc] initWithString:[kSendLocalizationURL  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return url;
}

- (BOOL) successResult : (NSString *) result {
	BOOL success = NO;
    NSDictionary * model = [responseData JSONValue];
    
	if ([model objectForKey:@"status"]
        && ([[model objectForKey:@"status"] intValue] == 200))
    {
        success = YES;
        
	}
	return success;
}

- (NSData *) getRequestBody {
    NSMutableString *parameters;
    location = [self.viewController getLocation];
    parameters = [[NSMutableString alloc] initWithFormat:@"identifier=%@&lat=%f&lon=%f", [self.viewController getUniqueIdentifier], location.coordinate.latitude, location.coordinate.longitude];
    
    NSData *requestBody = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    return requestBody;
}

- (void) requestSucceded {
}

@end
