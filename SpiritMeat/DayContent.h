//
//  DayContent.h
//  SpiritMeat
//
//  Created by Joshua Areogun on 3/13/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Dayinfo;

@interface DayContent : NSManagedObject

@property (nonatomic, retain) NSString * actualContent;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Dayinfo *info;

@end
