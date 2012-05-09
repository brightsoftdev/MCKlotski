//
//  MCDataManager.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCDataManager.h"
#import "GGFoundation.h"
#import "MCConfig.h"
#import "MCGate.h"
#import "MCGameState.h"

@interface MCDataManager (Privates)
// observer
- (void)notifyObserverForState:(DataManageChange)dmData;

@end

@implementation MCDataManager

@synthesize gates = _gates;
@synthesize blockViews = _blockViews;
@synthesize theObservers = _theObservers;
@synthesize gameState = _gameState;
@synthesize updatingGateID = _updatingGateID;

SYNTHESIZE_SINGLETON(MCDataManager);

- (id)initWithDictionary:(NSDictionary *)dict
{
    if ((self = [self initWithDictionary:dict])) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    }
    return self;
}

- (id)init
{
    if ((self = [super init])) {
        NSMutableArray *observers = [NSMutableArray arrayWithCapacity:DATA_STATE_COUNT];
        for (int i = 0; i < DATA_STATE_COUNT; i++) {
            [observers addObject:[NSMutableSet set]];
        }
        self.theObservers = observers;
        self.gameState = [[[MCGameState alloc] init] autorelease];
    }
    return self;
}

- (void)dealloc
{
    MCRelease(_gates);
    MCRelease(_blockViews);
    MCRelease(_theObservers);
    MCRelease(_gameState);
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - set method
- (void)setGates:(NSArray *)gates
{
    if (self.gates != gates) {
        [_gates release];
        _gates = gates;
        [_gates retain];
        
        [self notifyObserverForState:kDataManageGameCompleted];
    }
}

- (void)setGameState:(MCGameState *)gameState
{
    [_gameState release];
    _gameState = [gameState retain];
    [self notifyObserverForState:kDataManageStateChange];
}

#pragma mark - oberser
- (void)notifyObserverForState:(DataManageChange)dmData
{
    NSMutableSet *set = [self.theObservers objectAtIndex:dmData];
    for (id observer in set) {
        [observer updateDataWithState:dmData];
    }
}

- (void)addObserverWithTarget:(id<DataManagerObserver>)observer forState:(DataManageChange)dmData
{
    NSMutableSet *set = [self.theObservers objectAtIndex:dmData];
    [set addObject:observer];
}

- (void)removeObserverWithTarget:(id<DataManagerObserver>)observer forState:(DataManageChange)dmData
{
    NSMutableSet *set = [self.theObservers objectAtIndex:dmData];
    [set removeObject:observer];
}

#pragma mark - data opertor
- (void)loadLocalData
{
    NSString *userData = nil;
    BOOL isFirstPlayUser = [GGPath isFileExist:LOCAL_DATA_FILE];
    if (isFirstPlayUser) {
        userData = [GGPath documentPathWithFileName:LOCAL_DATA_FILE];
      //  SBJsonParser *jsonParseUser = [[SBJsonParser alloc] init];
        
    }
}

- (void)saveDataToLocal
{
    
}

#pragma mark - public method
- (MCGate *)gateWithID:(int)gateID
{
    MCGate *tempGate = nil;
    for (MCGate *gate in self.gates) {
        if (gate.gateID == gateID) {
            tempGate = [gate retain];
            break;
        }
    }
    return [tempGate autorelease];
}

- (BOOL)isCompleteAllGatesWithGate:(MCGate *)gate
{
    if (gate.passMoveCount == 0) {
        return NO;
    }
    //TODO:: isCompleteAllGatesWithGate
    return YES;
}

- (int)nextGateIDWithGate:(MCGate *)gate
{
    int nextID = 0;
    nextID = gate.gateID + 1;
    nextID = nextID > LimitedGate ? 1 : nextID;
    return nextID;
}

- (MCGate *)updateGateWithGate:(MCGate *)newGate
{
    MCGate *updateGate = [self gateWithID:newGate.gateID];
    if (updateGate) {
        self.updatingGateID = updateGate.gateID;
        int index = [self.gates indexOfObject:updateGate];
        [updateGate refreshWithModel:newGate];
        NSMutableArray *tempGates = [NSMutableArray arrayWithArray:self.gates];
        [tempGates replaceObjectAtIndex:index withObject:updateGate];
        self.gates = [NSArray arrayWithArray:tempGates];
    }
    return updateGate;
}

@end
