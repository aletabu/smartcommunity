//
//  KeyChainHelper.m
//  Sesami
//
//  Created by Constanza Areco on 26/08/12.
//  Copyright (c) 2012 Cidway Security. All rights reserved.
//

#import "SSKeychain.h"
#import "ConfigurationData.h"
#import "KeyChainHelper.h"

@implementation KeyChainHelper


- (NSString *)  loadStoredToken {
    NSString * token = [SSKeychain passwordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"token"]  account:[ConfigurationData getkeyChainIdentifier]];
    
    
    return token;
}

- (void) saveToken : (NSMutableString *) token {
    [SSKeychain deletePasswordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"token"] account:[ConfigurationData getkeyChainIdentifier]];
    
    [SSKeychain setPassword:token forService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"token"] account:[ConfigurationData getkeyChainIdentifier]];
}

- (void) removeToken {
  [SSKeychain deletePasswordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"token"] account:[ConfigurationData getkeyChainIdentifier]];
}

- (NSString *)loadNetworks {
    
    NSString * networks = [SSKeychain passwordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"networks"]  account:[ConfigurationData getkeyChainIdentifier]];
    return networks;
}

- (void) saveNetworks : (NSString *) networks {
    
    [SSKeychain deletePasswordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"networks"] account:[ConfigurationData getkeyChainIdentifier]];
    
    [SSKeychain setPassword:networks forService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"networks"] account:[ConfigurationData getkeyChainIdentifier]];
}

- (NSString *)loadEventsInfoForNetwork : (NSString *) networkId {
    
    NSString * networks = [SSKeychain passwordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:[NSString stringWithFormat:@"%@%@", @"eventsInfo", networkId]]  account:[ConfigurationData getkeyChainIdentifier]];
    return networks;
}

- (void) saveEventsInfoForNetwork : (NSString *) networkId  : (NSString *) eventsInfo {
    
    [SSKeychain deletePasswordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:[NSString stringWithFormat:@"%@%@", @"eventsInfo", networkId]] account:[ConfigurationData getkeyChainIdentifier]];
    
    [SSKeychain setPassword:eventsInfo forService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:[NSString stringWithFormat:@"%@%@", @"eventsInfo", networkId]] account:[ConfigurationData getkeyChainIdentifier]];
}


- (void) removeNetworks {
    [SSKeychain deletePasswordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"networks"] account:[ConfigurationData getkeyChainIdentifier]];
}

- (NSString *)loadSelectedNetwork {
    
    NSString * selectedNetwork = [SSKeychain passwordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"network"]  account:[ConfigurationData getkeyChainIdentifier]];
    
    if (!selectedNetwork) {
        NSDictionary *networks = [[self loadNetworks] propertyList];
        for (NSDictionary * network in networks) {
            [self saveSelectedNetwork: [network description]];
            selectedNetwork = [self loadSelectedNetwork];
            break;
        }
    }

    
    return selectedNetwork;
}

- (void) saveSelectedNetwork : (NSString *) network {
    
    [SSKeychain deletePasswordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"network"] account:[ConfigurationData getkeyChainIdentifier]];
    
    [SSKeychain setPassword:network forService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"network"] account:[ConfigurationData getkeyChainIdentifier]];
}

- (void) removeSelectedNetwork {
    [SSKeychain deletePasswordForService:[[ConfigurationData getkeyChainIdentifier] stringByAppendingString:@"network"] account:[ConfigurationData getkeyChainIdentifier]];
}

- (void) removeAllKeyChain {
    [self removeToken];
    [self removeNetworks];
    [self removeSelectedNetwork];
}

@end
