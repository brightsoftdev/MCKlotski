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

@interface MCDataManager (Privates)
// observer
- (void)notifyObserverForState:(DM_DATA)dmData;

@end

@implementation MCDataManager

@synthesize gates = _gates;
@synthesize blockViews = _blockViews;
@synthesize theObservers = _theObservers;

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
    }
    return self;
}

- (void)dealloc
{
    MCRelease(_gates);
    MCRelease(_blockViews);
    MCRelease(_theObservers);
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
        
        [self notifyObserverForState:DATA_STATE_GATE_COMPETED];
    }
}

#pragma mark - oberser
- (void)notifyObserverForState:(DM_DATA)dmData
{
    NSMutableSet *set = [self.theObservers objectAtIndex:dmData];
    for (id observer in set) {
        [observer updateDataWithState:dmData];
    }
}

- (void)addObserverWithTarget:(id<DataManagerObserver>)observer forState:(DM_DATA)dmData
{
    NSMutableSet *set = [self.theObservers objectAtIndex:dmData];
    [set addObject:observer];
}

- (void)removeObserverWithTarget:(id<DataManagerObserver>)observer forState:(DM_DATA)dmData
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

#pragma private method


@end
