//
//  AbstractCardMatchingGame.h
//  Matchismo
//
//  Created by Mauro Oviedo on 9/22/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

@interface AbstractCardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (Card *)cardAtIndex:(NSUInteger)index;
- (void)flipCardAtIndex:(NSUInteger)index; //abstract

// Output will be either CARD_FLIP, CARD_MATHCED or CARD_MISMATCH
@property (nonatomic, readonly) int lastMove;//abstract
@property (nonatomic, readonly) int score; //abstract
@property (strong, nonatomic) NSArray *positionsOfLastCardsPlayed; //abstract

@end

// enum declaration
enum {
    FLIP_COST           = 1,
    MISMATCH_PENALTY    = 2,
    MATCH_BONUS         = 4,
    CARD_SET_FLIP       = FLIP_COST,
    CARD_SET_MATHCED    = MATCH_BONUS,
    CARD_SET_MISMATCH   = MISMATCH_PENALTY
};

