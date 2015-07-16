//
//  Ship+FISShipFromDictionary.h
//  OpenMe
//
//  Created by Yoseob Lee on 7/15/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "Ship.h"

@interface Ship (FISShipFromDictionary)

+(Ship *)shipFromDictionary:(NSDictionary *)dictionary andContext:(NSManagedObjectContext *)context;

@end
