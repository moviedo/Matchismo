//
//  CardGameSetViewController.m
//  Matchismo
//
//  Created by Mauro Oviedo on 8/7/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "CardGameSetViewController.h"
//#import "SetCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameSetViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation CardGameSetViewController

//- (CardMatchingGame *)game
//{
//    if (!_game) {
//        // Set game mode
//        int gameMode = 1;
//        _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count
//                                                 usingDeck:[[SetCardDeck alloc] init]
//                                              withGameMode:gameMode];
//    }
//    
//    return _game;
//}

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

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
    // Set GameResult VC
    self.gameResult.score = self.game.score;
}

- (IBAction)dealButton {
    // Reset game
    self.game = nil;
    
    // Update UI
    [self updateUI];
    [self resetInformationalLabels];
}
@end