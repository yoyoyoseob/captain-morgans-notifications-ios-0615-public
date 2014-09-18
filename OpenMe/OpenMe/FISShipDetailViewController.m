//
//  FISShipDetailViewController.m
//  OpenMe
//
//  Created by Joe Burgess on 3/4/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISShipDetailViewController.h"
#import "Pirate.h"
#import "Engine.h"

@interface FISShipDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shipNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pirateNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *propTypeLabel;

@end

@implementation FISShipDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shipNameLabel.text = self.ship.name;
    self.pirateNameLabel.text = self.ship.pirate.name;
    self.propTypeLabel.text = self.ship.engine.engineType;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
