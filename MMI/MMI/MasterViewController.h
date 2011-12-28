//
//  MasterViewController.h
//  MMI
//
//  Created by Bryan Bryce on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InventoryDetailVC.h"
#import "ReviewDetailVC.h"
#import "SummaryDetailVC.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) InventoryDetailVC *inventoryDetailVC;
@property (strong, nonatomic) ReviewDetailVC *reviewDetailVC;
@property (strong, nonatomic) SummaryDetailVC *summaryDetailVC;


@end
