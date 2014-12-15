//
//  FISAddPirateViewControllerSpec.m
//  OpenMe
//
//  Created by Zachary Drossman on 11/20/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#import "FISPiratesDataStore.h"
#import "FISAddPirateViewController.h"
#import "FISAppDelegate.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"

SpecBegin(FISAddPirateViewController)

describe(@"FISAddPirateViewController", ^{
    __block FISAppDelegate *appDelegate;
    __block FISAddPirateViewController *addPirateVC;
    __block NSManagedObjectContext *testingContext;
    
    beforeAll(^{
        appDelegate = (FISAppDelegate *)[UIApplication sharedApplication].delegate;

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
        
        addPirateVC = [storyboard instantiateViewControllerWithIdentifier:@"AddPirateViewController"];
        
        appDelegate.window.rootViewController = addPirateVC;
        
        
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
        it(@"should call ", ^{
            
            [tester enterText:@"Amber" intoViewWithAccessibilityLabel:@"pirateTextField"];
            
            expect(^{
                [tester tapViewWithAccessibilityLabel:@"saveButton"];
            }).to.notify(DataStoreSaveNotification);
            
        });
    });
    
    describe(@"cancelButtonTapped", ^{
        
        it(@"should dismiss the view", ^{
            
            [tester tapViewWithAccessibilityLabel:@"cancelButton"];
            expect(addPirateVC).to.beNil;
        });
    });
  


});

SpecEnd
