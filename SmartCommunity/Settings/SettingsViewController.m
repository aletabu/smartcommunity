//
//  SettingsViewController.m
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"
#import "KeyChainHelper.h"
#import "SettingsView.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize redTitle, messageTextField, acceptButton, scrollView, incidentText, incidentTitle, startTimeText, startTimeTitle, stateText, stateTitle, cancelButton, model, networkId, eventList, noEventsLabel, currentEventView, sendMessageBackground, cancel2Button;


- (void) updateInfo : (NSDictionary *) eventsInfo {
    self.model = eventsInfo;
    
    [self loadInfo];
}

- (void) setEventPosition : (int) position{
    eventPosition = position;
}


- (void) setEventsModelFromKeyChain : (KeyChainHelper *) keyChain {
    
    NSString * networksInfo = [keyChain loadNetworks];
    
    if (networksInfo) {
        self.model = [networksInfo propertyList];
    }
    
    [self loadInfo];

}

- (void) hideMessageComponent {
    
    [self.messageTextField setHidden:YES];
    [self.sendMessageBackground setHidden:YES];
    
}

- (void) showMessageComponent {
    
    [self.messageTextField setHidden:NO];
    [self.sendMessageBackground setHidden:NO];

}

- (void) showScrollView : (BOOL) show {
    
    if (show) {
        [self.scrollView setHidden:NO];
        [self.currentEventView setHidden:NO];
        [self.sendMessageBackground setHidden:NO];
        [self.messageTextField setHidden:NO];
        [self.noEventsLabel setHidden:YES];
    } else {
        [self.scrollView setHidden:YES];
        [self.currentEventView setHidden:YES];
        [self.sendMessageBackground setHidden:YES];
        [self.messageTextField setHidden:YES];

        [self.noEventsLabel setHidden:NO];
    }
}

- (void) updateEventList {
    [self.eventList removeAllObjects];
    
    if ([self.model count] > 0) {
        
        [self showScrollView:YES];
      //  [self updateArrowsState];
        
        for (NSDictionary * network in self.model) {
            id netId = [network objectForKey:@"id"];
            if ([netId isKindOfClass : [NSString class] ]) {
                if ([[network objectForKey:@"id"] isEqualToString: networkId]) {
                    if ([[network objectForKey:@"community_affinities"] count] > 0) {
                        [self.eventList  addObject:[network objectForKey:@"community_affinities"]];
                    }
                    break;
                }
                
            } else {
                if ([[[network objectForKey:@"id"] stringValue] isEqualToString: networkId]) {
                    if ([[network objectForKey:@"community_affinities"] count] > 0) {
                        [self.eventList  addObject:[network objectForKey:@"community_affinities"]];
                    }
                    break;
                }
                
            }
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
    

    if ([self.eventList count] > 0) {
        for (NSDictionary * messageModel in [self.eventList objectAtIndex:0]) {
            
            SettingsView *message = [[NSBundle mainBundle]
                                     loadNibNamed:@"SettingsView"
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
        [acceptButton setHidden:NO];
        [cancelButton setHidden:NO];
        [cancel2Button setHidden:YES];
        [self.noEventsLabel setHidden:YES];

    } else {
        [acceptButton setHidden:YES];
        [cancelButton setHidden:YES];
        [cancel2Button setHidden:NO];
        [self.noEventsLabel setHidden:NO];

    }
    
    self.scrollView.contentSize = CGSizeMake(contactWidth, contactHeight);
    
/*    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom);
    [self.scrollView setContentOffset:bottomOffset animated:NO];
 */
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
    
    [self.serverRequestController getAffinitiesSettings :self.networkId :self.superViewController];
}

- (void) setColors {
    [currentEventView setBackgroundColor:[UIColor colorWithRed:54/255.0 green:153/255.0 blue:127/255.0 alpha:1.0f]];
    [self.messageTextField setTextColor:[UIColor colorWithRed:54/255.0 green:153/255.0 blue:127/255.0 alpha:1.0f]];
    [self.sendMessageBackground setBackgroundColor:[UIColor colorWithRed:28/255.0 green:79/255.0 blue:65/255.0 alpha:1.0f]];
}

- (void) loadButton {
    UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[acceptButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
    [cancel2Button setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];

    [acceptButton setTitle: NSLocalizedString(@"Accept", @"") forState:UIControlStateNormal];
    [cancelButton setTitle: NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
    [cancel2Button setTitle: NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];

    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadButton];
    
    KeyChainHelper * keyChain = [[KeyChainHelper alloc] init];
    [self.redTitle setMinimumScaleFactor:11.0];

    self.redTitle.text = [[[keyChain loadSelectedNetwork] propertyList] objectForKey:@"name"];
    self.networkId = [[[keyChain loadSelectedNetwork] propertyList] objectForKey:@"id"];
    
    [self getInfoFromServer];
    
    [self setColors];
    
    self.noEventsLabel.text = NSLocalizedString(@"NoAffinitiesMessagesText", @"");

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

- (NSMutableArray *) getSelectedAffinities {

    NSMutableArray * affinitiesIds = [[NSMutableArray alloc] init];
    
    for (SettingsView *view in self.scrollView.subviews) {
        if ([view.switchState isOn]) {
            if ([view.affinityId isKindOfClass : [NSString class] ]) {
                [affinitiesIds addObject : view.affinityId];
            } else {
                [affinitiesIds addObject : [view.affinityId stringValue]];
            }
            
        }
    }
    
    
    return affinitiesIds;
}

- (IBAction) chooseNetwork : (id)sender {
    [self.superViewController loadChooseNetScreen : @"SETTINGS"];
}

- (IBAction) showMessagesScreen : (id)sender {
    [self.superViewController loadMessagesScreen];
}

- (IBAction) acceptChanges : (id)sender {
    
    NSMutableArray * affinitiesIds = [self getSelectedAffinities];
    
    [self.serverRequestController updateAffinitiesSettings:self.networkId :affinitiesIds :self.superViewController : self];
}

@end
