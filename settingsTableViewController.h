//
//  settingsTableViewController.h
//  SpiritMeat
//
//  Created by Joshua Areogun on 3/30/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface settingsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *ipadBrightnessSlider;
@property (weak, nonatomic) IBOutlet UILabel *fontStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipadFontStatusLabel;
@property (weak, nonatomic) IBOutlet UISwitch *nightModeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *ipadNightModeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *reminderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipadReminderLabel;

@end
