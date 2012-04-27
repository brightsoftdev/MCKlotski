//
//  MCSettings.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-25.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCSettings.h"

@implementation MCSettings
@synthesize isSoundEnable = _isSoundEnable;
@synthesize isNeedTutorial = _isNeedTutorial;

#pragma mark - init & dealloc
- (id) initWithDictionary:(NSDictionary *)dict
{
    if ((self = [self initWithDictionary:dict])) {
        NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
        if ([dict objectForKey:KeySettingSoundEnable]) {
            self.isSoundEnable = [[dict objectForKey:KeySettingSoundEnable] boolValue];
        }
        if ([dict objectForKey:KeySettingNeedTutorail]) {
            self.isNeedTutorial = [[dict objectForKey:KeySettingNeedTutorail] boolValue];
        }
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)coder
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super initWithCoder:coder];
    self.isSoundEnable = [coder decodeBoolForKey:KeySettingSoundEnable];
    self.isNeedTutorial = [coder decodeBoolForKey:KeySettingNeedTutorail];
    return self;
}

- (void)initAttributes
{
    self.isSoundEnable = YES;
    self.isNeedTutorial = YES;
}

- (void) encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeBool:self.isSoundEnable forKey:KeySettingSoundEnable];
    [coder encodeBool:self.isNeedTutorial forKey:KeySettingNeedTutorail];
}

- (void) dealloc
{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

#pragma mark - overwrite
- (void)refreshWithModel:(MCModel *)model
{
    [super refreshWithModel:model];
    MCSettings *setting = (MCSettings *)model;
    self.isSoundEnable = setting.isSoundEnable;
    self.isNeedTutorial = setting.isNeedTutorial;
}

@end
