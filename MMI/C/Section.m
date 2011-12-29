//
//  Section.m
//  C
//
//  Created by Bryan Bryce on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Section.h"

@interface Section (Private)



@end

@implementation Section

@synthesize name, containers;

#pragma mark Private methods for setting up the Sections.

- (id)initWithName:(NSString *)sectionName{
	
	if (self = [super init]) {
		name = [sectionName copy];
		containers = [[NSMutableArray alloc] init];
	}
	return self;
}

@end
