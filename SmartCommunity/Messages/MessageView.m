//
//  MessageView.m
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView
@synthesize date, message, icon, line, affinityName;


- (void) setDateString : (NSString *) startDate {
    
    
    NSArray *startDateArray = [startDate componentsSeparatedByString:@"T"];
    NSArray *dateArray = [[startDateArray objectAtIndex:0] componentsSeparatedByString:@"-"];
    NSArray *hour = [[startDateArray objectAtIndex:1] componentsSeparatedByString:@":"];
    
    
    self.date.text = [NSString stringWithFormat:@"%@/%@  %@:%@", [dateArray objectAtIndex:2], [dateArray objectAtIndex:1], [hour objectAtIndex:0], [hour objectAtIndex:1]];
}

- (void) updateScreenHeight {
    //CGFloat fixedWidth = message.frame.size.width;
    //CGSize newSize = [message sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    //CGRect newFrame = message.frame;
    //newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    //message.frame = newFrame;
    [message sizeToFit];
    [message layoutIfNeeded];
    
    
    CGFloat fixedViewWidth = self.frame.size.width;
    CGRect newViewFrame = self.frame;
    newViewFrame.size = CGSizeMake(fixedViewWidth, message.frame.size.height + 40);
    self.frame = newViewFrame;
    
    
    
    /*
    int charactersPerLine = 43;
    
    int lineCount = (int)[self.message.text length] / charactersPerLine;
    int divisionRest = [self.message.text length] % charactersPerLine;
    if (divisionRest > 0) {
        lineCount++;
    }
    
    if (lineCount > 1) {
        int i = 1;
        int lineHeight = self.message.font.lineHeight;
        int viewHeightOffset = 0;
        
        CGRect frame;
        frame = self.message.frame;

        while (i <  lineCount) {
            frame.size.height = frame.size.height + lineHeight;
            viewHeightOffset = viewHeightOffset + lineHeight;
            i++;
        }
        
        self.message.frame = frame;
        
        frame = self.frame;
        frame.size.height = frame.size.height + viewHeightOffset;
        self.frame = frame;
        
        frame = self.line.frame;
        frame.origin.y = self.line.frame.origin.y + viewHeightOffset;
        self.line.frame = frame;
    }*/
}

- (void) setColors {
    [self.date setTextColor:[UIColor colorWithRed:240/255.0 green:93/255.0 blue:94/255.0 alpha:1.0f]];
    [self.line setTextColor:[UIColor colorWithRed:54/255.0 green:153/255.0 blue:127/255.0 alpha:1.0f]];
    [self.message setTextColor :[UIColor colorWithRed:153/255.0 green:153/255.0 blue:154/255.0 alpha:1.0f]];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}

- (void) setModel : (NSDictionary *) messageModel {
    [self setColors];
    [self setDateString:[messageModel objectForKey:@"timestamp"]];
    self.message.text = [messageModel objectForKey:@"text"];
    self.affinityName.text = [[messageModel objectForKey:@"affinity"] objectForKey:@"name"];
    [self updateScreenHeight];
}




@end
