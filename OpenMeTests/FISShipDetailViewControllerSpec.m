//
//  FISShipDetailViewControllerSpec.m
//  OpenMe
//
//  Created by Zachary Drossman on 11/21/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#import "FISShipDetailViewController.h"
#import "FISPiratesDataStore.h"
#import "Pirate.h"
#import "FISAppDelegate.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"


SpecBegin(FISShipDetailViewController)

describe(@"FISShipDetailViewController", ^{
    
    __block FISShipDetailViewController *shipDetailVC;
    __block FISPiratesDataStore *store;
    __block NSManagedObjectContext *testingContext = [[NSManagedObjectContext alloc] init];

    beforeAll(^{
        FISAppDelegate *appDelegate = (FISAppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
        
        shipDetailVC = [storyboard instantiateViewControllerWithIdentifier:@"ShipDetailViewController"];
        
        appDelegate.window.rootViewController = shipDetailVC;
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
        
        store = [FISPiratesDataStore sharedPiratesDataStore];
        store.managedObjectContext = testingContext;
        [store fetchData];
        
        Pirate *pirate = store.pirates[0];
        
        shipDetailVC.ship = [pirate.ships allObjects][0];
        [shipDetailVC setupLabels]; //You shouldn't be calling viewDidLoad yourself, so put the setup of your labels in an alternative method and then call it from viewDidLoad.
    });
    
    describe(@"Ship Name Label", ^{
        it (@"should display the name of the ship", ^{
            UILabel *shipNameLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"shipNameLabel"];
            expect(shipNameLabel.text).to.equal(@"Awesome Ship #1");
        });
    });
    
    describe(@"Pirate Label", ^{
        it (@"should display the name of the pirate", ^{
            UILabel *pirateNameLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"pirateNameLabel"];
            expect(pirateNameLabel.text).to.equal(@"AAARGH! Pirate #1");        });
    });
    
    describe(@"Propulsion Type Label", ^{
        it (@"should display the propulsion type of the ship", ^{
            UILabel *propulsionTypeLabel = (UILabel *)[tester waitForViewWithAccessibilityLabel:@"propulsionTypeLabel"];

            expect(propulsionTypeLabel.text).toNot.beNil;
            //cannot test this exactly given it is a random result, so at best we could just test that it is one of the three options for propulsion type. Here we are just testing whether the field is nil or not, but the alternative described is *slightly* more appropriate.
        });
    });
    
});

SpecEnd
