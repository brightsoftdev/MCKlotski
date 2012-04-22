//
//  GGUtil.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-21.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "GGUtil.h"

@implementation GGUtil

+ (CGRect) screenFrame
{
    CGRect rect = [UIScreen mainScreen].applicationFrame;
    return CGRectMake(0, 0, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
}

@end
