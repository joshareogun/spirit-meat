//
//  fontSizeViewController.m
//  SpiritMeat
//
//  Created by Joshua Areogun on 4/5/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import "fontSizeViewController.h"

@interface fontSizeViewController ()
{
    NSMutableArray *fontSizes;
}

@end

@implementation fontSizeViewController

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
    [self dataFetch];
    [self appearanceCustomizations];
    
}


-(void)appearanceCustomizations
{
    self.navigationItem.title = @"Font Size";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];
    
}

-(void)dataFetch
{
    fontSizes = [[NSMutableArray alloc]initWithCapacity:4];
    fontSizes = [NSMutableArray arrayWithObjects:@"Small",@"Normal", @"Large", @"Extra large", nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [fontSizes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    cell.textLabel.text = [fontSizes objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:17.0];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [self.tableView reloadData];
    
    NSString *myString = cell.textLabel.text;
    
    [[NSUserDefaults standardUserDefaults] setObject:myString forKey:@"fontSize"];
    [[NSUserDefaults standardUserDefaults] setObject:myString forKey:@"ipadFontSize"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
