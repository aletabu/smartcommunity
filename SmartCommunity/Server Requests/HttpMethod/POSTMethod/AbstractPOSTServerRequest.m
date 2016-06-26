//
//  AbstractPOSTServerRequest.m
//  aurora-iphone
//
//  Created by Constanza Areco on 08/04/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "AbstractPOSTServerRequest.h"

@implementation AbstractPOSTServerRequest


- (NSData *) getRequestBody {
    NSMutableString *parameters = [[NSMutableString alloc] initWithFormat:@"_type=%@", @"json"];
    
    NSData *requestBody = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    return requestBody;
}

- (BOOL) successResult : (NSString *) result {
	BOOL success = NO;
    
	if ([result rangeOfString:@"token"].location != NSNotFound)
	{
		success = YES;
	}
	return success;
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

@end
