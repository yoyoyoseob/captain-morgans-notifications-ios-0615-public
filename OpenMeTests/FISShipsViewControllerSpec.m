//
//  FISShipsViewControllerSpec.m
//  OpenMe
//
//  Created by Zachary Drossman on 11/21/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#import "FISShipsViewController.h"
#import "FISPiratesDataStore.h"
#import "FISAppDelegate.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"

SpecBegin(FISShipsViewController)

describe(@"FISShipsViewController", ^{
    
    __block FISPiratesDataStore *store;
    
    beforeAll(^{
        FISAppDelegate *appDelegate = (FISAppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
        
        store = [FISPiratesDataStore sharedPiratesDataStore];
        
        [store fetchData];
        
        FISShipsViewController *shipsViewController = [storyboard instantiateViewControllerWithIdentifier:@"ShipsTableViewController"];
        
        shipsViewController.pirate = store.pirates[0];

        appDelegate.window.rootViewController = shipsViewController;
                                      

        
    });
    
    __block UITableView *tableView;
    beforeEach(^{
        tableView = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"ShipsTableView"];
        
    });
    
    describe(@"ShipsTableView", ^{
        
        it(@"should have three rows", ^{
            expect([tableView numberOfRowsInSection:0]).to.equal(2);
        });
        
        it(@"should display the ships name in the text field, in sorted order", ^{
            NSIndexPath *row = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"ShipsTableView"];
            expect(cell.textLabel.text).to.equal(@"Awesome Ship #1");
            
            row = [NSIndexPath indexPathForRow:1 inSection:0];
            cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"ShipsTableView"];
            
            expect(cell.textLabel.text).to.equal(@"Awesome Ship #2");
        });
    });});

SpecEnd
