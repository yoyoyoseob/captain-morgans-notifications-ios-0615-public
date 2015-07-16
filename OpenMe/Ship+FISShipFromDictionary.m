//
//  Ship+FISShipFromDictionary.m
//  OpenMe
//
//  Created by Yoseob Lee on 7/15/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "Ship+FISShipFromDictionary.h"
#import "FISPiratesDataStore.h"
#import "Ship.h"
#import "Engine.h"
#import "Pirate.h"

@implementation Ship (FISShipFromDictionary)

+(Ship *)shipFromDictionary:(NSDictionary *)dictionary andContext:(NSManagedObjectContext *)context
{
    NSLog(@"Creating a Ship");
    FISPiratesDataStore *store = [FISPiratesDataStore sharedPiratesDataStore];
    Pirate *pirate = dictionary[@"pirate"];
    Ship *newShip = [NSEntityDescription insertNewObjectForEntityForName:dictionary[@"entity"] inManagedObjectContext:context];
    newShip.name = dictionary[@"shipName"];
    newShip.engine = [NSEntityDescription insertNewObjectForEntityForName:dictionary[@"shipEngineEntity"] inManagedObjectContext:context];
    newShip.engine.engineType = dictionary[@"shipEngineType"];
    
    [pirate addShipsObject:newShip];
    
    NSLog(@"%@", newShip);
    [store save];
    
    return newShip;
}

@end
