//
//  MessagesScreenViewController.m
//  Smart Secure
//
//  Created by Constanza Areco on 12/07/13.
//  Copyright (c) 2013 CIDWAY Security. All rights reserved.
//

#import "ChooseNetScreenViewController.h"
#import "AppDelegate.h"
#import "ConfigurationData.h"
#import "ViewController.h"
#import "KeyChainHelper.h"

#define kStackSpacing 6

NSMutableDictionary *idsDictionary;


@interface ChooseNetScreenViewController ()

@end

@implementation ChooseNetScreenViewController

@synthesize sendButton, netTitle, specificationsTitle, messageTextField, scrollView, previousScreen;

- (void) loadSendButton {
    UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[sendButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
}

- (void) addButton : (NSString *) buttonText : (int) position {
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn1 setTitle:buttonText forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(3, position * 49, 277, 44)];
    
    UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[btn1 setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(netSelected:) forControlEvents:UIControlEventTouchUpInside];

    [scrollView addSubview:btn1];


}

- (void) loadMessagesButtons {

    NSDictionary * networks = [self.superViewController getUserNetworks];
    int i = 0;
    for (NSDictionary * network in networks) {
        [self addButton:[network objectForKey:@"name"] :i];
        i++;
    }

    scrollView.contentSize = CGSizeMake(283,50*2);


}

- (IBAction)netSelected:(id)sender {
    UIButton *button = sender;
    
    NSString *netName = button.titleLabel.text;
    NSString *netId;
    NSDictionary * networks = [self.superViewController getUserNetworks];
    for (NSDictionary * network in networks) {
        if ([[network objectForKey:@"name"] isEqualToString:netName]) {
            KeyChainHelper *keyChainHelper = [[KeyChainHelper alloc] init];
            [keyChainHelper saveSelectedNetwork:[network description]];
            break;
        }
    }

    [self chooseNet : netName: netId];
}

- (void) chooseNet : (NSString *) netName : (NSString *) netId  {
    if ([previousScreen isEqualToString:@"MESSAGES"]) {
        [self.superViewController loadMessagesScreen];
    } else {
        [self.superViewController loadSettingsScreen];
    }

}

- (void)viewDidLoad
{
    NSDictionary * networks = [self.superViewController getUserNetworks];
    if ([networks count] > 1) {
        [super viewDidLoad];
        self.specificationsTitle.text = NSLocalizedString(@"NetworkSelectionText", @"");
        [self loadSendButton];
        [self loadMessagesButtons];
        idsDictionary = [[NSMutableDictionary alloc] init];
    } else {
        
        for (NSDictionary * network in networks) {
            KeyChainHelper *keyChainHelper = [[KeyChainHelper alloc] init];
            [keyChainHelper saveSelectedNetwork:[network description]];
            break;
        }

        [self.superViewController loadMessagesScreen];
    }
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

@end
