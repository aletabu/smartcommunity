//
//  SendPushNotificationTokenServerRequest.h
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "AbstractPOSTServerRequest.h"

@interface SendPushNotificationTokenServerRequest : AbstractPOSTServerRequest

@property (strong, nonatomic)  NSString *userId;
@property (strong, nonatomic)  NSString *pushToken;

@end
