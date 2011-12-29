//
//  Container.h
//  C
//
//  Created by Bryan Bryce on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Container : NSObject{
    NSString* serial;
    CGFloat yPos;
}
@property (strong, nonatomic) NSString* serial;
@property (nonatomic) CGFloat yPos;

@end
