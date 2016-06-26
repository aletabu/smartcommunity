//
//  LoginServerRequest.h
//  aurora-iphone
//
//  Created by Constanza Areco on 08/04/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "AbstractPOSTServerRequest.h"

@interface LoginServerRequest : AbstractPOSTServerRequest {
    NSString *_username;
    NSString *_password;
}
- (void) displayLogin;
- (void)setCredentials : (NSString *)username :(NSString *)password;
- (void) communicate;
@end
