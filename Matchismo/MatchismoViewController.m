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

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation MatchismoViewController

- (CardMatchingGame *)game
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
    [self updateLastMove];
    
    // Update score
    self.score = self.game.score;
}

- (void)updateLastMove
{
    NSArray *positionsOfLastCardsPlayed = self.game.positionsOfLastCardsPlayed;
    NSAttributedString *period = [[NSAttributedString alloc] initWithString:@"."];
    
    if (self.game.lastMove == PLAYING_CARD_FLIP) {
        UIButton *playingCardButton = [self.cardButtons objectAtIndex:[[positionsOfLastCardsPlayed lastObject] integerValue]];
        
        if (playingCardButton.isSelected) {
            
            NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:[playingCardButton titleForState:UIControlStateSelected]];
            [temp appendAttributedString:period];

            [temp insertAttributedString:[[NSAttributedString alloc] initWithString:@"Selected "]
                                 atIndex:0];
            
            self.lastMove = [temp copy];
        }
    }
    else if (self.game.lastMove == PLAYING_CARD_MATHCED || self.game.lastMove == PLAYING_CARD_MISMATCH) {
        UIButton *firstCard = [self.cardButtons objectAtIndex:[positionsOfLastCardsPlayed[0] integerValue]];
        UIButton *secondCard = [self.cardButtons objectAtIndex:[positionsOfLastCardsPlayed[1] integerValue]];
        
        NSAttributedString *ampersand = [[NSAttributedString alloc] initWithString:@" & "];
        
        //Add first attributed string, button title
        NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:[firstCard titleForState:UIControlStateSelected]];
        
        //Add second attributed string, button title, spacing and period
        [temp appendAttributedString:ampersand];
        [temp appendAttributedString:[[NSAttributedString alloc] initWithString:[secondCard titleForState:UIControlStateSelected]]];
        [temp appendAttributedString:period];
        
        if (self.game.lastMove == PLAYING_CARD_MATHCED) {
            
            [temp insertAttributedString:[[NSAttributedString alloc] initWithString:@"Matched "]
                                 atIndex:0];
            
        }
        else {
            
            [temp insertAttributedString:[[NSAttributedString alloc] initWithString:@"Mismatched "]
                                 atIndex:0];
            
        }
        self.lastMove = [temp copy];
        
    }
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