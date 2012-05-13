//
//  MCConfig.h
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#ifndef MCKlotski_MCConfig_h
#define MCKlotski_MCConfig_h

// 最大关数
#define LimitedGate 3

#define kInvaluableBlockID -1

#define MENU_FONT @"FZKATJW--GB1-0" // 方正卡通简体
//#define MENU_FONT @"-GXSX" // 国祥手写体
//#define MENU_FONT @"GSZL--HSJHDT-0" // 韩绍杰邯郸体.ttf
//#define MENU_FONT @"QXyingbili" // 全新硬笔隶书简.ttf
//#define MENU_FONT @"zhongqi-Wangqinghua" // 钟齐王庆华毛笔简体.TTF
//#define MENU_FONT @"DFPOPMix-W5-WINP-RKSJ-H" // DFPPOPMix-W5

#define MCRelease(__object) if(__object){[__object release];__object=nil;}

// 布局文件
#define LAYOUT_DATA_FILE @"KlotskiLayout.json"
#define LOCAL_DATA_FILE @"local_user_Data.json"

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
#define KeyPassMoveCount @"passMoveCount"
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

// 数字颜色枚举
typedef enum NUMBERTYPE{
    NumberRGBInvalid = 0,
    NumberRGBRed,
    NumberRGBWhite,
    NumberRGBYellow,
    NumberRGBGray,
    NumberRGBMax,
}NumberRBGType;

// 教程布局
#define kTutorialLayout @"{\"gateID\":0,\"layout\":\"[2,0,0,2,1,0,1,2,0,1,3,0,3,2,1,2,1,2,4,2,2,1,0,4,1,1,4,1,3,4]\",\"passMin\":5}"

#define kTutorialCondition @"[{\"keyid\":5,\"rect\":[2,0,2],\"cover\":[\"Arrow1.png\",64.0,210.0,\"dottedline2.png\",34.0,210.0]},{\"keyid\":6,\"rect\":[4,1,2],\"cover\":[\"Arrow1.png\",128.0,210.0,\"dottedline2.png\",98.0,210.0]},{\"keyid\":9,\"rect\":[1,3,2],\"cover\":[\"Arrow2.png\",227.0,215.0,\"dottedline1.png\",225.0,178.0]},{\"keyid\":8,\"rect\":[1,3,3],\"cover\":[\"Arrow4.png\",185.0,295.0,\"dottedline1.png\",225.0,242.0]},{\"keyid\":6,\"rect\":[4,1,3],\"cover\":[\"Arrow3.png\",128.0,300.0,\"\",0.0,0.0]}]"

#endif
