//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Mauro Oviedo on 7/16/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractCardMatchingGame.h"


@interface CardMatchingGame : AbstractCardMatchingGame

- (void)flipCardAtIndex:(NSUInteger)index; //implementing abstract

@end

// enum declaration
enum {
    PLAYING_CARD_FLIP       = FLIP_COST,
    PLAYING_CARD_MATHCED    = MATCH_BONUS,
    PLAYING_CARD_MISMATCH   = MISMATCH_PENALTY
};