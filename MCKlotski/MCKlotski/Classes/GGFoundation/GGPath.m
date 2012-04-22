//
//  GGPath.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-21.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "GGPath.h"

@implementation GGPath

+ (NSString *) documentPath
{
    NSArray *arrDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [arrDir objectAtIndex:0];
}

+ (NSString *) bundleFile:(NSString *) fileName
{
    NSString *path = [[NSBundle mainBundle] resourcePath];
    return [path stringByAppendingPathComponent:fileName];
}

+ (NSData *) dataOfFile:(NSString *) fileName
{
    return [NSData dataWithContentsOfFile:[GGPath bundleFile:fileName]];
}

+ (BOOL) isFileExist:(NSString *)fileName
{
    NSString *path = [GGPath documentPath];
    NSString *finalPath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:finalPath];
}

@end
