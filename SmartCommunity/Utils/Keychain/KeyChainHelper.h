//
//  KeyChainHelper.h
//  Sesami
//
//  Created by Constanza Areco on 26/08/12.
//  Copyright (c) 2012 Cidway Security. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainHelper : NSObject

- (NSString *)  loadStoredToken;
- (void) saveToken : (NSMutableString *) token;
- (void) removeToken;
- (NSString *)loadNetworks;
- (void) saveNetworks : (NSString *) networks;
- (void) removeNetworks;
- (void) removeAllKeyChain;

- (NSString *)loadSelectedNetwork;
- (void) saveSelectedNetwork : (NSString *) network;
- (void) removeSelectedNetwork;
- (NSString *)loadEventsInfoForNetwork : (NSString *) networkId;
- (void) saveEventsInfoForNetwork : (NSString *) networkId  : (NSString *) eventsInfo;
@end
