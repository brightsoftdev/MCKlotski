//
//  GGPath.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-21.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGPath : NSObject

+ (NSString *) documentPath;

+ (NSString *) bundleFile:(NSString *) fileName;

+ (NSData *) dataOfFile:(NSString *) fileName;

@end
