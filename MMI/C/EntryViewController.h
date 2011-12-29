//
//  SecondViewController.h
//  C
//
//  Created by Bryan Bryce on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Section.h"
#import "Container.h"
#import "MainViewController.h"

@interface EntryViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate> {

    IBOutlet UITableView *mainTableView;
    IBOutlet UITextField *sectionNameField;
    IBOutlet UINavigationBar *leftNavBar;
    IBOutlet UINavigationBar *rightNavBar;
    IBOutlet UITextField *entryField;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView *addContainerImageView;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIButton *addContainerButton;
    
    IBOutlet UIImageView *scrollViewBack;
    IBOutlet UIImageView *keypadBack;
    IBOutlet UIButton *axKey;
    
    UITableView *autocompleteTableView;
    NSMutableArray *serials;
    NSMutableArray *autocompleteSerials;
    
    UIImageView *lastContainer;
    
    //Array of Sections
    NSMutableArray *sections;
    //Array containtng UIScrollViews for each page.
    NSMutableArray *pages;
    
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
    
}

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *sections;
@property (strong, nonatomic) IBOutlet UITextField *sectionNameField;
@property (strong, nonatomic) IBOutlet UINavigationBar *leftNavBar;
@property (strong, nonatomic) IBOutlet UINavigationBar *rightNavBar;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UITextField *entryField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *addContainerButton;
@property (strong, nonatomic) IBOutlet UIImageView *addContainerImageView;

@property (strong, nonatomic) IBOutlet UIImageView *scrollViewBack;
@property (strong, nonatomic) IBOutlet UIImageView *keypadBack;
@property (strong, nonatomic) IBOutlet UIButton *axKey;

@property (strong, nonatomic) UITableView *autocompleteTableView;
@property (strong, nonatomic) NSMutableArray *serials;
@property (strong, nonatomic) NSMutableArray *autocompleteSerials;
@property (strong, nonatomic) UIImageView *lastContainer;


- (void) AddSectionWithName: (NSString *)sectionName;
- (IBAction)changePage:(id)sender;

- (void)SearchAutocompleteEntriesWithSubstring:(NSString *)substring;
- (IBAction) EnterPressed;
- (IBAction) AddContainer;


@end
