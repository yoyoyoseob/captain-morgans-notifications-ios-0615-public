//
//  FISAddShipViewControllerSpec.m
//  OpenMe
//
//  Created by Zachary Drossman on 11/19/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#import "FISPiratesDataStore.h"
#import "FISAddShipViewController.h"
#import "FISAppDelegate.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"

SpecBegin(FISAddShipViewController)

describe(@"FISAddShipViewController", ^{
    
    __block FISAppDelegate *appDelegate;
    __block FISAddShipViewController *addShipVC;
    __block NSManagedObjectContext *testingContext = [[NSManagedObjectContext alloc] init];

    beforeAll(^{
        
        appDelegate = (FISAppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
        
        addShipVC = [storyboard instantiateViewControllerWithIdentifier:@"FISAddShipViewController"];
        
        appDelegate.window.rootViewController = addShipVC;

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
        [FISPiratesDataStore sharedPiratesDataStore].managedObjectContext = testingContext;
        
    });
    
   
    
    describe(@"saveButtonTapped", ^{
        
        it(@"should post a notification with new ship info", ^{
            
            [tester enterText:@"Best Ship" intoViewWithAccessibilityLabel:@"ShipTextField"];
            
            [tester enterText:@"Runs on clouds" intoViewWithAccessibilityLabel:@"EngineTypeTextField"];

            Pirate *amberPirate = [NSEntityDescription insertNewObjectForEntityForName:@"Pirate" inManagedObjectContext:[FISPiratesDataStore sharedPiratesDataStore].managedObjectContext];
            
            addShipVC.pirate = amberPirate;
            
            expect(^{
                [tester tapViewWithAccessibilityLabel:@"saveButton"];
            }).to.notify(DataStoreSaveNotification);
        });
    });
    
    describe(@"cancelButtonTapped", ^{
       
        it(@"should dismiss the view", ^{
           
            [tester tapViewWithAccessibilityLabel:@"cancelButton"];
            expect(addShipVC).to.beNil;
        });
    });

});

SpecEnd
