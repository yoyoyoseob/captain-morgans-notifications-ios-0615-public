//
//  Ship.h
//  OpenMe
//
//  Created by Chris Gonzales on 9/17/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Engine, Pirate;

@interface Ship : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Engine *engine;
@property (nonatomic, retain) Pirate *pirate;

@end
