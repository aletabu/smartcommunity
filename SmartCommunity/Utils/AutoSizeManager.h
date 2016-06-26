//
//  AutoSizeManager.h
//  Sesami
//
//  Created by Constanza Areco on 02/10/12.
//  Copyright (c) 2012 Smart Secure. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEFAULT_SCREEN_SIZE	  480

@interface AutoSizeManager : NSObject

+ (BOOL)isTallScreen;
+ (CGFloat) getHowManyPositionsMoveOnY;
+ (NSString *) getCorrectNibFileName : (NSString *) basicScreenName;

@end
