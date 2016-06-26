//
//  NSString+stringWithUrlEncode.m
//  Aurora
//
//  Created by Antoine Cicognani on 12.02.09.
//  Copyright (c) 2012 Mediancer. All rights reserved.
//

#import "NSString+stringWithUrlEncode.h"

@implementation NSString (stringWithUrlEncode)

+ (NSString *)stringWithUrlEncode:(NSString *)string {
  NSString *urlEncoded = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes
  (
   NULL, 
   (__bridge CFStringRef)string, 
   NULL, 
   (CFStringRef)@";/?:@&=+$,",
   kCFStringEncodingUTF8
  );

  return urlEncoded;
}
@end