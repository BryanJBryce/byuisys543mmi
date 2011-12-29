//
//  YardData.m
//  MMi
//
//  Created by Dave Hilton on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BranchData.h"
#import "Container.h"
#import "Globals.h"
#import "XMLParser.h"

@interface BranchData(mymethods)

- (void)loadDataForBranch;

@end

@implementation BranchData
@synthesize expectedContainers, foundContainers, autocompleteList, branchID;

static NSString *currentBranchCode;
static BranchData *currentBranchData = nil;

- (id)initWithBranchID:(NSString *)branch
{
	if([self init])
	{
		expectedContainers = [[NSMutableArray alloc] init];
		autocompleteList = [[NSMutableArray alloc] init];
		branchID = branch;
	}
	return self;
}

+ (void)startNewStockTakeForBranch:(NSString *)branchId
{
	BranchData *newBranchData = [[BranchData alloc] initWithBranchID:branchId];
	newBranchData.branchID = branchId;
	//temp...
	currentBranchData = newBranchData;
	currentBranchCode = branchId;
	
	[currentBranchData loadDataForBranch];
}

+ (BranchData *)currentBranchData
{
	if(currentBranchData == nil)
	{
		currentBranchData = [[self alloc] init];
		currentBranchData.expectedContainers = [[NSMutableArray alloc] init];
	}
    return currentBranchData;
}

- (void)markContainerAsFound:(Container *)container
{
	//Decide status of container based on whether or not the container existed in the expected List... 
	//  assign the container's status, for example: kStatusExpectedFound or kStatusUnexpectedFound
	
	//check if foundContainers has been instantiated - if not, instantiate it...
	//add it to the "foundContainers" array
	
	//remove from autocompleteList if it was there
}

#pragma mark - Private Methods

- (void)loadDataForBranch
{
	//load data from XML file into model memory...
	
	NSURL *url = [[NSURL alloc] initWithString:@"http://it.et.byu.edu:40120/mmi.xml"];
	NSData *myData = [NSData dataWithContentsOfURL:url];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:myData];
	//Initialize the delegate.
	XMLParser *parser = [[XMLParser alloc] initWithBranchID:branchID resultArray:expectedContainers];
	
	//Set delegate
	[xmlParser setDelegate:parser];
	
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
	if(success)
		NSLog(@"No Errors");
	else
		NSLog(@"Error Error Error!!!");
	
	// Sort this mother
	NSArray *sortedArray = [expectedContainers sortedArrayUsingComparator:^(id a, id b) {
		NSString *first = [(Container*)a serial];
		NSString *second = [(Container*)b serial];
		return [first compare:second];
	}];
	
	expectedContainers = (NSMutableArray *)sortedArray;
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	//make a file name to write the data to using the documents directory:
	NSString *fileName = [NSString stringWithFormat:@"%@/textfile.csv", 
						  documentsDirectory];
	//create content - four lines of text
	//NSString *content = @"One\nTwo\nThree\nFour\nFive";
	
	
	NSMutableString *content = [NSMutableString stringWithString:@"\"Location\",\"Serial Number\",\"ISO\",\"Ecode\"\n"];
	
	for (int i = 0; i < expectedContainers.count; i++) {
		Container *cont = (Container *)[expectedContainers objectAtIndex:i];
		[content appendFormat:@"\"%@\",\"%@\",\"%@\",\"%@\"\n",cont.branchID,cont.serial,cont.iso,cont.ecode];
	}
	
	//save content to the documents directory
	[content writeToFile:fileName 
			  atomically:NO 
				encoding:NSStringEncodingConversionAllowLossy 
				   error:nil];
	NSLog(@"written");

	
}

@end