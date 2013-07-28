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

@interface MatchismoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;

@end

@implementation MatchismoViewController

- (CardMatchingGame *) game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count
                                                 usingDeck:[[PlayingCardDeck alloc] init]];
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
    self.lastMoveLabel.text = [NSString stringWithFormat:@"Last: %@", self.game.lastMove];
    // Update score
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
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

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)dealButton:(UIButton *)sender {
    // Reset game
    self.game = nil;
    self.game = self.game;
    
    // Update UI
    [self updateUI];
    self.lastMoveLabel.text = @"Last: Move";
    self.flipLabel.text = @"Flip: 0";
    self.scoreLabel.text = @"Score: 0";
}

@end
