//
//  BaseCardGameViewController.m
//  Matchismo
//
//  Created by Mauro Oviedo on 8/9/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "BaseCardGameViewController.h"

@interface BaseCardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;

@end

@implementation BaseCardGameViewController

- (GameResult *)gameResult
{
    if (!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    
    return _gameResult;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flip: %d", self.flipCount];
}

- (void)setLastMove:(NSString *)lastMove
{
    _lastMove = lastMove;
    self.lastMoveLabel.text = [NSString stringWithFormat:@"Last: %@", self.lastMove];
}

- (void)setScore:(int)score
{
    _score = score;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.score];
}

- (void)resetInformationalLabels
{
    [self setFlipCount:0];
    [self setLastMove:@"Move"];
    [self setScore:0];
}

// Used to implement custom deal button
- (IBAction)dealButton {
}

@end
