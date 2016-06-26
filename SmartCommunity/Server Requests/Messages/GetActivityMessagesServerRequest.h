//
//  GetIncidentMessagesServerRequest.h
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "AbstractGETServerRequest.h"
#import "AffinityMessagesViewController.h"

@interface GetActivityMessagesServerRequest : AbstractGETServerRequest {
    BOOL *loadScreen;
}

@property (strong, nonatomic)  NSString *networkId;

@property (strong, nonatomic)  AffinityMessagesViewController *messagesViewController;

@end
