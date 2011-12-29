//
//  Container.m
//  C
//
//  Created by Bryan Bryce on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Container.h"
#import "Globals.h"

@implementation Container

@synthesize serial, iso, ecode, branchID;
@synthesize status, notes;
@synthesize yPos;

- (id)initWithDictionary:(NSDictionary *)aDictionary {
	if ([self init]) {
		self.serial	= [aDictionary valueForKey:@"serial"];
		self.iso = [aDictionary valueForKey:@"iso"];
		self.ecode = [aDictionary valueForKey:@"ecode"];
		self.branchID = [aDictionary valueForKey:@"branchID"];
		self.status = [aDictionary valueForKey:@"status"];
		self.notes = [aDictionary valueForKey:@"notes"];
	}
	return self;
}


@end
