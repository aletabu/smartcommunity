//
//  SmartCommunityViewController.m
//  Smart Secure
//
//  Created by Constanza Areco on 16/07/13.
//  Copyright (c) 2013 Topgrade Solutions S.A. All rights reserved.
//

#import "SmartCommunityViewController.h"


@implementation SmartCommunityViewController
@synthesize superViewController;

- (void) requestFailed {

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
