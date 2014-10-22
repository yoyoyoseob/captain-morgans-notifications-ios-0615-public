//
//  FISPiratesDataStore.m
//  OpenMe
//
//  Created by Joe Burgess on 3/4/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISPiratesDataStore.h"
#import "Ship.h"
#import "Engine.h"

@interface FISPiratesDataStore ()
typedef NS_ENUM(NSInteger, EngineType) {
    Sail=1,
    Gas,
    Electric,
    Solar
};
@end
@implementation FISPiratesDataStore
@synthesize managedObjectContext = _managedObjectContext;

# pragma mark - Singleton

+ (instancetype)sharedPiratesDataStore {
    static FISPiratesDataStore *_sharedPiratesDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPiratesDataStore = [[FISPiratesDataStore alloc] init];
    });

    return _sharedPiratesDataStore;
}

- (void)save
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }


    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OpenMe.sqlite"];

    NSError *error = nil;

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OpenMe" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];

    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)randomEngine
{
    NSInteger randomInt = arc4random_uniform(4) + 1;
    NSString *engine;
    switch (randomInt) {
        case Sail:
            engine = @"Sail";
            break;
        case Gas:
            engine = @"Gas";
            break;
        case Electric:
            engine = @"Electric";
            break;
        case Solar:
            engine = @"Solar";
            break;
        default:
            engine = @"Oars";
            break;
    }
    return engine;
}

- (void)generateTestData
{
    // test data generation here
    NSArray *numberOfShips = @[@2,@4,@3];
    for (int pirateCount = 0; pirateCount < numberOfShips.count; pirateCount++) {
        Pirate *currentPirate = [NSEntityDescription insertNewObjectForEntityForName:@"Pirate" inManagedObjectContext:self.managedObjectContext];
        currentPirate.name = [NSString stringWithFormat:@"AAARGH! Pirate #%i", pirateCount+1];
        
        for (int shipCount = 0; shipCount < [numberOfShips[pirateCount] intValue]; shipCount++) {
            Ship *currentShip = [NSEntityDescription insertNewObjectForEntityForName:@"Ship" inManagedObjectContext:self.managedObjectContext];
            currentShip.name = [NSString stringWithFormat:@"Awesome Ship #%i", shipCount+1];
            currentShip.engine = [NSEntityDescription insertNewObjectForEntityForName:@"Engine" inManagedObjectContext:self.managedObjectContext];
            currentShip.engine.engineType = [self randomEngine];
            
            [currentPirate addShipsObject:currentShip];
        }
    }
    
    [self save];
    [self fetchData];
}

- (void)fetchData
{
    NSFetchRequest *pirateRequest = [NSFetchRequest fetchRequestWithEntityName:@"Pirate"];

    NSSortDescriptor *nameSorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    pirateRequest.sortDescriptors = @[nameSorter];

    self.pirates = [self.managedObjectContext executeFetchRequest:pirateRequest error:nil];

    if ([self.pirates count]==0) {
        [self generateTestData];
    }
}
@end
