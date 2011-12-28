//
//  InventoryDetailVC.m
//  MMI
//
//  Created by Bryan Bryce on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InventoryDetailVC.h"

@implementation InventoryDetailVC

@synthesize entryField, autocompleteTableView, serials, autocompleteSerials, scrollView, addContainerButton, addContainerImageView, scrollViewBack, keypadBack, axKey, lastContainer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Hard coded in for testing. Dave you'll want to make an array or somethign that is globally accessible like this.
    self.serials = [[NSMutableArray alloc] initWithObjects:@"AX123",@"AZ132",@"AX223",@"AX222",@"AZ132",@"AX223",@"AX722", 
                    @"AZ172",@"AX523",@"AX202", @"AZ632",@"AX823",@"AX220", @"AZ562",@"AX903",@"AX872", @"AZ022",@"AX209",@"AX666",nil];
    self.autocompleteSerials = [[NSMutableArray alloc] init];
  
    autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 320, 120) style:UITableViewStylePlain];
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    
    // Setup scroll view
    [scrollView setContentSize:CGSizeMake(0, 283)];
    
    [scrollView addSubview:autocompleteTableView];
    //[self.view sendSubviewToBack:scrollViewBack];
    //[self.view bringSubviewToFront:scrollView];
    entryField.hidden = YES;
    
    //We currently do not have a custom keypad so I've disabled this and am using the big red key for pushing "enter"
    [entryField setInputView:nil];
    
    //[keypadBack addSubview:axKey];
    //[keypadBack bringSubviewToFront:axKey];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (void)SearchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompleteSerials removeAllObjects];
    for(NSString *curSerial in serials) {
        NSRange substringRange = [curSerial rangeOfString:substring];
        if (substringRange.location == 0) {
            [autocompleteSerials addObject:curSerial];  
        }
    }
    [autocompleteTableView reloadData];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    CGRect autoRect = CGRectMake(entryField.frame.origin.x, entryField.frame.origin.y+39, 240, 270);
    [autocompleteTableView setFrame:autoRect];
    [autocompleteTableView sizeToFit];
     
    [scrollView bringSubviewToFront:autocompleteTableView];
    autocompleteTableView.hidden = NO;
        
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self SearchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return autocompleteSerials.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    
    cell.textLabel.text = [autocompleteSerials objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate methods

//Autocomplete Item Selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    entryField.text = selectedCell.textLabel.text;
    autocompleteTableView.hidden = YES;
    [entryField resignFirstResponder];
}

#pragma mark Enter Button Handler Method

- (IBAction) EnterPressed{
    
    [entryField resignFirstResponder];
    entryField.hidden = YES;
    autocompleteTableView.hidden = YES;
 
    UILabel *snLabel = [[UILabel alloc ] initWithFrame:entryField.frame];//CGRectMake(entryField.frame.origin., 80.0, 150.0, 43.0) ];
    snLabel.textAlignment =  UITextAlignmentLeft;
    snLabel.textColor = [UIColor blackColor];
    [snLabel setBackgroundColor:[UIColor clearColor]];
    snLabel.font = [UIFont fontWithName:@"Helvetica" size:(32.0)];
    snLabel.textColor = [UIColor whiteColor];
    snLabel.text = entryField.text;//[NSString stringWithFormat: @"%s", entryText];
    snLabel.textAlignment = UITextAlignmentCenter;
    snLabel.hidden = NO;
    [scrollView addSubview:snLabel];
    
    entryField.text = nil;
    
    if ([serials containsObject:snLabel.text]) {
        lastContainer.image = [UIImage imageNamed:@"greenContainer.png"];
    }
    else{
        lastContainer.image = [UIImage imageNamed:@"redContainer.png"];
    }
}
#pragma mark AddContainer Handler Method
- (IBAction) AddContainer
{
    //Order of adding matters here because the new container and entry field use the old container's frame before it gets changed.
    entryField.hidden = false;
    entryField.frame = CGRectMake(addContainerButton.frame.origin.x, addContainerButton.frame.origin.y, 
                                  entryField.frame.size.width, entryField.frame.size.height);
    
    UIImage *newContainerImage = [UIImage imageNamed:@"whiteContainer.png"];

    UIImageView *newContainer = [[UIImageView alloc] initWithImage:newContainerImage];
    newContainer.frame = CGRectMake(addContainerImageView.frame.origin.x, addContainerImageView.frame.origin.y,
                                    addContainerImageView.frame.size.width, addContainerImageView.frame.size.height);
    lastContainer = newContainer;
    [scrollView addSubview:newContainer];
    
    //Note: Replace values with #defines values
    addContainerButton.frame = CGRectMake(addContainerButton.frame.origin.x, addContainerButton.frame.origin.y+218, 
                                         addContainerButton.frame.size.width, addContainerButton.frame.size.height);
    
    addContainerImageView.frame = CGRectMake(addContainerImageView.frame.origin.x, addContainerImageView.frame.origin.y+218, 
                                         addContainerImageView.frame.size.width, addContainerImageView.frame.size.height);
    
    [scrollView setContentSize:CGSizeMake(0, scrollView.contentSize.height+218)];
    
    CGRect visibleRect = CGRectMake(0, addContainerImageView.frame.origin.y,
                                    scrollView.frame.size.width, scrollView.frame.size.height);
    //[scrollView scrollRectToVisible:visibleRect animated:true];
    
    if (addContainerImageView.frame.origin.y > 218*2) {
        CGPoint visiblePoint = CGPointMake(0, newContainer.frame.origin.y-218);
        [scrollView setContentOffset:visiblePoint animated:YES];
    }
       
    
    [scrollView bringSubviewToFront:entryField];
    
}


@end
