//
//  Engine.h
//  OpenMe
//
//  Created by Chris Gonzales on 9/17/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ship;

@interface Engine : NSManagedObject

@property (nonatomic, retain) NSString * engineType;
@property (nonatomic, retain) Ship *ship;

@end
