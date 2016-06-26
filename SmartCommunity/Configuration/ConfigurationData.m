//
//  CidwayData.m
//  Sesami
//
//  Created on 7/5/09.
//

#import "ConfigurationData.h"

static NSString *applicationName;
static NSString *applicationVersion;
static NSString *applicationVendor;
static NSString *networkURL;
static int timeoutApplication;
static int attempts;
static int connectionRetry;
static float panicDelay;
static int unblockDelay;
static int reminderPeriod;

@implementation ConfigurationData


+ (NSString *) applicationName
{ 
	return (applicationName);
} 

+ (void) setApplicationName: (NSString *) an
{ 
	applicationName = [[NSString alloc] initWithString:an];
} 

+ (NSString *) applicationVersion 
{ 
	return (applicationVersion);
} 

+ (void) setApplicationVersion: (NSString *) av
{ 
	applicationVersion = [[NSString alloc] initWithString:av];  
} 

+ (NSString *) applicationVendor 
{ 
	return (applicationVendor); 
} 

+ (void) setApplicationVendor: (NSString *) av
{ 
	applicationVendor = [[NSString alloc] initWithString:av]; 
} 

+ (NSString *) networkURL
{ 
   return [networkURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
} 

+ (void) setNetworkURL: (NSString *) nurl
{ 
	networkURL = [[NSString alloc] initWithString:nurl];
} 

+ (int) timeoutApplication 
{ 
	return (timeoutApplication);
}  

+ (void) setTimeoutApplication: (int) ta 
{ 
	timeoutApplication = ta;
} 

+ (int) panicAttempts
{
	return (attempts);
}

+ (void) setAttempts: (int) attempts
{
	attempts = attempts;
}

+ (int) connectionRetry
{
	return (connectionRetry);
}

+ (void) setConnectionRetry: (int) retry
{
	connectionRetry = retry;
}

+ (float) panicDelay
{
	return (panicDelay);
}

+ (void) setPanicDelay:(float)delay
{
	panicDelay = delay;
}

+ (int) unblockDelay
{
	return (unblockDelay);
}

+ (void) setUnBlockDelay:(int)delay
{
	unblockDelay = delay;
}

+ (int) reminderPeriod
{
	return (reminderPeriod);
}

+ (void) setReminderPeriod:(int)reminderPeriod
{
	reminderPeriod = reminderPeriod;
}

+ (NSString *) getkeyChainIdentifier {
    return @"Community";
}

@end
