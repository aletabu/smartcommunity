//
//  AbstractGETServerRequest.h
//  aurora-iphone
//
//  Created by Constanza Areco on 08/04/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "AbstractServerRequest.h"

@interface AbstractGETServerRequest : AbstractServerRequest
- (NSDictionary *) getRequestParameters;
- (NSURL *)computeURLWithService:(NSString *)service andParameters:(NSDictionary *)parameters;
@end
