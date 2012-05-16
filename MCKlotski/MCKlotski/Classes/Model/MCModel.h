//
//  MCModel.h
//  MCKlotski
//
//  Created by gtts on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCConfig.h"

@interface MCModel : NSObject <NSCoding>

- (id)initWithDictionary:(NSDictionary *)dict;

- (void)initAttributes;

- (void)refreshWithModel:(MCModel *)model;

@end
