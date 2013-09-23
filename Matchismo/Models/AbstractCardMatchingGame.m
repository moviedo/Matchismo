//
//  AbstractCardMatchingGame.m
//  Matchismo
//
//  Created by Mauro Oviedo on 9/22/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (strong, nonatomic) NSArray *positionsOfCardsPlayed;

@property (nonatomic, readwrite) int lastMove;
@property (nonatomic, readwrite) int score;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if(!card) {
                self = nil;
            }
            else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    //abstract
}

-(NSArray *)positionsOfLastCardsPlayed;
{
    if (!_positionsOfCardsPlayed) {
        _positionsOfCardsPlayed = [[NSArray alloc] init];
    }
    
    return _positionsOfCardsPlayed;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

@end
