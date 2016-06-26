//
//  AutoSizeManager.m
//  Sesami
//
//  Created by Constanza Areco on 02/10/12.
//  Copyright (c) 2012 Smart Secure. All rights reserved.
//

#import "AutoSizeManager.h"

@implementation AutoSizeManager

+ (BOOL)isTallScreen {
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat height = bounds.size.height;
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    return (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            && ((height * scale) >= 1136));
}

+ (CGFloat) getHowManyPositionsMoveOnY {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat height = bounds.size.height;
    return(height - DEFAULT_SCREEN_SIZE);
}


+ (NSString *) getCorrectNibFileName : (NSString *) basicScreenName {
    NSString * nibFileName;
    if ([self isTallScreen]) {
        nibFileName = [[NSString alloc] initWithFormat:@"%@%@", basicScreenName, @"TallScreen"];
    } else {
        nibFileName = [[NSString alloc] initWithString:basicScreenName];
    }
    return nibFileName;
}

@end
