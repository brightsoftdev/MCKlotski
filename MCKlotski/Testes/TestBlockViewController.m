//
//  TestBlockViewController.m
//  MCKlotski
//
//  Created by gtts on 5/4/12.
//  Copyright (c) 2012 TJUT-SCCE-SIPC. All rights reserved.
//

#import "TestBlockViewController.h"
#import "MCBlock.h"
#import "MCBlockView.h"

@interface TestBlockViewController ()

@end

@implementation TestBlockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"BlockView Test";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    
    MCBlock *block = [[MCBlock alloc] init];
    block.blockID = 1;
    block.blockType = kBlockTypeLager;
    block.positionX = 1;
    block.positionY = 1;
    MCBlockView * blockView = [[MCBlockView alloc] initWithBlock:block];
    blockView.delegate = self;
    [self.view addSubview:blockView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - BlockViewDelegate
- (BOOL) blockShouldMoveWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
    return YES;
}

- (void) blockBeganMoveWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
    NSLog(@"blockBeganMoveWith:%i", blockGesture);
}

- (void) blockEndMoveWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
     NSLog(@"blockEndMoveWith:%i", blockGesture);
}

- (void) blockFrameDidChangeWith:(MCBlockView *)blockView andGesture:(kBlockGesture)blockGesture
{
     NSLog(@"blockFrameDidChangeWith:%i", blockGesture);
}

@end
