//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Mauro Oviedo on 7/16/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic, readwrite) NSMutableArray *cards;

@property (nonatomic, readwrite) int lastMove;
@property (nonatomic, readwrite) int score;

@end

@implementation CardMatchingGame

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card =[self cardAtIndex:index];
    NSNumber *cardFlipped = [[NSNumber alloc] initWithInt:index];
    self.positionsOfLastCardsPlayed = @[cardFlipped];
    self.lastMove = PLAYING_CARD_FLIP;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            //see if flipping  this card up creates a match
            for (Card* otherCard in self.cards) {
                    
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        
                        matchScore = matchScore * MATCH_BONUS;
                        self.lastMove = MATCH_BONUS;
                        self.score += matchScore;
                    }
                    else {
                        otherCard.faceUp = NO;
                        
                        self.lastMove = MISMATCH_PENALTY;
                        self.score -= MISMATCH_PENALTY;
                    }
                    
                    //Add card positions to the property
                    NSNumber *otherCardPlayed = [[NSNumber alloc] initWithInt:[self.cards indexOfObject:otherCard]];
                    self.positionsOfLastCardsPlayed = [[NSArray alloc] initWithObjects:cardFlipped, otherCardPlayed, nil];
                }
            }
        
            self.score -= FLIP_COST;
        }
    }
    card.faceUp = !card.isFaceUp;
}

@end
