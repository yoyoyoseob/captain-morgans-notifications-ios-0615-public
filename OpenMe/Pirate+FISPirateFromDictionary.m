//
//  Pirate+FISPirateFromDictionary.m
//  OpenMe
//
//  Created by Yoseob Lee on 7/15/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "Pirate+FISPirateFromDictionary.h"
#import "FISPiratesDataStore.h"
#import "Pirate.h"

@implementation Pirate (FISPirateFromDictionary)

+(Pirate *)pirateFromDictionary:(NSDictionary *)dictionary andContext:(NSManagedObjectContext *)context
{
    NSLog(@"Creating Pirate");
    FISPiratesDataStore *store = [FISPiratesDataStore sharedPiratesDataStore];
    Pirate *newPirate = [NSEntityDescription insertNewObjectForEntityForName:dictionary[@"entity"] inManagedObjectContext:context];
    newPirate.name = dictionary[@"pirateName"];
    
    [store save];
    
    return newPirate;
}

@end
