//
//  AboutUsViewController.m
//  SpiritMeat
//
//  Created by Joshua Areogun on 4/3/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    
    NSURL *url = [NSURL URLWithString:@"http://www.lifeoasisinternationalchurch.org/index.php/template-info-2/the-church"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webview loadRequest:req];
    [ipadWebview loadRequest:req];
    [super viewDidLoad];
    
    [self appearanceCustomizations];
}

-(void)appearanceCustomizations
{
    self.navigationItem.title = @"About Us";
}


@end
