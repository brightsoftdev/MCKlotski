//
//  GGSoundManager.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-21.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "GGSoundManager.h"

@implementation GGSoundManager

@synthesize backMusicVolume = _backMusicVolume;
@synthesize effectVolume = _effectVolume;
@synthesize loadEffectArr = _loadEffectArr;
@synthesize loadBackMusicArr = _loadBackMusicArr;

SYNTHESIZE_SINGLETON(GGSoundManager);

- (id)init{
    if ((self=[super init])) {
        _simpleAudioEngine = [SimpleAudioEngine sharedEngine];
        _backMusicVolume = 1.0;
        _effectVolume = 1.0;
    }
    return self;
}

- (void)dealloc
{
    self.loadEffectArr = nil;
    self.loadBackMusicArr = nil;
    [SimpleAudioEngine end];
    _simpleAudioEngine = nil;
    [super dealloc];
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
