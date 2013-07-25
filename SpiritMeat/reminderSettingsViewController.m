//
//  reminderSettingsViewController.m
//  SpiritMeat
//
//  Created by Joshua Areogun on 4/29/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import "reminderSettingsViewController.h"

@interface reminderSettingsViewController ()
{
    BOOL reminderIsOn;
    BOOL ipadReminderIsOn;
}
@end

@implementation reminderSettingsViewController

@synthesize timePicker, reminderSwitch, reminderStatus, saveButton, ipadReminderStatus, ipadReminderSwitch, ipadSaveButton, ipadTimePicker;

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
    [self apperanceCustomizations];
    
    timePicker.hidden = YES;
    ipadTimePicker.hidden = YES;
    timePicker.timeZone = [NSTimeZone localTimeZone];
    ipadTimePicker.timeZone = [NSTimeZone localTimeZone];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *status = [[NSUserDefaults standardUserDefaults] objectForKey:@"reminderDate"];
    NSString *ipStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"ipadReminderDate"];
    
    BOOL reminderState = [[NSUserDefaults standardUserDefaults] boolForKey:@"reminderStatus"];
    BOOL ipadReminderState = [[NSUserDefaults standardUserDefaults] boolForKey:@"ipadReminderStatus"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (reminderState == YES)
        {
            [reminderSwitch setOn:YES animated:YES];
        
            self.reminderStatus.text = status;
        }
        else
        {
            self.reminderStatus.text = @"None";
        }
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (ipadReminderState == YES)
        {
            [ipadReminderSwitch setOn:YES animated:YES];
            
            self.ipadReminderStatus.text = ipStatus;
        }
        else
        {
            self.ipadReminderStatus.text = @"None";
        }
    }
}

-(void)apperanceCustomizations
{
   self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];
    self.navigationItem.title = @"Daily Reminder";
}

- (IBAction)reminderToggled:(id)sender
{
    if (reminderSwitch.isOn)
    {
        reminderIsOn = YES;
        timePicker.hidden = NO;
        
        [[NSUserDefaults standardUserDefaults] setBool:reminderIsOn forKey:@"reminderStatus"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *status = [[NSUserDefaults standardUserDefaults] objectForKey:@"reminderDate"];
        
        reminderStatus.text = status;

    }
    
    else
    {
        reminderIsOn = NO;
        timePicker.hidden = YES;
        reminderStatus.text = @"None";
        
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        [[NSUserDefaults standardUserDefaults] setBool:reminderIsOn forKey:@"reminderStatus"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)ipadReminderToggled:(id)sender
{
    if (ipadReminderSwitch.isOn)
    {
        ipadReminderIsOn = YES;
        ipadTimePicker.hidden = NO;
        
        [[NSUserDefaults standardUserDefaults] setBool:ipadReminderIsOn forKey:@"ipadReminderStatus"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *status = [[NSUserDefaults standardUserDefaults] objectForKey:@"ipadReminderDate"];
        
        ipadReminderStatus.text = status;
        
    }
    
    else
    {
        ipadReminderIsOn = NO;
        ipadTimePicker.hidden = YES;
        ipadReminderStatus.text = @"None";
        
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        [[NSUserDefaults standardUserDefaults] setBool:ipadReminderIsOn forKey:@"ipadReminderStatus"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

- (IBAction)ipadSaveReminderButtonPressed:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *ipdateString = [formatter stringFromDate:self.ipadTimePicker.date];
    
    NSLog(@"Here's the date %@", ipdateString);
    
    ipadReminderStatus.text = ipdateString;
    
    [[NSUserDefaults standardUserDefaults] setObject:ipdateString forKey:@"ipadReminderDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self ipadReminderFire];
}

- (IBAction)saveReminderButtonPressed:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateString = [formatter stringFromDate:self.timePicker.date];
    
    NSLog(@"Here's the date %@", dateString);
    
    reminderStatus.text = dateString;
    
    [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"reminderDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reminderFire];
}

-(void)reminderFire
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm"];
    NSString *firstDateString = [[NSUserDefaults standardUserDefaults] objectForKey:@"reminderDate"];
    
    NSDate *finalReminderDate = [format dateFromString:firstDateString];
       [calendar setTimeZone:[NSTimeZone localTimeZone]];
    
    NSLog(@"Used Date : %@", finalReminderDate);
    
    UILocalNotification *notif = [[UILocalNotification alloc]init];
    
    [notif setFireDate:finalReminderDate];
    [notif setTimeZone:[NSTimeZone localTimeZone]];
    notif.repeatInterval = NSDayCalendarUnit;
    
    notif.alertBody = @"Hello there, It's time to For Today's Spirit Meat Devotion";
    notif.alertAction = @"Read";
    notif.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    
}

-(void)ipadReminderFire
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm"];
    NSString *firstDateString = [[NSUserDefaults standardUserDefaults] objectForKey:@"ipadReminderDate"];
    
    NSDate *finalReminderDate = [format dateFromString:firstDateString];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    
    NSLog(@"Used Date : %@", finalReminderDate);
    
    UILocalNotification *notif = [[UILocalNotification alloc]init];
    
    [notif setFireDate:finalReminderDate];
    [notif setTimeZone:[NSTimeZone localTimeZone]];
    notif.repeatInterval = NSDayCalendarUnit;
    
    notif.alertBody = @"Hello there, It's time to For Today's Spirit Meat Devotion";
    notif.alertAction = @"Read";
    notif.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];

}



- (void)viewDidUnload {
    [self setSaveButton:nil];
    [self setIpadReminderSwitch:nil];
    [self setIpadReminderStatus:nil];
    [self setIpadSaveButton:nil];
    [self setIpadTimePicker:nil];
    [self setIpadTimePicker:nil];
    [super viewDidUnload];
}
@end
