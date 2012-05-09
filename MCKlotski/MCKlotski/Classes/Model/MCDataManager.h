//
//  MCDataManager.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGFoundation.h"

@class MCGate;
@class MCGameState;

typedef enum DM_DATA_E{
    DATA_STATE_INVALID = 0,
    kDataManageGameCompleted,
    kDataManageStateChange,
    DATA_STATE_COUNT,
}DataManageChange;


@protocol DataManagerObserver

@required
- (void)updateDataWithState:(DataManageChange)dmData; // 通过数据的改变
@end

@interface MCDataManager : NSObject{
  @private
    NSArray *_gates;
    NSArray *_blockViews; // 存放所有的blockView
    
    NSMutableArray *_theObservers;
    MCGameState *_gameState;
    int _updatingGateID;
}

/**
 * 存放所有的关
 */
@property (nonatomic, retain) NSArray *gates;
@property (nonatomic, retain) NSArray *blockViews;
@property (nonatomic, retain) NSMutableArray *theObservers;
@property (nonatomic, retain) MCGameState *gameState;
@property (nonatomic, assign) int updatingGateID;

DECLARE_SINGLETON(MCDataManager);

// observer
- (void)addObserverWithTarget:(id<DataManagerObserver>)observer forState:(DataManageChange)dmData;
- (void)removeObserverWithTarget:(id<DataManagerObserver>)observer forState:(DataManageChange)dmData;

/**
 * 载入本地数据
 */
- (void)loadLocalData;

/**
 * 保持数据到本地
 */
- (void)saveDataToLocal;

/**
 *通过ID获取gate
 */
- (MCGate *)gateWithID:(int)gateID;

/**
 * 是否完成了所有关
 */
- (BOOL)isCompleteAllGatesWithGate:(MCGate *)gate;

/**
 * 获取下一关的gateID
 */
- (int)nextGateIDWithGate:(MCGate *)gate;

/**
 * 更新Gate
 */
- (MCGate *)updateGateWithGate:(MCGate *)newGate;
@end
