//
//  settingsTableViewController.m
//  SpiritMeat
//
//  Created by Joshua Areogun on 3/30/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import "settingsTableViewController.h"

@interface settingsTableViewController ()

@end

@implementation settingsTableViewController

@synthesize brightnessSlider,ipadBrightnessSlider, fontStatusLabel, ipadFontStatusLabel, nightModeSwitch, ipadNightModeSwitch, reminderLabel, ipadReminderLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self appearanceCustomizations];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *fontStat =[[NSUserDefaults standardUserDefaults] stringForKey:@"fontSize"];
    
    NSString *ipadFontStat = [[NSUserDefaults standardUserDefaults] stringForKey:@"ipadFontSize"];
    NSString *remind = [[NSUserDefaults standardUserDefaults] objectForKey:@"reminderDate"];
    NSString *ipRemind = [[NSUserDefaults standardUserDefaults] objectForKey:@"ipadReminderDate"];
    
    self.reminderLabel.text = remind;
    self.ipadReminderLabel.text = ipRemind;
    self.fontStatusLabel.text = fontStat;
    self.ipadFontStatusLabel.text = ipadFontStat;
    
    BOOL nightStatus = [[NSUserDefaults standardUserDefaults] boolForKey:@"NightModeStatus"];
    BOOL ipadNightStatus = [[NSUserDefaults standardUserDefaults] boolForKey:@"ipadNightModeStatus"];
    
    if (nightStatus == YES)
    {
        [nightModeSwitch setOn:YES animated:YES];
    }
    
    if (ipadNightStatus == YES)
    {
        [ipadNightModeSwitch setOn:YES animated:YES];
    }
}

-(void)appearanceCustomizations
{
    self.navigationItem.title = @"Settings";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];
    
    [self.brightnessSlider setMinimumTrackTintColor:[UIColor colorWithRed:0.7843 green:0.3569 blue:0.5216 alpha:1.0000]];
    [self.ipadBrightnessSlider setMinimumTrackTintColor:[UIColor colorWithRed:0.7843 green:0.3569 blue:0.5216 alpha:1.0000]];
    
}

- (IBAction)brightnessValueChanged:(id)sender
{
    float currentSliderValue = brightnessSlider.value;
    [[UIScreen mainScreen]setBrightness:currentSliderValue];
}

- (IBAction)ipadBrightnessValueChanged:(id)sender
{
    float currentSliderValue = ipadBrightnessSlider.value;
    [[UIScreen mainScreen]setBrightness:currentSliderValue];
}


- (IBAction)nightModeToggled:(id)sender
{
    BOOL nightMode;
    
    if (nightModeSwitch.isOn)
    {
        nightMode = YES;
        
        
        [[NSUserDefaults standardUserDefaults] setBool:nightMode forKey:@"NightModeStatus"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        nightMode = NO;
        
        [[NSUserDefaults standardUserDefaults] setBool:nightMode forKey:@"NightModeStatus"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
- (IBAction)ipadNightModeToggled:(id)sender
{
    BOOL ipadNightMode;
    
    if (ipadNightModeSwitch.isOn)
    {
        ipadNightMode = YES;
        
        
        [[NSUserDefaults standardUserDefaults] setBool:ipadNightMode forKey:@"ipadNightModeStatus"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        ipadNightMode = NO;
        
        [[NSUserDefaults standardUserDefaults] setBool:ipadNightMode forKey:@"ipadNightModeStatus"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

- (IBAction)fbButtonPressed:(id)sender
{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *FBSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        NSURL *fBURL = [NSURL URLWithString:@"http://www.spiritmeat.net"];
        NSString* update = [NSString stringWithFormat:@"Read This Amazing Daily Devotion here: \n %@", fBURL];
        
        [FBSheet setInitialText:update];
        [self presentViewController:FBSheet animated:YES completion:nil];
    }
}
- (IBAction)twButtonPressed:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        NSURL *tweetURL = [NSURL URLWithString:@"http://www.spiritmeat.net"];
        NSString* tweet = [NSString stringWithFormat:@"Read This Amazing Daily Devotion here: \n %@", tweetURL];
        
        [tweetSheet setInitialText:tweet];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (IBAction)ipadTwButtonPressed:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        NSURL *tweetURL = [NSURL URLWithString:@"http://www.spiritmeat.net"];
        NSString* tweet = [NSString stringWithFormat:@"Read This Amazing Daily Devotion here: \n %@", tweetURL];
        
        [tweetSheet setInitialText:tweet];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }

}
- (IBAction)ipadFbButtonPressed:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *FBSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        NSURL *fBURL = [NSURL URLWithString:@"http://www.spiritmeat.net"];
        NSString* update = [NSString stringWithFormat:@"Read This Amazing Daily Devotion here: \n %@", fBURL];
        
        [FBSheet setInitialText:update];
        [self presentViewController:FBSheet animated:YES completion:nil];
    }

}

- (void)viewDidUnload {
    [self setReminderLabel:nil];
    [self setIpadReminderLabel:nil];
    [super viewDidUnload];
}
@end
