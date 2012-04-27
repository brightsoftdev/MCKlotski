//
//  MCConfig.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#ifndef MCKlotski_MCConfig_h
#define MCKlotski_MCConfig_h

#define InvaluableBlockID -1

#define MENU_FONT @"FZKATJW--GB1-0" // 方正卡通简体
//#define MENU_FONT @"-GXSX" // 国祥手写体
//#define MENU_FONT @"GSZL--HSJHDT-0" // 韩绍杰邯郸体.ttf
//#define MENU_FONT @"QXyingbili" // 全新硬笔隶书简.ttf
//#define MENU_FONT @"zhongqi-Wangqinghua" // 钟齐王庆华毛笔简体.TTF
//#define MENU_FONT @"DFPOPMix-W5-WINP-RKSJ-H" // DFPPOPMix-W5

#define MCRelease(__object) if(__object){[__object release];__object=nil;}

#pragma mark - keys
// Setting
#define KeySettingSoundEnable @"sound"
#define KeySettingNeedTutorail @"tutorail"

// RectFrame
#define KeyFrameX @"frameX"
#define KeyFrameY @"frameY"
#define KeyFrameWidth @"frameWidth"
#define KeyFrameHeight @"frameHeight"
#define KeyFrameRect @"frameRect"

// Gate
#define KeyGateID @"gateID"
#define KeyPassMin @"passMin"
#define KeyPassMoveCount @"assMoveCount"
#define KeyLocked @"isLocked"
#define KeyLayout @"layout"

// Step
#define KeyBlockID @"blockID"
#define KeyFrameOld @"frameOld"
#define KeyIsNewActiving @"newActiving"

// GameState
#define KeyCurrentGateId @"currentGateID"
#define KeyMoveCount @"moveCount"
#define KeyFrames @"frames"
#define KeySteps @"steps"
#define KeyIsFirstStep @"isFirstStep"

#endif
