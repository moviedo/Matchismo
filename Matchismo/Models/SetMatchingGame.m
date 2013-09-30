//
//  SetMatchingGame.m
//  Matchismo
//
//  Created by Mauro Oviedo on 9/22/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "SetMatchingGame.h"

@interface SetMatchingGame ()

@property (nonatomic, readwrite) int lastMove;
@property (nonatomic, readwrite) int score;

@end

@implementation SetMatchingGame

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card =[self cardAtIndex:index];
    NSNumber *cardFlipped = [[NSNumber alloc] initWithInt:index];
    self.positionsOfLastCardsPlayed = @[cardFlipped];
    self.lastMove = FLIP_COST;
    
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            
            for (Card* otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                    
                    if (otherCards.count == 2) {
                        int matchScore = [card match:[otherCards copy]];
                        
                        if (matchScore) {
                            for (Card *matchedCard in otherCards) {
                                matchedCard.unplayable = YES;
                            }
                            card.unplayable = YES;
                            
                            matchScore = matchScore * MATCH_BONUS;
                            self.lastMove = MATCH_BONUS;
                            self.score += matchScore;
                        }
                        else {
                            for (Card *matchedCard in otherCards) {
                                matchedCard.faceUp = NO;
                            }
                            
                            self.lastMove = MISMATCH_PENALTY;
                            self.score -= MISMATCH_PENALTY;
                            
                        }
                        
                        //Add card positions to the property
                        NSNumber *otherCardPlayed_1 = [[NSNumber alloc] initWithInt:[self.cards indexOfObject:otherCards[0]]];
                        NSNumber *otherCardPlayed_2 = [[NSNumber alloc] initWithInt:[self.cards indexOfObject:otherCards[1]]];
                        self.positionsOfLastCardsPlayed = [self.positionsOfLastCardsPlayed arrayByAddingObjectsFromArray:@[otherCardPlayed_1, otherCardPlayed_2]];
                    }
                }
            }
            
            self.score -= FLIP_COST;
        }
    }
    
    card.faceUp = !card.isFaceUp;
}


@end
