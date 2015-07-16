//
//  Pirate+FISPirateFromDictionary.h
//  OpenMe
//
//  Created by Yoseob Lee on 7/15/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "Pirate.h"

@interface Pirate (FISPirateFromDictionary)

+(Pirate *)pirateFromDictionary:(NSDictionary *)dictionary andContext:(NSManagedObjectContext *)context;

@end
