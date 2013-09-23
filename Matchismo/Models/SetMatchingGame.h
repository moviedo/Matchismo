//
//  SetMatchingGame.h
//  Matchismo
//
//  Created by Mauro Oviedo on 9/22/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractCardMatchingGame.h"

@interface SetMatchingGame : AbstractCardMatchingGame

- (void)flipCardAtIndex:(NSUInteger)index; //implementing abstract

@property (nonatomic, readonly) int lastMove;//implementing abstract
@property (nonatomic, readonly) int score; //implementing abstract
@property (strong, nonatomic) NSArray *positionsOfLastCardsPlayed; //implementing abstract

@end

// enum declaration
enum {
    SET_CARD_FLIP       = FLIP_COST,
    SET_CARD_MATHCED    = MATCH_BONUS,
    SET_CARD_MISMATCH   = MISMATCH_PENALTY
};
