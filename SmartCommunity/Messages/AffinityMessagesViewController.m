//
//  ModeratorMessagesViewController.m
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "AffinityMessagesViewController.h"
#import "ViewController.h"
#import "KeyChainHelper.h"
#import "MessageView.h"

@interface AffinityMessagesViewController ()

@end

@implementation AffinityMessagesViewController
@synthesize redTitle, messageTextField, sendButton, scrollView, incidentText, incidentTitle, startTimeText, startTimeTitle, stateText, stateTitle, arrowLeftButton, arrowrightButton, model, networkId, eventList, noEventsLabel, currentEventView, sendMessageBackground;


- (void) updateInfo : (NSDictionary *) eventsInfo {
    self.model = eventsInfo;
    
    [self loadInfo];
}

- (void) setEventPosition : (int) position{
    eventPosition = position;
}


- (void) setEventsModelFromKeyChain : (KeyChainHelper *) keyChain {
    
    NSString * eventsInfo = [keyChain loadEventsInfoForNetwork:self.networkId];
    
    if (eventsInfo) {
        self.model = [eventsInfo propertyList];
    }
    
    [self loadInfo];

}

- (void) setDate : (NSString *) startDate {
   
    
    NSArray *startDateArray = [startDate componentsSeparatedByString:@"T"];
    NSArray *date = [[startDateArray objectAtIndex:0] componentsSeparatedByString:@"-"];
    NSArray *hour = [[startDateArray objectAtIndex:1] componentsSeparatedByString:@":"];

    
    self.startTimeText.text = [NSString stringWithFormat:@"%@/%@/%@  %@:%@", [date objectAtIndex:2], [date objectAtIndex:1], [date objectAtIndex:0], [hour objectAtIndex:0], [hour objectAtIndex:1]];

}

- (void) hideMessageComponent {
    
    [self.messageTextField setHidden:YES];
    [self.sendButton setHidden:YES];
    [self.sendMessageBackground setHidden:YES];
    
}

- (void) showMessageComponent {
    
    [self.messageTextField setHidden:NO];
    [self.sendButton setHidden:NO];
    [self.sendMessageBackground setHidden:NO];

}

- (void) updateSendMessageComponentsState : (NSDictionary *) event{
    
    if ([[event objectForKey:@"status"] isEqualToString:@"RESOLVED"]) {
        [self hideMessageComponent];
    } else {
        [self showMessageComponent];
    }
}

- (void) updateEventState : (NSDictionary *) event{
    
    if ([[event objectForKey:@"status"] isEqualToString:@"RESOLVED"]) {
        self.stateText.text = NSLocalizedString(@"ResolvedState", @"");
    } else {
        self.stateText.text = NSLocalizedString(@"ActiveState", @"");
    }
}

- (void) showScrollView : (BOOL) show {
    
    if (show) {
        [self.scrollView setHidden:NO];
        [self.currentEventView setHidden:NO];
        [self.sendMessageBackground setHidden:NO];
        [self.sendButton setHidden:NO];
        [self.messageTextField setHidden:NO];
        [self.noEventsLabel setHidden:YES];
    } else {
        [self.scrollView setHidden:YES];
        [self.currentEventView setHidden:YES];
        [self.sendMessageBackground setHidden:YES];
        [self.sendButton setHidden:YES];
        [self.messageTextField setHidden:YES];

        [self.noEventsLabel setHidden:NO];
    }
}

- (void) updateArrowsState {
    
    if ([[self.model objectForKey:@"count"] integerValue] == 1) {
        [self.arrowLeftButton setHidden:YES];
        [self.arrowrightButton setHidden:YES];
    } else {
        [self.arrowLeftButton setHidden:NO];
        [self.arrowrightButton setHidden:NO];
    }

}

- (void) updateEventList {
    [self.eventList removeAllObjects];
    
    if ([[self.model objectForKey:@"count"] integerValue] > 0) {
        
        [self showScrollView:YES];
      //  [self updateArrowsState];
        
        for (NSDictionary * event in [self.model objectForKey:@"results"]) {
            [self.eventList  addObject:event];
        }
        
      //  [self selectEvent:eventPosition];
        [self updateMessagesForCurrentNetwork];

    } else {
        [self showScrollView:NO];
    }
}

- (void) updateMessagesForCurrentNetwork {
    int contactWidth = 0;
    int contactHeight = 0;
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    

    int i;
    
    for ((i = (int)([self.eventList count] - 1)); i  >  -1 ;i --) {
        
        NSDictionary * messageModel = [self.eventList objectAtIndex:i];
        
        MessageView *message = [[NSBundle mainBundle]
                                loadNibNamed:@"MessageView"
                                owner:self options:nil].lastObject;
        
        [message setModel:messageModel];
        
        CGRect frame = message.frame;
        contactWidth = frame.size.width;
        frame.origin.x = 0;
        frame.origin.y = contactHeight;
        contactHeight = contactHeight + frame.size.height;

        message.frame = frame;
        
        
        [self.scrollView addSubview:message];
        
    }
    
    self.scrollView.contentSize = CGSizeMake(contactWidth, contactHeight);
    
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom);
    [self.scrollView setContentOffset:bottomOffset animated:NO];
}

- (void) loadInfo {
    [self updateEventList];
}


- (NSString *) getEventId {
    NSString *eventId;
    NSDictionary * event = [self.eventList objectAtIndex:eventPosition];
    if (event) {
        eventId = [event objectForKey:@"id"];
    }
    return eventId;
}


- (void) showAlert : (NSString *) title : (NSString *) msg {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:msg
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
}



- (void) getInfoFromServer {
    
    [self.serverRequestController getActivityInfoForNetwork:self.networkId :self.superViewController];
}

- (void) setColors {
    [currentEventView setBackgroundColor:[UIColor colorWithRed:54/255.0 green:153/255.0 blue:127/255.0 alpha:1.0f]];
    [self.messageTextField setTextColor:[UIColor colorWithRed:54/255.0 green:153/255.0 blue:127/255.0 alpha:1.0f]];
    [self.sendMessageBackground setBackgroundColor:[UIColor colorWithRed:28/255.0 green:79/255.0 blue:65/255.0 alpha:1.0f]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    KeyChainHelper * keyChain = [[KeyChainHelper alloc] init];
    [self.redTitle setMinimumScaleFactor:11.0];

    self.redTitle.text = [[[keyChain loadSelectedNetwork] propertyList] objectForKey:@"name"];
    self.networkId = [[[keyChain loadSelectedNetwork] propertyList] objectForKey:@"id"];
    
    [self getInfoFromServer];
    
    [self setColors];
    
    self.incidentTitle.text = NSLocalizedString(@"IncidentTitle", @"");
    self.startTimeTitle.text = NSLocalizedString(@"StartTitle", @"");
    self.stateTitle.text = NSLocalizedString(@"StateTitle", @"");
    self.noEventsLabel.text = NSLocalizedString(@"NoEventMessagesText", @"");

    self.messageTextField.placeholder = NSLocalizedString(@"EnterMessageText", @"");
    self.eventList = [[NSMutableArray alloc] init];
    [self setEventsModelFromKeyChain : keyChain];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)evt
{
    [self dismissKeyboard:nil];
}

- (IBAction)dismissKeyboard:(id)sender {
    
    [self.view endEditing:YES];
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 205; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= 150 && range.length == 0)
    {
    	return NO; // return NO to not change text
    }
    else
    {return YES;}
}

- (IBAction) chooseNetwork : (id)sender {
    [self.superViewController loadChooseNetScreen : @"MESSAGES"];
}

- (IBAction) showSettingsScreen : (id)sender {
    [self.superViewController loadSettingsScreen];
}


@end
