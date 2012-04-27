//
//  MCModel.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCModel.h"


@implementation MCModel

- (id)init
{
    if ((self = [super init])) {
        [self initAttributes];
    }
    return self;
}

- (id) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    }
    return self;
}

- (void) dealloc
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

- (void) refreshWithModel:(MCModel *)model
{
    
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        if (nil == coder) {
            return self;
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    
}

#pragma mark - Private method
- (void) initAttributes
{}

@end
