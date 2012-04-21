//
//  BWSoundManager.m
//  BWDemo
//
//  Created by shell on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BWSoundManager.h"
#import "SimpleAudioEngine.h"

static BWSoundManager * s_instance = nil;

@implementation BWSoundManager
@synthesize backMusicVolume = _backMusicVolume;
@synthesize effectVolume = _effectVolume;
@synthesize loadEffectArr = _loadEffectArr;
@synthesize loadBackMusicArr = _loadBackMusicArr;

+ (BWSoundManager *)sharedInstance{
    if ( !s_instance ) {
        s_instance = [[BWSoundManager alloc] init];
    }
    return s_instance;
}

- (void)dealloc{
    [_loadEffectArr release];
    [_loadBackMusicArr release];
    [SimpleAudioEngine end];
    _simpleAudioEngine = nil;
    s_instance = nil;
    
    [super dealloc];
}

- (id)init{
    if ((self=[super init])) {
        _simpleAudioEngine = [SimpleAudioEngine sharedEngine];
        _backMusicVolume = 1.0;
        _effectVolume = 1.0;
    }
    return self;
}

- (void)setBackMusicVolume:(float)f{
    _backMusicVolume = f;
    
    _simpleAudioEngine.backgroundMusicVolume = _backMusicVolume;
}

- (void)setEffectVolume:(float)f{
    _effectVolume = f;
    
    _simpleAudioEngine.effectsVolume = _effectVolume;
}

- (void)setLoadEffectArr:(NSArray *)s{
    if ( s ) {
        [_loadEffectArr release];
    }
    _loadEffectArr = [s retain];
    
    for ( NSString * str in _loadEffectArr ) {
        [_simpleAudioEngine preloadEffect:str];
    }
}

- (void)setLoadBackMusicArr:(NSString *)l{
    if (l) {
        [_loadBackMusicArr release];
    }
    _loadBackMusicArr = [l retain];
    
    [_simpleAudioEngine preloadBackgroundMusic:l];
}

- (void) playBackMusic:(NSString *)p loop:(BOOL)b{
    if (b) {
        [_simpleAudioEngine playBackgroundMusic:p];
        return;
    }
    [_simpleAudioEngine playBackgroundMusic:p loop:b];
}

- (void) stopBackMusic{
    [_simpleAudioEngine stopBackgroundMusic];
}

- (void) pauseBackMusic{
    [_simpleAudioEngine pauseBackgroundMusic];
}

- (void) resumeBackMusic{
    [_simpleAudioEngine resumeBackgroundMusic];
}

- (void) playEffect:(NSString *)p{    
    [_simpleAudioEngine playEffect:p];
}

@end
