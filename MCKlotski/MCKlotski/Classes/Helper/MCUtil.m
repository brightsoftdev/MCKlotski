//
//  MCUtil.m
//  MCKlotski
//
//  Created by gtts on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCUtil.h"
#import "MCAppDelegate.h"
#import "MCGate.h"
#import "MCDataManager.h"

@implementation MCUtil

+ (MCAppDelegate *)appDelegate
{
    return (MCAppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (UIWindow *)window
{
    return [MCUtil appDelegate].window;
}

+ (void)clearAllSubViewsWith:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}

+ (BOOL)saveLocalData:(NSString *)fileName data:(NSString *)str
{
    NSArray *arrDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [arrDir objectAtIndex:0];
    NSString *finalPath = [path stringByAppendingPathComponent:fileName];
    NSLog(@"Svae Local File Path : %@", finalPath);
    NSError *error;
    if (![str writeToFile:finalPath atomically:NO encoding:NSUTF8StringEncoding error:&error]) {
        NSLog(@"Save Local Data Error : %@", error);
        return NO;
    }else {
        NSLog(@"Save Local File Successfully!!!");
        return YES;
    }
}

+ (BOOL)saveLocalDataWithFileName:(NSString *)fileName data:(NSData *)data
{
    NSArray *arrDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [arrDir objectAtIndex:0];
    NSString *finalPath = [path stringByAppendingPathComponent:fileName];
    NSError *error;
    if (![data writeToFile:finalPath atomically:YES]) {
        NSLog(@"Save Local Data Error : %@", error);
        return NO;
    }else {
        NSLog(@"Save Local File Successfully!!!");
        return YES;
    }
}

+ (BOOL)isCompleteAllGate:(MCGate *)gate
{
    return [[MCDataManager sharedMCDataManager] isCompleteAllGatesWithGate:gate];
}

+ (int)nextGateIDWith:(MCGate *)gate
{
     return [[MCDataManager sharedMCDataManager] nextGateIDWithGate:gate];
}

+ (void)lauchLocalData
{
    [[MCDataManager sharedMCDataManager] loadLocalData];
}

+ (void)savaLocalData
{
    [[MCDataManager sharedMCDataManager] saveDataToLocal];
}

@end
