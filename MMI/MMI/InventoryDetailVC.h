//
//  InventoryDetailVC.h
//  MMI
//
//  Created by Bryan Bryce on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InventoryDetailVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {

    IBOutlet UITextField *entryField;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *addContainerButton;
    IBOutlet UIImageView *addContainerImageView;
    IBOutlet UIImageView *scrollViewBack;
    IBOutlet UIImageView *keypadBack;
    IBOutlet UIButton *axKey;
    
    UITableView *autocompleteTableView;
    NSMutableArray *serials;
    NSMutableArray *autocompleteSerials;
    UIImageView *lastContainer;
}

@property (strong, nonatomic) IBOutlet UITextField *entryField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *addContainerButton;
@property (strong, nonatomic) IBOutlet UIImageView *addContainerImageView;
@property (strong, nonatomic) UITableView *autocompleteTableView;
@property (strong, nonatomic) NSMutableArray *serials;
@property (strong, nonatomic) NSMutableArray *autocompleteSerials;
@property (strong, nonatomic) UIImageView *lastContainer;
@property (strong, nonatomic) IBOutlet UIImageView *scrollViewBack;
@property (strong, nonatomic) IBOutlet UIImageView *keypadBack;
@property (strong, nonatomic) IBOutlet UIButton *axKey;



- (void)SearchAutocompleteEntriesWithSubstring:(NSString *)substring;
- (IBAction) EnterPressed;
- (IBAction) AddContainer;

@end
