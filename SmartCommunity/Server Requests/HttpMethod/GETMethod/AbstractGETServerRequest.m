//
//  AbstractGETServerRequest.m
//  aurora-iphone
//
//  Created by Constanza Areco on 08/04/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "AbstractGETServerRequest.h"
#import "NSString+stringWithUrlEncode.h"

@implementation AbstractGETServerRequest

- (NSDictionary *) getRequestParameters {

    return nil;
}

- (BOOL) successResult : (NSString *) result {
	BOOL success = YES;
    
	if ([result rangeOfString:@"error"].location != NSNotFound)
	{
		success = NO;
	}
	return success;
}


- (void) sendRequest {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSURL *requestURL = [self computeURLWithService:[[self getRequestURL] absoluteString]
                                      andParameters:nil];
    [request setURL:requestURL];
    [request setValue:[NSString stringWithFormat:@"%@ %@",@"Token" ,[self.viewController getUserToken] ] forHTTPHeaderField:@"Authorization"];
    [request setTimeoutInterval:1200];

    _connection = [[NSURLConnection alloc ]initWithRequest:request delegate:self];
}

- (NSURL *)computeURLWithService:(NSString *)service andParameters:(NSDictionary *)parameters {
    NSMutableString *computedString = [[NSMutableString alloc] initWithString:service];
    
    BOOL first = YES;
    for (NSString *parameter in parameters) {
        if (first) {
            first = NO;
            [computedString appendString:@"?"];
            
        } else {
            [computedString appendString:@"&"];
            
        }
        
        [computedString appendString:[NSString stringWithUrlEncode:parameter]];
        [computedString appendString:@"="];
        [computedString appendString:[NSString stringWithUrlEncode:[parameters objectForKey:parameter]]];
    }
    
    return [NSURL URLWithString:computedString];
}


@end
