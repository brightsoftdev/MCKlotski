//
//  MCTestSound.m
//  MCKlotski
//
//  Created by lim edwon on 12-4-22.
//  Copyright (c) 2012年 TJUT-SCCE-SIPC. All rights reserved.
//

#import "MCTestSound.h"
#import "MCViewController.h"
#import "GGFoundation.h"

@implementation MCTestSound

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"My Sound";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma IB event
- (IBAction)switchEvent:(id)sender
{
    UISwitch *swithCont = (UISwitch *)sender;
    switch (swithCont.on) {
        case YES:
            [[GGSoundManager sharedGGSoundManager] playBackMusic:@"backMusic.mp3" loop:YES];
            break;
        case NO:
            [[GGSoundManager sharedGGSoundManager] stopBackMusic];
            break;
        default:
            break;
    }
}

- (IBAction)volumeControl:(id)sender
{
    UISlider *volume = (UISlider *)sender;
    [GGSoundManager sharedGGSoundManager].backMusicVolume = volume.value;
    [GGSoundManager sharedGGSoundManager].effectVolume = volume.value;
}

- (IBAction)pause:(id)sender
{
    [[GGSoundManager sharedGGSoundManager] pauseBackMusic];
}

- (IBAction)resume:(id)sender
{
    [[GGSoundManager sharedGGSoundManager] resumeBackMusic];
}

- (IBAction)openEffect:(id)sender
{
    [[GGSoundManager sharedGGSoundManager] playEffect:@"crow.mp3"];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [GGSoundManager sharedGGSoundManager].loadBackMusicArr = @"backMusic.mp3";
    [GGSoundManager sharedGGSoundManager].loadEffectArr = [[NSArray arrayWithObjects:@"crow.mp3", nil] autorelease];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
