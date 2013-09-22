//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Mauro Oviedo on 7/16/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
           withGameMode:(NSUInteger)gameMode;

- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

// Output will be either CARD_FLIP, CARD_MATHCED or CARD_MISMATCH
@property (nonatomic, readonly) int lastMove;
@property (nonatomic, readonly) int score;
@property (strong, nonatomic, readonly) NSArray *positionsOfLastCardsPlayed;

@end

// enum declaration 
enum {
    CARD_SET_FLIP       = 1,
    CARD_SET_MATHCED    = 2,
    CARD_SET_MISMATCH   = 4
};
