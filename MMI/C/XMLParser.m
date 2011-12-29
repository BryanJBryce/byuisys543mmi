//
//  XMLParser.m
//  MMi
//
//  Created by Dave Hilton on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
#import "Container.h"
#import "Globals.h" 
#import "BranchData.h"

@implementation XMLParser

@synthesize containers, location;

- (id)initWithBranchID:(NSString *)branchID resultArray:(NSMutableArray *)array
{
	self = [super init];
	location = branchID;
	containers = array;
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"data"]) {
		//Initialize the array.
	}
	else if([elementName isEqualToString:@"row"]) {
		
		//Initialize the book.
		tempContainer = [[Container alloc] init];
		
		counter = 0;
		
		//aContainer.bookID = [[attributeDict objectForKey:@"id"] integerValue];
		
		
		
		//NSLog(@"Reading id value :%i", aContainer.location);
	}
	else if([elementName isEqualToString:@"value"]) {
		switch (counter) {
			case kXmlIndexLocation:
				tempContainer.branchID = currentElementValue;
				break;
			case kXmlIndexEcode:
				tempContainer.ecode = currentElementValue;
				break;
			case kXmlIndexISO:
				tempContainer.iso = currentElementValue;
				break;
			case kXmlIndexSerial:
				tempContainer.serial = currentElementValue;
				break;				
			default:
				break;
		}
		counter++;
	}
	
	//NSLog(@"Processing Element: %@", elementName);
	//NSLog(@"Processing Value: %@", currentElementValue);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	
	if(!currentElementValue) 
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
	
	//NSLog(@"Processing Value: %@", currentElementValue);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"data"])
		return;
	
	//There is nothing to do if we encounter the Books element here.
	//If we encounter the Book element however, we want to add the book object to the array
	// and release the object.
	if([elementName isEqualToString:@"row"]) {
		//trim whitespace
		tempContainer.branchID = [tempContainer.branchID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		if ((tempContainer.branchID == location) || ([location isEqualToString:ALL_LOCATIONS])) {
			tempContainer.serial = [tempContainer.serial stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			tempContainer.iso = [tempContainer.iso stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			tempContainer.ecode = [tempContainer.ecode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			[containers addObject:tempContainer];
			//NSLog(@"Right Location: %@",aContainer.location);
			NSLog(@"Adding Container:\n  Location: %@,\n  Serial Number: %@,\n  ISO: %@,\n  Ecode: %@",tempContainer.branchID, tempContainer.serial, tempContainer.iso, tempContainer.ecode);
		}
		
		tempContainer = nil;
		counter = 0;
	}
	
	currentElementValue = nil;
}


@end
