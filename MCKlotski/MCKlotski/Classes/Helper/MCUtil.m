//
//  MCUtil.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCUtil.h"
#import "MCAppDelegate.h"

@implementation MCUtil

+ (MCAppDelegate *)appDelegate
{
    return (MCAppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (UIWindow *)window
{
    return [MCUtil appDelegate].window;
}

+ (void) clearAllSubViewsWith:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}

@end
