//
//  AbstractCardMatchingGame.h
//  Matchismo
//
//  Created by Mauro Oviedo on 9/22/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index; //abstract
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) int lastMove;// Output will be either CARD_FLIP, CARD_MATHCED or CARD_MISMATCH
@property (strong, nonatomic) NSArray *positionsOfLastCardsPlayed;

@end

// enum declaration
enum {
    CARD_SET_FLIP       = 1,
    CARD_SET_MATHCED    = 2,
    CARD_SET_MISMATCH   = 4
};
