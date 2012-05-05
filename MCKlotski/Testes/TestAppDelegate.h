//
//  MCAppDelegate.h
//  Testes
//
//  Created by lim edwon on 12-4-21.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestRootViewController;

@interface TestAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TestRootViewController *viewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
