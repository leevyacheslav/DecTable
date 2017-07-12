//
//  LVViewController.m
//  DecTable
//
//  Created by vahob@utilitynyc.com on 07/12/2017.
//  Copyright (c) 2017 vahob@utilitynyc.com. All rights reserved.
//

#import "LVViewController.h"
#import <DecTable/LVDecTable.h>
#import "LVRedCell.h"
#import "LVBlueCell.h"

@interface LVViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) LVTableDirector *tableDirector;

@end

@implementation LVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)setUp {
    LVTableDirector *tableDirector = [[LVTableDirector alloc] initWithTableView:self.tableView];
    
    LVTableRow *redRow = [[LVTableRow alloc] initWithCellClass:[LVRedCell class]];
    redRow.config = ^(LVRedCell *cell, NSIndexPath *indexPath) {
        cell.nameLabel.text = @"Red";
    };
   
    LVTableRow *blueRow = [[LVTableRow alloc] initWithCellClass:[LVBlueCell class]];
    blueRow.config = ^(LVBlueCell *cell, NSIndexPath *indexPath) {
        cell.nameLabel.text = @"Blue";
    };
    
    [tableDirector addRows:@[redRow, blueRow]];
    self.tableDirector = tableDirector;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
