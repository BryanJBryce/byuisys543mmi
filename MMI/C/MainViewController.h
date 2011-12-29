//
//  FirstViewController.h
//  C
//
//  Created by Bryan Bryce on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITextFieldDelegate>{

    IBOutlet UITextField *yardNameTextField;
    IBOutlet UIImageView *mobileMiniContainer;
	IBOutlet UIButton *loadDataButton;
    
    NSString *yardName;
}
@property (strong, nonatomic) IBOutlet UITextField *yardNameTextField;
@property (strong, nonatomic) IBOutlet UIImageView *mobileMiniContainer;
@property (strong, nonatomic) IBOutlet UIButton *loadDataButton;

@property (strong, nonatomic) NSString *yardName;

- (IBAction)loadDataFromXML;

@end
