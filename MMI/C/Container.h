//
//  Container.h
//  C
//
//  Created by Bryan Bryce on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Container : NSObject{
    NSString *serial;
	NSString *iso;
	NSString *ecode;
	NSString *branchID; //location code of the branch where this container is located
	NSString *status; //i.e. ExpectedFound, ExpectedNotFound, UnexpectedFound
	NSString *notes; //i.e. "Serial number is too faded to read, but I think this is it... etc"
    CGFloat yPos;
}
@property (strong, nonatomic) NSString *serial;
@property (strong, nonatomic) NSString *iso;
@property (strong, nonatomic) NSString *ecode;
@property (strong, nonatomic) NSString *branchID;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *notes;
@property (nonatomic) CGFloat yPos;

- (id)initWithDictionary:(NSDictionary *)aDictionary;

@end
