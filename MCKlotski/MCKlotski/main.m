//
//  main.m
//  MCKlotski
//
//  Created by gtts on 12-4-21.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCAppDelegate.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([MCAppDelegate class]));  
    [pool release];  
    return retVal;  
}
