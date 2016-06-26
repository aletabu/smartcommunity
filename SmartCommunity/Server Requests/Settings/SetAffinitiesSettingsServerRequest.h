//
//  SetAffinitiesSettingsServerRequest.h
//  SmartCommunity
//
//  Created by Constanza Areco on 13/01/14.
//  Copyright (c) 2014 Topgrade Solutions S.A. All rights reserved.
//

#import "AbstractPOSTServerRequest.h"

@interface SetAffinitiesSettingsServerRequest : AbstractPOSTServerRequest

@property (strong, nonatomic)  NSString *networkId;
@property (strong, nonatomic)  NSArray *affinities;

@end
