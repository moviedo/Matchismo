//
//  AbstractCardMatchingGame.m
//  Matchismo
//
//  Created by Mauro Oviedo on 9/22/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "AbstractCardMatchingGame.h"

@interface AbstractCardMatchingGame()

@property (strong, nonatomic, readwrite) NSMutableArray *cards;

@property (nonatomic, readwrite) int lastMove;
@property (nonatomic, readwrite) int score;

@end

@implementation AbstractCardMatchingGame

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
    if (!_positionsOfLastCardsPlayed) {
        _positionsOfLastCardsPlayed = [[NSArray alloc] init];
    }
    
    return _positionsOfLastCardsPlayed;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

@end
