//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Mauro Oviedo on 8/6/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()

@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController

- (void)updateUI
{
    NSString *displayText = @"";
    
    for (GameResult *gameResult in [GameResult allGameResults]) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", gameResult.score, gameResult.start, round(gameResult.duration)];
    }
    self.display.text = displayText;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

@end
