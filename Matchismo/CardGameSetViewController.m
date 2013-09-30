//
//  CardGameSetViewController.m
//  Matchismo
//
//  Created by Mauro Oviedo on 8/7/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "CardGameSetViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetMatchingGame.h"

@interface CardGameSetViewController ()

@property (strong, nonatomic) SetMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation CardGameSetViewController

- (SetMatchingGame *)game
{
    if (!_game) {
        _game = [[SetMatchingGame alloc]initWithCardCount:self.cardButtons.count
                                                 usingDeck:[[SetCardDeck alloc] init]];
    }
    
    return _game;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        NSAttributedString *setGameAttributedString = nil;
        
        if ([card isKindOfClass:[SetCard class]]) {
            UIColor *color = [CardGameSetViewController translateColorFromModel:(SetCard *)card];
            
            setGameAttributedString =
            [[NSAttributedString alloc] initWithString:card.contents
                                            attributes:@{
                                  NSFontAttributeName : [UIFont systemFontOfSize:20],
                       NSForegroundColorAttributeName : color,
                           NSStrokeWidthAttributeName : @-5,
                           NSStrokeColorAttributeName : [color colorWithAlphaComponent:1.0]
             }];
        }
        
        [cardButton setAttributedTitle: setGameAttributedString
                              forState:UIControlStateNormal];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.0 : 1.0;
        
        if (cardButton.selected) {
            [cardButton setBackgroundColor:[UIColor lightGrayColor]];
        }
        else {
            [cardButton setBackgroundColor:nil];
        }
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
    
    if (self.game.lastMove == SET_CARD_FLIP) {
        UIButton *setCardButton = [self.cardButtons objectAtIndex:[[positionsOfLastCardsPlayed lastObject] integerValue]];
        
        if (setCardButton.isSelected) {
            
            NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithAttributedString:[setCardButton currentAttributedTitle]];
            [temp appendAttributedString:period];
            
            [temp insertAttributedString:[[NSAttributedString alloc] initWithString:@"Selected "]
                                 atIndex:0];
            
            self.lastMove = [temp copy];
        }
    }
    else if (self.game.lastMove == SET_CARD_MATHCED || self.game.lastMove == SET_CARD_MISMATCH) {
        UIButton *firstCard = [self.cardButtons objectAtIndex:[positionsOfLastCardsPlayed[0] integerValue]];
        UIButton *secondCard = [self.cardButtons objectAtIndex:[positionsOfLastCardsPlayed[1] integerValue]];
        UIButton *thirdCard = [self.cardButtons objectAtIndex:[positionsOfLastCardsPlayed[2]integerValue]];
        
        NSAttributedString *ampersand = [[NSAttributedString alloc] initWithString:@" & "];
        NSAttributedString *spacing = [[NSAttributedString alloc] initWithString:@" "];
        
        //Add first attributed string, button title
        NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithAttributedString:[firstCard currentAttributedTitle]];
        
        //Add second attributed string, button title, and spacing
        [temp appendAttributedString:spacing];
        [temp appendAttributedString:[secondCard currentAttributedTitle]];
        
        //Add third attributed string, button title, spacing and period
        [temp appendAttributedString:ampersand];
        [temp appendAttributedString:[thirdCard currentAttributedTitle]];
        [temp appendAttributedString:period];
        
        if (self.game.lastMove == SET_CARD_MATHCED) {
            
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

+ (UIColor *)translateColorFromModel:(SetCard *)card
{
    UIColor *cardColor = nil;
    
    if ([card.color isEqualToNumber:@1]) {
        cardColor = [UIColor redColor];
    }
    else if ([card.color isEqualToNumber:@2]) {
        cardColor = [UIColor greenColor];
    }
    else {
        cardColor = [UIColor blueColor];
    }
    
    cardColor = [cardColor colorWithAlphaComponent:[card.shading floatValue]];
    
    return cardColor;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

@end