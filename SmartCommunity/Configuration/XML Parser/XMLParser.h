//
//  XMLParser.h
//  XML
//
//  Created by iPhone SDK Articles on 11/23/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import <UIKit/UIKit.h>

@interface XMLParser : NSObject  <NSXMLParserDelegate> {

	NSMutableString *currentElementValue;
}

- (XMLParser *) initXMLParser;

@end
