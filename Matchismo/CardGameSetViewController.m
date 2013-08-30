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
#import "CardMatchingGame.h"

@interface CardGameSetViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation CardGameSetViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        // Set game mode
        int gameMode = 1;
        _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count
                                                 usingDeck:[[SetCardDeck alloc] init]
                                              withGameMode:gameMode];
    }
    
    return _game;
}

- (void)updateUI
{
    NSArray *playedCards = @[];
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
            playedCards = [playedCards arrayByAddingObject:card];
        }
        else {
            [cardButton setBackgroundColor:nil];
        }
    }
    
    // Update last move
    if (!self.game.lastMove) {
        self.lastMove = [[NSAttributedString alloc] initWithString:@"Last Move"];
    }
    else {
       
        self.lastMove = [CardGameSetViewController formatNSAttributedStringForLastMove:self.game.lastMove
                                                                             withCards:playedCards];
    }
    // Update score
    self.score = self.game.score;
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

+ (NSAttributedString *)formatNSAttributedStringForLastMove:(NSString *)string
                                            withCards:(NSArray *)playedCards
{
    NSMutableAttributedString *lastMove = [[[NSAttributedString alloc] initWithString:string] mutableCopy];
    
    for (SetCard *card in playedCards) {
        NSRange sybmolRange = [string rangeOfString:card.contents];
        
        [lastMove setAttributes:[CardGameSetViewController createAttributeDictionary:card]
                          range:sybmolRange];
    }
    
    return lastMove;
}

+ (NSDictionary *)createAttributeDictionary:(SetCard *)card
{
    UIColor *color = [CardGameSetViewController translateColorFromModel:(SetCard *)card];
    
    NSDictionary *symbolAttributes = @{
                                       NSForegroundColorAttributeName : color,
                                       NSStrokeWidthAttributeName : @-5,
                                       NSStrokeColorAttributeName : [color colorWithAlphaComponent:1.0]
                                       };
    
    return symbolAttributes;
}

@end