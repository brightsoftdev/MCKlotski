//
//  MCAppDelegate.h
//  Testes
//
//  Created by lim edwon on 12-4-21.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCViewController;

@interface MCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MCViewController *viewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
