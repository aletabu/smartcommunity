//
//  LoginServerRequest.m
//  aurora-iphone
//
//  Created by Constanza Areco on 08/04/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "LoginServerRequest.h"
#import "AppDelegate.h"

@implementation LoginServerRequest

- (void) displayLogin {
    [self.viewController loadEnterCredentialsScreen];
}



- (NSURL *) getRequestURL {
    NSURL * url = [[NSURL alloc] initWithString:[kCheckLoginURL  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return url;
}

- (NSData *) getRequestBody {
    NSMutableString *parameters = [[NSMutableString alloc] initWithFormat:@"username=%@&password=%@", _username, _password];
    
    NSData *requestBody = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    return requestBody;
}

- (void)setCredentials : (NSString *)username :(NSString *)password {
    _username = username;
    _password = password;
}


- (void) sendRequest {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setURL:[self getRequestURL]];
    [request setTimeoutInterval:90];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[self getRequestBody]];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (BOOL) hasNetworks : (NSDictionary *) model {
    BOOL networks = NO;
    if ([[model objectForKey:@"networks"] count] > 0) {
        networks = YES;
    }
    return  networks;
}

- (void) requestSucceded {
    
    NSDictionary * model = [responseData JSONValue];
    if ([self hasNetworks : model]) {
        [self.viewController storeUserInfo:model];
    } else {
        [self showCredentialErrorAlert:NSLocalizedString( @"NoNetworkTitle", @"")  : NSLocalizedString(@"NoNetworkText", @"") ];
    }
}

- (void) showCredentialErrorAlert : (NSString *) title : (NSString *) msg {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:msg
                              delegate:self
                              cancelButtonTitle:NSLocalizedString(@"OK", @"")
                              otherButtonTitles:nil];
    [alertView show];
    [self displayLogin];

}

- (void) requestFailed {
    
    [self showErrorAlert: NSLocalizedString(@"CredentialsInvalidText", @"")];
    [self.smartSecureController requestFailed];
}

- (void) communicate {

    if (_username && _password) {
        [self sendRequest];
    } else {
        [self displayLogin];
        
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    if (connection == _connection) {
        [_connection cancel];
        _connection = nil;
        [self showAlert:NSLocalizedString(@"NoConnectionText", nil) :NSLocalizedString(@"ConnectionFailedText", nil)];
    }
}


@end
