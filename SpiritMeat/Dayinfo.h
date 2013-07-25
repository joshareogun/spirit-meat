//
//  Dayinfo.h
//  SpiritMeat
//
//  Created by Joshua Areogun on 3/13/13.
//  Copyright (c) 2013 The Dream Centre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Dayinfo : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * topic;
@property(nonatomic, retain) NSString *dayOfTheMonth;
@property (nonatomic, retain) NSManagedObject *content;

@end
