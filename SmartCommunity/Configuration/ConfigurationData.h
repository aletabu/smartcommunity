//
//  CidwayData.h
//  Sesami
//
//  Created on 7/5/09.
//

#import <Foundation/Foundation.h>


@interface ConfigurationData : NSObject {

}
+ (NSString *) applicationName;
+ (void) setApplicationName: (NSString *) an;
+ (NSString *) applicationVersion;
+ (void) setApplicationVersion: (NSString *) av;
+ (NSString *) applicationVendor;
+ (void) setApplicationVendor: (NSString *) av;
+ (NSString *) networkURL;
+ (void) setNetworkURL: (NSString *) nurl;
+ (int) timeoutApplication;
+ (void) setTimeoutApplication: (int) ta;
+ (int) panicAttempts;
+ (void) setAttempts: (int) attempts;

+ (int) connectionRetry;
+ (void) setConnectionRetry: (int) retry;
+ (float) panicDelay;
+ (void) setPanicDelay: (float) delay;
+ (int) unblockDelay;
+ (void) setUnBlockDelay: (int) delay;
+ (int) reminderPeriod;
+ (void) setReminderPeriod: (int) reminderPeriod;

+ (NSString *) getkeyChainIdentifier;
@end
