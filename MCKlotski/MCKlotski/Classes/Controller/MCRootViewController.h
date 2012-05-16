//
//  MCRootViewController.h
//  MCKlotski
//
//  Created by gtts on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCViewController.h"
#import "MCDataManager.h"


@interface MCRootViewController : MCViewController<DataManagerObserver> {
    UIButton *_btnPlay;
}

@end
