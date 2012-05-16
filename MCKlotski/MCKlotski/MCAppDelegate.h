//
//  MCAppDelegate.h
//  MCKlotski
//
//  Created by gtts on 12-4-21.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCRootViewController;

@interface MCAppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController *navigationController;
@property (retain, nonatomic) MCRootViewController *rootViewCotroller;

@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
