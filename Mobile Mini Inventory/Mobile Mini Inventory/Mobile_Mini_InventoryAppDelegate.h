//
//  Mobile_Mini_InventoryAppDelegate.h
//  Mobile Mini Inventory
//
//  Created by Dave Hilton on 9/18/11.
//  Copyright 2011 Dave Hilton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mobile_Mini_InventoryAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
