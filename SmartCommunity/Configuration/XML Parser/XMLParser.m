//
//  XMLParser.m
//  XML
//
//  Created by iPhone SDK Articles on 11/23/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "XMLParser.h"
#import "ConfigurationData.h"

@implementation XMLParser

- (XMLParser *) initXMLParser {
	
	self = [super init];
		
	return self;
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

	NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\t\n"];
	NSString *cleanString = [[string componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
	
	if(!currentElementValue) 
		currentElementValue = [[NSMutableString alloc] initWithString:cleanString];
	else
		[currentElementValue appendString:cleanString];
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"configuration"])
		return;
	
	if([elementName isEqualToString:@"applicationName"]) {
		[ConfigurationData setApplicationName:currentElementValue];
	}
	else if([elementName isEqualToString:@"applicationVersion"]) {
		[ConfigurationData setApplicationVersion:currentElementValue];
	}
	else if([elementName isEqualToString:@"applicationVendor"]) {
		[ConfigurationData setApplicationVendor:currentElementValue];
	}else if([elementName isEqualToString:@"timeoutApplication"]) {
		[ConfigurationData setTimeoutApplication:[currentElementValue intValue]];
	}
	else if([elementName isEqualToString:@"attempts"]) {
		[ConfigurationData setAttempts:[currentElementValue intValue]];
	}	
	else if([elementName isEqualToString:@"connectionRetry"]) {
		[ConfigurationData setConnectionRetry:[currentElementValue intValue]];
	}
	else if([elementName isEqualToString:@"panicDelay"]) {
		[ConfigurationData setPanicDelay:[currentElementValue floatValue]];
	}		
	else if([elementName isEqualToString:@"unblockDelay"]) {
		[ConfigurationData setUnBlockDelay:[currentElementValue intValue]];
	}		
	else if([elementName isEqualToString:@"networkReminderPeriod"]) {
		[ConfigurationData setReminderPeriod:[currentElementValue intValue]];
	}
	currentElementValue = nil;	
}



@end
