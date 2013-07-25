//
//  mainViewController.m
//  SpiritMeat
//
//  Created by Joshua Areogun on 3/11/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import "mainViewController.h"
#import "Dayinfo.h"
#import "DayContent.h"
#import "settingsTableViewController.h"
#import "mainAppDelegate.h"
#import <Parse/Parse.h>

@interface mainViewController ()

@end

@implementation mainViewController

@synthesize myTextView, managedObjectContext, DayInfos, DayDetails, topicLabel, ipadTextView, ipadTopicLabel;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self dataFetch];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];
    
    self.navigationItem.title = @"Today";
}


-(void)viewWillAppear:(BOOL)animated
{
    NSUInteger finalFontSize = [self setFontSize];
    self.myTextView.font = [UIFont fontWithName:@"Avenir Next" size:finalFontSize];
    self.ipadTextView.font = [UIFont fontWithName:@"Avenir Next" size:finalFontSize];
    
    BOOL nightStat = [[NSUserDefaults standardUserDefaults] boolForKey:@"NightModeStatus"];
    BOOL ipadNightStat = [[NSUserDefaults standardUserDefaults] boolForKey:@"ipadNightModeStatus"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (nightStat == YES)
        {
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"escheresque_ste.png"]];
        
            self.topicLabel.textColor = [UIColor whiteColor];
            self.myTextView.textColor = [UIColor whiteColor];
            self.myTextView.backgroundColor = [UIColor colorWithRed:0.2000 green:0.2000 blue:0.2000 alpha:1.0000];
        }
        else
        {
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];
            
            self.topicLabel.textColor = [UIColor blackColor];
            self.myTextView.textColor = [UIColor blackColor];
            self.myTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];
        }
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (ipadNightStat == YES)
        {
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"escheresque_ste.png"]];
        
            self.ipadTopicLabel.textColor = [UIColor whiteColor];
            self.ipadTextView.textColor = [UIColor whiteColor];
            self.ipadTextView.backgroundColor = [UIColor colorWithRed:0.2000 green:0.2000 blue:0.2000 alpha:1.0000];
        
        }
        else
        {
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];
        
            self.ipadTopicLabel.textColor = [UIColor blackColor];
            self.ipadTextView.textColor = [UIColor blackColor];
            self.ipadTextView.backgroundColor = [UIColor whiteColor];
        }
    }
}

-(void)dataFetch
{
    mainAppDelegate *appDelegate = (mainAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dayinfo" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError *error;
    
    self.DayInfos = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for(Dayinfo *info in DayInfos)
    {
        NSLog(@"%@", info.date);
        if ([self isDateCompatible:info.date] == YES)
        {
           NSLog(@"%@", info.date);
            self.topicLabel.text = [NSString stringWithFormat:@" %@ ", info.topic];
            self.topicLabel.font = [UIFont fontWithName:@"Avenir Next" size:17.0];
            self.ipadTopicLabel.text = [NSString stringWithFormat:@" %@ ", info.topic];
            DayContent *content = [info valueForKey:@"content"];
            self.myTextView.text = [NSString stringWithFormat:@" %@ ", content.actualContent];
            self.ipadTextView.text = [NSString stringWithFormat:@" %@ ", content.actualContent];
        }
    }
}


-(NSUInteger)setFontSize
{
    NSString *fontSizeValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"fontSize"];
    NSUInteger fontSize;
    
    if ([fontSizeValue isEqualToString:@"Small"])
    {
        fontSize = 15.0;
    }
    else if ([fontSizeValue isEqualToString:@"Normal"])
    {
        fontSize = 17.0;
    }
    else if ([fontSizeValue isEqualToString:@"Large"])
    {
        fontSize = 19.0;
    }
    else if ([fontSizeValue isEqualToString:@"Extra large"])
    {
        fontSize = 22.0;
    }
    else
    {
        fontSize = 17.0;
    }
    
    return fontSize;
}

-(NSUInteger)setIPadFontSize
{
    NSString *fontSizeValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"ipadFontSize"];
    NSUInteger fontSize;
    
    if ([fontSizeValue isEqualToString:@"Small"])
    {
        fontSize = 15.0;
    }
    else if ([fontSizeValue isEqualToString:@"Normal"])
    {
        fontSize = 17.0;
    }
    else if ([fontSizeValue isEqualToString:@"Large"])
    {
        fontSize = 19.0;
    }
    else if ([fontSizeValue isEqualToString:@"Extra large"])
    {
        fontSize = 22.0;
    }
    else
    {
        fontSize = 17.0;
    }
    
    return fontSize;
}

-(BOOL)isDateCompatible:(NSDate*)date1
{
    
    NSDate* date2 = [NSDate date];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    NSDateComponents *comps2 = [[NSDateComponents alloc]init];
    NSDateComponents *compM1 = [[NSDateComponents alloc]init];
    NSDateComponents *compM2 = [[NSDateComponents alloc] init];
    
    NSInteger infoDay;
    NSInteger todayDay;
    NSInteger infoMonth;
    NSInteger todayMonth;
    
    comps = [gregorianCalendar components:(NSDayCalendarUnit) fromDate:date1];
    comps2 = [gregorianCalendar components:(NSDayCalendarUnit) fromDate:date2];
    compM1 = [gregorianCalendar components:(NSMonthCalendarUnit) fromDate:date1];
    compM2 = [gregorianCalendar components:(NSMonthCalendarUnit) fromDate:date2];
    
    
    infoDay = [comps day];
    todayDay = [comps2 day];
    infoMonth = [compM1 month];
    todayMonth = [compM2 month];
    
    if ((infoDay == todayDay) && (infoMonth == todayMonth))
    {
        return YES;
    }
    else
        return NO;
    
}

@end
