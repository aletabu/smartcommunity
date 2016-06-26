//
// AffinityMessagesViewController.h
//  Smart Secure
//
//  Created by Constanza Areco on 01/12/13.
//  Copyright (c) 2013 SmartSecure. All rights reserved.
//

#import "SmartCommunityViewController.h"
#import <UIKit/UIKit.h>

@interface AffinityMessagesViewController : SmartCommunityViewController <UITextFieldDelegate> {
    int eventPosition;
}

@property (strong, nonatomic) IBOutlet UILabel *redTitle;
@property (strong, nonatomic) IBOutlet UITextField *messageTextField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *incidentTitle;
@property (strong, nonatomic) IBOutlet UILabel *incidentText;
@property (strong, nonatomic) IBOutlet UILabel *startTimeTitle;
@property (strong, nonatomic) IBOutlet UILabel *startTimeText;
@property (strong, nonatomic) IBOutlet UILabel *stateTitle;
@property (strong, nonatomic) IBOutlet UILabel *stateText;
@property (strong, nonatomic) IBOutlet UILabel *noEventsLabel;

@property (strong, nonatomic) IBOutlet UIButton *arrowLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *arrowrightButton;


@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UIView *currentEventView;
@property (strong, nonatomic) IBOutlet UILabel *sendMessageBackground;

@property (strong, nonatomic)  NSDictionary *model;
@property (strong, nonatomic)  NSString *networkId;
@property (strong, nonatomic)  NSMutableArray *eventList;

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;

- (void) updateInfo : (NSDictionary *) eventsInfo;
- (void) getInfoFromServer;
- (void) setEventPosition : (int) position;
- (IBAction) chooseNetwork : (id)sender;
@end
