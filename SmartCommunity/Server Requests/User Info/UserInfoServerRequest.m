//
//  UserInfoServerRequest.m
//  Smart Secure
//
//  Created by Constanza Areco on 16/07/13.
//  Copyright (c) 2013 CIDWAY Security. All rights reserved.
//

#import "UserInfoServerRequest.h"

@implementation UserInfoServerRequest

- (NSURL *) getRequestURL {
    NSURL * url = [[NSURL alloc] initWithString:[kUserInfoUpdate  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return url;
}

- (BOOL) hasNetworks : (NSDictionary *) model {
    BOOL networks = NO;
    if ([model count] > 0)
    {
        networks = YES;
    }
    return  networks;
}

- (void) showCredentialErrorAlert : (NSString *) title : (NSString *) msg {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:msg
                              delegate:self
                              cancelButtonTitle:NSLocalizedString(@"OK", @"")
                              otherButtonTitles:nil];
    [alertView show];
    [self.viewController loadEnterCredentialsScreen];
    
}

- (void) requestSucceded {
    
    NSDictionary * model = [responseData JSONValue];
    if ([self hasNetworks : model]) {
     //   [self.viewController saveNetworkInfoInKeyChain:model];
    } else {
        [self showCredentialErrorAlert:NSLocalizedString( @"NoNetworkTitle", @"")  : NSLocalizedString(@"NoNetworkText", @"")];
    }
}

@end
