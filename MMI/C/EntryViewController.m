//
//  SecondViewController.m
//  C
//
//  Created by Bryan Bryce on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EntryViewController.h"
#import "Globals.h"
#import "BranchData.h"

#define CONTAINERSPACE 264
#define ADDCONTAINERDEFAULTX
#define ADDCONTAINERDEFAULTY

@implementation EntryViewController

@synthesize pageControl, leftNavBar, rightNavBar, mainTableView, sections, entryField, autocompleteTableView, serials, autocompleteSerials, scrollView, addContainerButton, addContainerImageView, scrollViewBack, keypadBack, axKey, lastContainer, sectionNameField;

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
    
    //[scrollView addSubview:autocompleteTableView];
    //[self.view sendSubviewToBack:scrollViewBack];
    //[self.view bringSubviewToFront:scrollView];
    
    //entryField.hidden = YES;
    
    //We currently do not have a custom keypad so I've disabled this and am using the big red key for pushing "enter"
    [entryField setInputView:nil];
    
    sections = [[NSMutableArray alloc] init];
    pages = [[NSMutableArray alloc] init];
    //[keypadBack addSubview:axKey];
    //[keypadBack bringSubviewToFront:axKey];
    //rightNavBar.topItem.title = MainViewController.yardName;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}



#pragma mark -Main Table View Methods

#pragma mark Main Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)mainTableView {
	// Number of sections.
    NSLog(@"number of sections in data source method: %d", [sections count]);
	return [sections count];
}


- (NSInteger)tableView:(UITableView *)mainTableView numberOfRowsInSection:(NSInteger)section {
	// Number of containers for the specified section.
    return [[[sections objectAtIndex:section] containers] count];
}


- (NSString *)tableView:(UITableView *)mainTableView titleForHeaderInSection:(NSInteger)section {
	// The header for the section is the section name -- get this from the section at the section index.
	Section *curSection = [sections objectAtIndex:section];
	return [curSection name];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
	}
	
	// Get the section at the index path.
	Section *curSection = [sections objectAtIndex:indexPath.section];
	Container *curContainer = [curSection.containers objectAtIndex:indexPath.row];
	
	// Set the cell's text to the name of the time zone at the row
	cell.textLabel.text = curContainer.serial;
	return cell;
}

#pragma mark Main Table view delegate method

//When serial number is selected, switch to the section's scroll view and containerImageView where it is found.

- (NSIndexPath *)tableView:(UITableView *)mainTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    Section *curSection = [sections objectAtIndex:indexPath.section];
    Container *curContainer = [curSection.containers objectAtIndex:indexPath.row];

    //Scroll to container
    //CGPoint visiblePoint = CGPointMake(, curContainer.yPos);
    //[scrollView setContentOffset:visiblePoint animated:YES];

    
    return nil;
}

#pragma mark -scrollView Methods

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (sender == scrollView) 
    {
        // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
        // which a scroll event generated from the user hitting the page control triggers updates from
        // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
        NSLog(@"scrollViewDidScroll");
        if (pageControlUsed)
        {
            // do nothing - the scroll was initiated from the page control, not the user dragging
            return;
        }
	
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        NSLog(@"What page is it? %d",page);
        pageControl.currentPage = page;
    }
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
    //Change rightNavbar title
    rightNavBar.topItem.title = [[sections objectAtIndex:page] name];
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}



#pragma mark -UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField.tag == 0) {
        [self AddSectionWithName:textField.text];
    }
    
    if (textField.tag == 1) {
        //[entryField resignFirstResponder];
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
        
        addContainerButton.enabled = true;
        addContainerButton.hidden = false;
        addContainerImageView.hidden = false;
    }

    textField.text = nil;
    
    return YES;
}

#pragma mark -AddSection handler

- (void) AddSectionWithName: (NSString *)sectionName
{
    //Update the number of pages in pageControl.
    pageControl.numberOfPages++;

    int page = [pageControl numberOfPages]-1;
    
    //add new Scroll View to pages Array
    CGRect newPageFrame = CGRectMake(scrollView.frame.size.width*page,0, scrollView.frame.size.width, scrollView.frame.size.height);
    UIScrollView* newScrollPage = [[UIScrollView alloc] initWithFrame:newPageFrame];
    [newScrollPage setBackgroundColor:[UIColor whiteColor]];
    [newScrollPage setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [pages addObject:newScrollPage];
    
    //add new Section to sections
    Section* newSection = [[Section alloc] initWithName:sectionName];
    [sections addObject:newSection];
    
    NSLog(@"number of sections in addSection method: %d", [sections count]);
    NSLog(@"number of pages: %d", [pageControl numberOfPages]);
    NSLog(@"number of pages in pages: %d", [pages count]);
    
    CGRect addContainerFrame = CGRectMake((scrollView.frame.size.width/2)-(addContainerImageView.frame.size.width/2), 
                                          20, addContainerImageView.frame.size.width, addContainerImageView.frame.size.height);
    addContainerImageView.frame = addContainerFrame;
    addContainerImageView.hidden = NO;
    [[pages lastObject] addSubview:addContainerImageView];
    
    //Add page(scroll view) to scrollView and change to appropriate page.
    [scrollView addSubview:(UIScrollView*) [pages lastObject]];
    
    //Update scrollView's content size
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width*[pageControl numberOfPages], 0)];
    
    //IS THIS WORKING???NO!
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
    
    //[newScrollView addSubview:addContainerImageView];
    
    //Add new section to the mainTableView
    [mainTableView reloadData];
    //rightNavBar.topItem.title = sectionName;    
}

#pragma mark AddContainer Handler Method
- (IBAction) AddContainer
{
    //Order of adding matters here because the new container and entry field use the old container's frame before it gets changed.
    entryField.hidden = false;
    entryField.frame = CGRectMake(addContainerButton.frame.origin.x, addContainerButton.frame.origin.y, 
                                  entryField.frame.size.width, entryField.frame.size.height);
    
    UIImage *newContainerImage = [UIImage imageNamed:@"containerWhite.png"];
    
    UIImageView *newContainer = [[UIImageView alloc] initWithImage:newContainerImage];
    newContainer.frame = CGRectMake(addContainerImageView.frame.origin.x, addContainerImageView.frame.origin.y,
                                    addContainerImageView.frame.size.width, addContainerImageView.frame.size.height);
    
    [[pages objectAtIndex:[pageControl currentPage]] addSubview:newContainer];
    
    addContainerButton.frame = CGRectMake(addContainerButton.frame.origin.x, addContainerButton.frame.origin.y+CONTAINERSPACE, 
                                          addContainerButton.frame.size.width, addContainerButton.frame.size.height);
    
    addContainerImageView.frame = CGRectMake(addContainerImageView.frame.origin.x, addContainerImageView.frame.origin.y+CONTAINERSPACE, 
                                             addContainerImageView.frame.size.width, addContainerImageView.frame.size.height);
    
    [[pages objectAtIndex:[pageControl currentPage]] setContentSize:CGSizeMake(0, scrollView.contentSize.height+CONTAINERSPACE)];
    
    CGRect visibleRect = CGRectMake(0, addContainerImageView.frame.origin.y,
                                    scrollView.frame.size.width, scrollView.frame.size.height);
    [scrollView scrollRectToVisible:visibleRect animated:true];
    
    //Autoscroll to position
    if (addContainerImageView.frame.origin.y > CONTAINERSPACE*2) {
        CGPoint visiblePoint = CGPointMake(pageControl.currentPage * scrollView.frame.size.width, newContainer.frame.origin.y-CONTAINERSPACE);
        [[pages objectAtIndex:[pageControl currentPage]] setContentOffset:visiblePoint animated:YES];
    }
    
    addContainerButton.enabled = false;
    addContainerButton.hidden = true;
    addContainerImageView.hidden = true;
    [[pages objectAtIndex:[pageControl currentPage]] bringSubviewToFront:entryField];
}

@end
