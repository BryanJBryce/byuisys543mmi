//
//  MasterViewController.m
//  MMI
//
//  Created by Bryan Bryce on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"



@implementation MasterViewController

@synthesize detailViewController = _detailViewController, inventoryDetailVC, reviewDetailVC, summaryDetailVC;

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    
    inventoryDetailVC = [[InventoryDetailVC alloc] initWithNibName:@"InventoryDetailVC" bundle:nil];
    reviewDetailVC = [[ReviewDetailVC alloc] initWithNibName:@"ReviewDetailVC" bundle:nil];
    summaryDetailVC = [[SummaryDetailVC alloc] initWithNibName:@"SummaryDetailVC" bundle:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.]
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{    
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSUInteger row = self.tableView.indexPathForSelectedRow.row;
    
    if (row == 0) {
        NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, inventoryDetailVC, nil];
        self.splitViewController.viewControllers = viewControllers;
        [super viewDidDisappear:animated];
    }
    
    if (row == 1) {
        NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, reviewDetailVC, nil];
        self.splitViewController.viewControllers = viewControllers;
        [super viewDidDisappear:animated];
    }
    
    if (row == 2) {
        NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, summaryDetailVC, nil];
        self.splitViewController.viewControllers = viewControllers;
        [super viewDidDisappear:animated];
    }
    
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
