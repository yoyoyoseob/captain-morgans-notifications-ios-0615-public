//
//  FISPiratesDataStoreSpec.m
//  OpenMe
//
//  Created by Zachary Drossman on 11/20/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#import "FISPiratesDataStore.h"
#import "FISAppDelegate.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"


SpecBegin(FISPiratesDataStore)

describe(@"FISPiratesDataStore", ^{
    
    __block FISPiratesDataStore *dataStore;
    __block NSManagedObjectContext *testingContext;
    
    beforeAll(^{
        dataStore = [FISPiratesDataStore sharedPiratesDataStore];
    });
    
    beforeEach(^{

        NSBundle *bundle =
        [NSBundle bundleForClass:NSClassFromString(@"FISPiratesDataStore")];
        
        NSString *path =
        [bundle pathForResource:@"OpenMe" ofType:@"momd"];
        NSURL *momdURL = [NSURL fileURLWithPath:path];
        NSManagedObjectModel *model =
        [[NSManagedObjectModel alloc] initWithContentsOfURL:momdURL];
        NSPersistentStoreCoordinator *coord =
        [[NSPersistentStoreCoordinator alloc]
         initWithManagedObjectModel:model];
        [coord addPersistentStoreWithType:NSInMemoryStoreType
                            configuration:nil URL:nil options:nil error:nil];
        testingContext = [[NSManagedObjectContext alloc] init];
        [testingContext setPersistentStoreCoordinator:coord];
        dataStore.managedObjectContext = testingContext;
        
    });
    
    describe(@"Singleton Initialization", ^{
        it(@"should only be created once", ^{
            expect(dataStore).to.equal(dataStore);
        });
        it(@"should return a PiratesDataStore Instance", ^{
            expect(dataStore).to.beKindOf([FISPiratesDataStore class]);
        });
        it(@"should intercept attempts to alloc init", ^{
            expect(dataStore).to.equal([[FISPiratesDataStore alloc] init]);
        });
    });
 
    describe(@"managed object context", ^{
        it(@"is initialized", ^{
            expect(dataStore.managedObjectContext).to.equal(testingContext);
        });
    });
    
    describe(@"fetchData", ^{
        
        context(@"when empty", ^{
            beforeEach(^{
                [dataStore fetchData];
            });
            it(@"should include three pirates", ^{
                expect([dataStore.pirates count]).to.equal(3);
            });
            
            it(@"should have two ships for the first pirate", ^{
                Pirate *pirate = dataStore.pirates[0];
                expect([pirate.ships count]).to.equal(2);
            });
            
            it(@"should have four ships for the second pirate", ^{
                expect([((Pirate *)dataStore.pirates[1]).ships count]).to.equal(4);
            });
            
            it(@"should have three ships for the third pirate", ^{
                expect([((Pirate *)dataStore.pirates[2]).ships count]).to.equal(3);
            });
            
        });
    });
});

SpecEnd
