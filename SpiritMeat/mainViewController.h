//
//  mainViewController.h
//  SpiritMeat
//
//  Created by Joshua Areogun on 3/11/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface mainViewController : UIViewController

@property(nonatomic, strong)NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UITextView *ipadTextView;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipadTopicLabel;

@property (weak, nonatomic) NSArray *DayInfos;
@property (weak, nonatomic) NSArray *DayDetails;


@end
