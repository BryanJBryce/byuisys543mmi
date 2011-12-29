//
//  Section.h
//  C
//
//  Created by Bryan Bryce on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject{
    NSString* name;
    NSMutableArray* containers;
}

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSMutableArray* containers;


-(id)initWithName:(NSString *)sectionName;

@end
