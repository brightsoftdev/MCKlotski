//
//  GGSoundManager.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-21.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"
#import "GGSingleton.h"

@interface GGSoundManager : NSObject{
    float _backMusicVolume;
    float _effectVolume;
    
    NSArray *_loadEffectArr;
    NSString *_loadBackMusicArr;
    
    SimpleAudioEngine *_simpleAudioEngine;
}

@property (nonatomic, assign) float backMusicVolume;
@property (nonatomic, assign) float effectVolume;
@property (nonatomic, retain) NSArray *loadEffectArr;
@property (nonatomic, retain) NSString *loadBackMusicArr;

DECLARE_SINGLETON(GGSoundManager);

- (void) playBackMusic:(NSString *)p loop:(BOOL)b;

- (void) stopBackMusic;

- (void) pauseBackMusic;

- (void) resumeBackMusic;

- (void) playEffect:(NSString *)p;

@end
