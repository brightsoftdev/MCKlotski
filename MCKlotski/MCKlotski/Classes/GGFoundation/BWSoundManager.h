//
//  BWSoundManager.h
//  BWDemo
//
//  Created by shell on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class SimpleAudioEngine;

@interface BWSoundManager : CCNode {
    float _backMusicVolume;
    float _effectVolume;
    
    NSArray * _loadEffectArr;
    NSString * _loadBackMusicArr;
    
    SimpleAudioEngine * _simpleAudioEngine;
}
@property(nonatomic,assign)float backMusicVolume;
@property(nonatomic,assign)float effectVolume;
@property(nonatomic,retain)NSArray * loadEffectArr;
@property(nonatomic,retain)NSString * loadBackMusicArr;

+ (BWSoundManager *) sharedInstance;

- (void) playBackMusic:(NSString *)p loop:(BOOL)b;

- (void) stopBackMusic;

- (void) pauseBackMusic;

- (void) resumeBackMusic;

- (void) playEffect:(NSString *)p;

@end
