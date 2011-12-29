//
//  XMLParser.h
//  MMi
//
//  Created by Dave Hilton on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Container;

@interface XMLParser : NSObject <NSXMLParserDelegate> {
	
	NSMutableString *currentElementValue;
	NSMutableArray *containers;
	
	Container *tempContainer; 
	NSString *location;
	NSInteger counter;
}

@property (nonatomic, strong) NSMutableArray *containers;
@property (nonatomic, strong) NSString *location;

- (id)initWithBranchID:(NSString *)branchID resultArray:(NSMutableArray *)array;

@end