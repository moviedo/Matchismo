//
//  AbstractCardMatchingGame.h
//  Matchismo
//
//  Created by Mauro Oviedo on 9/22/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface AbstractCardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (Card *)cardAtIndex:(NSUInteger)index;
- (void)flipCardAtIndex:(NSUInteger)index; //abstract

// Output will be either CARD_FLIP, CARD_MATHCED or CARD_MISMATCH
@property (nonatomic, readonly) int lastMove;
@property (nonatomic, readonly) int score;

@property (strong, nonatomic, readonly) NSMutableArray *cards;
@property (strong, nonatomic) NSArray *positionsOfLastCardsPlayed;


@end

enum {
    FLIP_COST               = 1,
    MISMATCH_PENALTY        = 2,
    MATCH_BONUS             = 4
};
