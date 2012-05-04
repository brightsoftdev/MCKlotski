//
//  MCUtil.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCAppDelegate;

@interface MCUtil : NSObject

+ (MCAppDelegate *)appDelegate;

+ (UIWindow *)window;

/**
 * 清除View的所有子View
 */
+ (void) clearAllSubViewsWith:(UIView *)view;

/**
 * 保存本地数据
 */
+ (void) saveLocaData:(NSString *)fileName data:(NSString *)str;


@end
