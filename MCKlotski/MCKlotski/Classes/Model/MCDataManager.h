//
//  MCDataManager.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGFoundation.h"

typedef enum DM_DATA_E{
    DATA_STATE_INVALID = 0,
    DATA_STATE_GATE_COMPETED,
    DATA_STATE_CHANGED,
    DATA_STATE_COUNT,
}DM_DATA;


@protocol DataManagerObserver

@required
- (void)updateDataWithState:(DM_DATA)dmData; // 通过数据的改变
@end

@interface MCDataManager : NSObject{
    NSArray *_gates;
    
    NSMutableArray *_theObservers;
}

/**
 * 存放所有的关
 */
@property (nonatomic, retain) NSArray *gates;
@property (nonatomic, retain) NSMutableArray *theObservers;

DECLARE_SINGLETON(MCDataManager);

// observer
- (void) addObserverWithTarget:(id<DataManagerObserver>)observer forState:(DM_DATA)dmData;
- (void) removeObserverWithTarget:(id<DataManagerObserver>)observer forState:(DM_DATA)dmData;

/**
 * 载入本地数据
 */
- (void)loadLocalData;

/**
 * 保持数据到本地
 */
- (void)saveDataToLocal;


@end
