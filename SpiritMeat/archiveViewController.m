//
//  archiveViewController.m
//  SpiritMeat
//
//  Created by Joshua Areogun on 3/11/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import "archiveViewController.h"
#import "Dayinfo.h"
#import "DayContent.h"
#import "mainAppDelegate.h"
#import "archiveDetailViewController.h"


@interface archiveViewController ()
{
    NSMutableArray *allStrings;
    NSMutableArray *filteredStrings;
    NSMutableArray *allTexts;
    NSMutableArray *allContent;
    NSMutableArray *allDates;
    NSMutableArray *stringDates;
    BOOL isFiltered;
}

@end

@implementation archiveViewController

@synthesize managedObjectContext, DayInfos,mySearchBar,myTableView, mySegmentedControl;

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
    
    self.mySearchBar.delegate = self;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    }

-(void)appearanceCustomizations
{
    self.navigationItem.title = @"Archive";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cream_pixels.png"]];

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
    allStrings = [[NSMutableArray alloc]init];
    allTexts = [[NSMutableArray alloc]init];
    allContent = [[NSMutableArray alloc]init];
    allDates = [[NSMutableArray alloc]init];
    
    for (Dayinfo *info in DayInfos)
    {
        if ([self isDateCompatible:info.date] == YES)
        {
            DayContent *content = [info valueForKey:@"content"];
            [allStrings addObject:info.topic];
            [allTexts addObject:content.text];
            [allContent addObject:content.actualContent];
            [allDates addObject:info.date];
        }
    }
    
    stringDates = [[NSMutableArray alloc]init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    for(NSDate *date in allDates)
    {
        NSString* dateString = [dateFormatter stringFromDate:date];
        [stringDates addObject:dateString];
    }
    

}


-(BOOL)isDateCompatible:(NSDate*)date1
{
    
    NSDate* date2 = [NSDate date];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    NSDateComponents *comps2 = [[NSDateComponents alloc]init];
    NSDateComponents *compsM1 = [[NSDateComponents alloc]init];
    NSDateComponents *compsM2 = [[NSDateComponents alloc]init];
    
    NSInteger infoDay;
    NSInteger todayDay;
    NSInteger infoMonth;
    NSInteger todayMonth;

    comps = [gregorianCalendar components:(NSDayCalendarUnit) fromDate:date1];
    comps2 = [gregorianCalendar components:(NSDayCalendarUnit) fromDate:date2];
    compsM1 = [gregorianCalendar components:(NSMonthCalendarUnit) fromDate:date1];
    compsM2 = [gregorianCalendar components:(NSMonthCalendarUnit) fromDate:date2];
    
    infoDay = [comps day];
    todayDay = [comps2 day];
    infoMonth = [compsM1 month];
    todayMonth = [compsM2 month];
    
    
    if (infoMonth < todayMonth)
    {
            return YES;
    }
    else if (infoMonth == todayMonth)
    {
        BOOL returnVal;
        if (infoDay < todayDay)
        {
            returnVal = YES;
        }
        else
        {
          returnVal = NO;
        }
        return returnVal;
    }
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0)
    {
        isFiltered = NO;
    }
    else
    {
        isFiltered = YES;
        filteredStrings = [[NSMutableArray alloc]init];
        
        for(NSString *str in allStrings)
        {
            NSRange stringRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (stringRange.location != NSNotFound)
            {
                [filteredStrings addObject:str];
            }
        }
    }
    
    [self.myTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.mySearchBar resignFirstResponder];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.mySearchBar resignFirstResponder];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFiltered)
    {
        return [filteredStrings count];
    }
    
    return [allStrings count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!isFiltered)
    {
            Dayinfo *info = [DayInfos objectAtIndex:indexPath.row];
            
            NSString *stringyDate;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            stringyDate =  [formatter stringFromDate:info.date];
            
            cell.textLabel.text = info.topic;
            cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:17.0];
            cell.detailTextLabel.text = stringyDate;
            cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir Next" size:12.0];
    }
    else
    {
        cell.textLabel.text = [filteredStrings objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:17.0];
    } 
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showArchiveDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        archiveDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.topic = [allStrings objectAtIndex:indexPath.row];
        destinationVC.text = [allTexts objectAtIndex:indexPath.row];
        destinationVC.content = [allContent objectAtIndex:indexPath.row];
        destinationVC.dateValue = [stringDates objectAtIndex:indexPath.row];
        
    }
    else if([segue.identifier isEqualToString:@"ipadSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        archiveDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.topic = [allStrings objectAtIndex:indexPath.row];
        destinationVC.text = [allTexts objectAtIndex:indexPath.row];
        destinationVC.content = [allContent objectAtIndex:indexPath.row];
        destinationVC.dateValue = [stringDates objectAtIndex:indexPath.row];
        
    }
}

@end
