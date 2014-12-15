//
//  FISPiratesViewControllerSpec.m
//  OpenMe
//
//  Created by Zachary Drossman on 11/21/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#import "FISPiratesViewController.h"
#import "FISAppDelegate.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"

SpecBegin(FISPiratesViewController)

describe(@"FISPiratesViewController", ^{
    
    beforeAll(^{
        FISAppDelegate *appDelegate = (FISAppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
        
        FISPiratesViewController *piratesViewController = [storyboard instantiateViewControllerWithIdentifier:@"PiratesTableViewController"];
        
        appDelegate.window.rootViewController = piratesViewController;
        
    });
    
    __block UITableView *tableView;
    beforeEach(^{
       tableView = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"PiratesTableView"];

    });
    
    describe(@"PiratesTableView", ^{
        
        it(@"should have three rows", ^{
            expect([tableView numberOfRowsInSection:0]).to.equal(3);
        });
        
        it(@"should display the pirates name in the table view cell", ^{
            NSIndexPath *row = [NSIndexPath indexPathForRow:0 inSection:0];
             UITableViewCell *cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"PiratesTableView"];
           
            expect(cell.textLabel.text).to.equal(@"AAARGH! Pirate #1");
            
            row = [NSIndexPath indexPathForRow:1 inSection:0];
            cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"PiratesTableView"];

            
            expect(cell.textLabel.text).to.equal(@"AAARGH! Pirate #2");
            
            row = [NSIndexPath indexPathForRow:2 inSection:0];
            cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"PiratesTableView"];
            
            expect(cell.textLabel.text).to.equal(@"AAARGH! Pirate #3");
        });
    });
});

SpecEnd
