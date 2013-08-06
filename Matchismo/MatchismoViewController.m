//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by Mauro Oviedo on 7/14/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "MatchismoViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface MatchismoViewController ()

@property (nonatomic) int flipCount;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString * lastMove;

@property (strong, nonatomic) CardMatchingGame *game;

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSwitch;
@property (strong, nonatomic) GameResult *gameResult;

@end

@implementation MatchismoViewController

- (GameResult *)gameResult
{
    if (!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    
    return _gameResult;
}

- (CardMatchingGame *)game
{
    int selected_index = self.gameModeSwitch.selectedSegmentIndex;
    NSString *gameModeTitle = [self.gameModeSwitch titleForSegmentAtIndex:selected_index];
    int gameMode = 0;
    
    if (!_game) {
        // Set game mode
        if ([gameModeTitle isEqualToString:@"Match 3"]) {
            gameMode = 1;
        }
        
        _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count
                                                 usingDeck:[[PlayingCardDeck alloc] init]
                                              withGameMode:gameMode];
    }
    
    return _game;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected];
        [cardButton setTitle:card.contents
                    forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    // Update last move
    self.lastMove = self.game.lastMove;
    // Update score
    self.score = self.game.score;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
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

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
    //Disable UISegmentedControl
    self.gameModeSwitch.enabled = NO;
    
    //
    self.gameResult.score = self.game.score;
}

- (IBAction)dealButton:(UIButton *)sender {
    // Reset game
    self.game = nil;
    
    // Update UI
    [self updateUI];
    self.lastMove = @"Move";
    self.flipCount = 0;
    self.score = 0;
    self.gameModeSwitch.enabled = YES;
}

- (IBAction)gameModeSwitch:(UISegmentedControl *)sender {
    // Reset game
    self.game = nil;
    self.game = self.game;
}

@end