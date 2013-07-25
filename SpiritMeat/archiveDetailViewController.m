//
//  archiveDetailViewController.m
//  SpiritMeat
//
//  Created by Joshua Areogun on 3/28/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import "archiveDetailViewController.h"

@interface archiveDetailViewController ()

@end

@implementation archiveDetailViewController

@synthesize topic, topicLabel,ipadTopicLabel, ipadContentTextView, content, contentTextView, dateValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self appearanceCustomizations];
    
    topicLabel.text = topic;
    ipadTopicLabel.text = topic;
    contentTextView.text = content;
    ipadContentTextView.text = content;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUInteger finalFontSize = [self setFontSize];
    self.contentTextView.font = [UIFont fontWithName:@"Avenir Next" size:finalFontSize];
    self.ipadContentTextView.font = [UIFont fontWithName:@"Avenir Next" size:finalFontSize];
    
    BOOL nightStat = [[NSUserDefaults standardUserDefaults] boolForKey:@"NightModeStatus"];
    BOOL ipadNightStat = [[NSUserDefaults standardUserDefaults] boolForKey:@"ipadNightModeStatus"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (nightStat == YES)
        {
           self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"escheresque_ste.png"]];
            
            self.topicLabel.textColor = [UIColor whiteColor];
            self.contentTextView.textColor = [UIColor whiteColor];
            self.contentTextView.backgroundColor = [UIColor colorWithRed:0.2000 green:0.2000 blue:0.2000 alpha:1.0000];
        }
        else
        {
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];
            
            self.topicLabel.textColor = [UIColor blackColor];
            self.contentTextView.textColor = [UIColor blackColor];
            self.contentTextView.backgroundColor = [UIColor whiteColor];
        }
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (ipadNightStat == YES)
        {
           self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"escheresque_ste.png"]];
            
            self.ipadTopicLabel.textColor = [UIColor whiteColor];
            self.ipadContentTextView.textColor = [UIColor whiteColor];
            self.ipadContentTextView.backgroundColor = [UIColor colorWithRed:0.2000 green:0.2000 blue:0.2000 alpha:1.0000];
            
        }
        else
        {
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];
            
            self.ipadTopicLabel.textColor = [UIColor blackColor];
            self.ipadContentTextView.textColor = [UIColor blackColor];
            self.ipadContentTextView.backgroundColor = [UIColor whiteColor];
        }
    }
}

-(void)appearanceCustomizations
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];
    self.navigationItem.title = dateValue;
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

@end
