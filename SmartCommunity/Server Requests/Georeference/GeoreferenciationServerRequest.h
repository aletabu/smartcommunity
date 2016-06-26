//
//  GeoreferenciationServerRequest.h
//  Smart Secure
//
//  Created by Constanza Areco on 16/07/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "AbstractPOSTServerRequest.h"

@interface GeoreferenciationServerRequest : AbstractPOSTServerRequest
@property (strong, nonatomic)  CLLocation *location;

@end
