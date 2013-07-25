//
//  reminderSettingsViewController.h
//  SpiritMeat
//
//  Created by Joshua Areogun on 4/29/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reminderSettingsViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISwitch *reminderSwitch;
@property (weak, nonatomic) IBOutlet UILabel *reminderStatus;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *ipadTimePicker;
@property (weak, nonatomic) IBOutlet UISwitch *ipadReminderSwitch;
@property (weak, nonatomic) IBOutlet UILabel *ipadReminderStatus;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *ipadSaveButton;

@end
