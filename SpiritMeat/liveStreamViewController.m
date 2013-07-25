//
//  liveStreamViewController.m
//  SpiritMeat
//
//  Created by Joshua Areogun on 6/24/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import "liveStreamViewController.h"

@interface liveStreamViewController ()

@end

@implementation liveStreamViewController

@synthesize webview, ipadWebview;

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
    NSURL *url = [NSURL URLWithString:@"http://www.lifestream.tv/dreamcentrelivestreamtv/"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webview loadRequest:req];
    [ipadWebview loadRequest:req];
    [super viewDidLoad];
    
    [self appearanceCustomizations];
}

-(void)appearanceCustomizations
{
    self.navigationItem.title = @"LiveStream";
}
- (void)viewDidUnload {
    [self setWebview:nil];
    [self setIpadWebview:nil];
    [super viewDidUnload];
}
@end
