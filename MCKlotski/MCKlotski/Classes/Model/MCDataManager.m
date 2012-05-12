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
#import "MCSettings.h"
#import "CJSONDeserializer.h"
#import "MCUtil.h"

@interface MCDataManager (Privates)
// observer
- (void)notifyObserverForState:(DataManageChange)dmData;

@end

@implementation MCDataManager

@synthesize gates = _gates;
@synthesize blockViews = _blockViews;
@synthesize theObservers = _theObservers;
@synthesize gameState = _gameState;
@synthesize settings = _settings;
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
        self.settings = [[[MCSettings alloc] init] autorelease];
        self.updatingGateID = 0;
    }
    return self;
}

- (void)dealloc
{
    MCRelease(_gates);
    MCRelease(_blockViews);
    MCRelease(_theObservers);
    MCRelease(_gameState);
    MCRelease(_settings);
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
    if (![GGPath isFileExistInBundle:LAYOUT_DATA_FILE]) {
        // 布局文件不存在
        return;
    }
    
    NSString *gateData = nil;
    NSData *userData = nil;
    NSDictionary *userDictionary = nil;
    BOOL isFirstPlayUser = [GGPath isFileExist:LOCAL_DATA_FILE];
    if (isFirstPlayUser) {
        userData = [GGPath documentPathWith:LOCAL_DATA_FILE];
        NSLog(@"fsdafas:%@",userData);
       // NSData *userJsonData = [userData dataUsingEncoding:NSUTF32BigEndianStringEncoding];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:userData];
        self.settings = [unarchiver decodeObjectForKey:@"settings"];
        self.gameState = [unarchiver decodeObjectForKey:@"gameState"];
        NSLog(@"self:%d",self.gameState.currentGateID);
        userDictionary = [unarchiver decodeObjectForKey:@"gates"];
    }
    
    // 解析布局文件
    gateData = [GGPath bundleFile:LAYOUT_DATA_FILE andFileType:@""]; // 由于json文件objc不识别，所以FileType应该为空
    NSData *gateJsonData = [gateData dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    NSDictionary *gateDictionary = [[CJSONDeserializer deserializer] 
                                    deserializeAsDictionary:gateJsonData error:nil];
    NSLog(@"KlotskiLayout.json : %@", gateDictionary);
    
    if ([gateDictionary objectForKey:@"gates"]) {
        NSMutableArray *tempGates = [NSMutableArray arrayWithCapacity:LimitedGate];
        NSArray *dics1 = (NSArray *)[gateDictionary objectForKey:@"gates"];
        
        NSArray *allKeysuserDictionary = [userDictionary allKeys];
        // userDictionary 类似下面格式
        //        {
        //            1 =     {
        //                completedMoveCount = 3;
        //                rmin = 3;
        //            };
        //            2 =     {
        //                completedMoveCount = 8;
        //                rmin = 7;
        //            };
        //        }
        for (int i = 0; i < [dics1 count]; i++) {
            NSMutableDictionary *goGateDict = [NSMutableDictionary dictionaryWithDictionary:
                                               [dics1 objectAtIndex:i]];
            if ([allKeysuserDictionary containsObject:[NSString stringWithFormat:@"%d", i+1]]) {
                [goGateDict setValue:[[userDictionary objectForKey:[NSString stringWithFormat:@"%d", i+1]] 
                                      objectForKey:KeyPassMoveCount] 
                              forKey:KeyPassMoveCount];
            }else {
                [goGateDict setValue:[NSNumber numberWithInt:0] forKey:KeyPassMoveCount];
            }
            NSLog(@"dic2:%@", goGateDict);
            MCGate *gate = [[[MCGate alloc] initWithDictionary:goGateDict] autorelease];
            [tempGates addObject:gate];
        }
        self.gates = tempGates;
    }
}

- (void)saveDataToLocal
{
    NSMutableData *data = [NSMutableData data];
    if (self.gates.count > 0) {
        NSMutableDictionary *userGateDict = [NSMutableDictionary dictionaryWithCapacity:LimitedGate];
        for (MCGate *gate in self.gates) {
            if (gate.passMoveCount != 0) {
                NSDictionary *gateUserData = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [NSNumber numberWithInt:gate.passMin], KeyPassMin, 
                                              [NSNumber numberWithInt:gate.passMoveCount], KeyPassMoveCount,
                                              nil];
                [userGateDict setObject:gateUserData forKey:[NSString stringWithFormat:@"%d", gate.gateID]];
                
            }
        }
        
        NSKeyedArchiver *archiver = [[[NSKeyedArchiver alloc] initForWritingWithMutableData:data] autorelease];
        [archiver encodeObject:self.gameState forKey:@"gameState"];
        [archiver encodeObject:self.settings forKey:@"settings"];
        [archiver encodeObject:userGateDict forKey:@"gates"];
        [archiver finishEncoding];
    }
    
    if (!data) {
        return;
    }
    [MCUtil saveLocalDataWithFileName:LOCAL_DATA_FILE data:data];
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
    int alreadyFinished = 0;
    for (MCGate *gate in self.gates) {
        if (gate.passMoveCount != 0) {
            alreadyFinished ++;
        }
    }
    NSLog(@"gtts:%@", self.gates);
    NSLog(@"already Finished gate:%d", alreadyFinished);
    if (alreadyFinished == LimitedGate) {
        return YES;
    }
    return NO;
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

- (BOOL)isNeedTutorial
{
    if(self.settings.isNeedTutorial && self.gameState.currentGateID < 1){
        return YES;
    }else {
        return NO;
    }
}

@end
