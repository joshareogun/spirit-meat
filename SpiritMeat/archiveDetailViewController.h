//
//  archiveDetailViewController.h
//  SpiritMeat
//
//  Created by Joshua Areogun on 3/28/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface archiveDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipadTopicLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITextView *ipadContentTextView;

@property(nonatomic, strong) NSString *topic;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSString *dateValue;

@end
