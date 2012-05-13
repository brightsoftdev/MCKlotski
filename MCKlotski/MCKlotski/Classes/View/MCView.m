//
//  MCView.m
//  MCKlotski
//
//  Created by gtts on 5/6/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCView.h"

@implementation MCView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"%@ : %@", NSStringFromSelector(_cmd), @"MCView");
        //self.userInteractionEnabled = NO;
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@ : %@", NSStringFromSelector(_cmd), @"MCView");
    [super dealloc];
}

@end
