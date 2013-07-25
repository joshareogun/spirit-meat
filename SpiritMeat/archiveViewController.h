//
//  archiveViewController.h
//  SpiritMeat
//
//  Created by Joshua Areogun on 3/11/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface archiveViewController : UITableViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSArray *DayInfos;
@property(nonatomic, strong)NSArray *DayContents;
 
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegmentedControl;

@end
