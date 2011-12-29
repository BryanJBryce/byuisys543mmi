//
//  YardData.h
//  MMi
//
//  Created by Dave Hilton on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Container;
@interface BranchData : NSObject {
	NSMutableDictionary *statusDictionary;
	NSMutableArray *expectedContainers;
	NSMutableArray *foundContainers;
	NSMutableArray *autocompleteList;
	NSString *branchID;
}

@property (strong, nonatomic) NSMutableArray *expectedContainers;
@property (strong, nonatomic) NSMutableArray *foundContainers;
@property (strong, nonatomic) NSMutableArray *autocompleteList;
@property (strong, nonatomic) NSString *branchID;

+ (void)startNewStockTakeForBranch:(NSString *)branchId;
+ (BranchData *)currentBranchData;
- (void)markContainerAsFound:(Container *)container;
- (id)initWithBranchID:(NSString *)branch;

@end
