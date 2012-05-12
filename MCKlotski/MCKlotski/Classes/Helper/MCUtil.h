//
//  MCUtil.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCGate;
@class MCAppDelegate;

@interface MCUtil : NSObject

+ (MCAppDelegate *)appDelegate;

+ (UIWindow *)window;

/**
 * 清除View的所有子View
 */
+ (void)clearAllSubViewsWith:(UIView *)view;

/**
 * 保存本地数据
 */
+ (BOOL)saveLocalData:(NSString *)fileName data:(NSString *)str;
+ (BOOL)saveLocalDataWithFileName:(NSString *)fileName data:(NSData *)data;


/**
 * 判断是否完成所有关
 */
+ (BOOL)isCompleteAllGate:(MCGate *)gate;

+ (int)nextGateIDWith:(MCGate *)gate;

/*！ 载入本地数据 */
+ (void)lauchLocalData;

/*! 保存本地数据 */
+ (void)savaLocalData;
@end
