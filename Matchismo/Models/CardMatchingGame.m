//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Mauro Oviedo on 7/16/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *lastMove;

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
                self= nil;
            }
            else {
                self.cards[i] = card;
            }
        }
        
    }
    
    return self;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card =[self cardAtIndex:index];
    NSString *lastMove = nil;
    
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
                        self.score += matchScore;
                        lastMove = [NSString stringWithFormat:@"Matched %@ & %@ for %dpts", card.contents, otherCard.contents, matchScore];
                    }
                    else {
                        otherCard.faceUp = NO;
                        
                        self.score -= MISMATCH_PENALTY;
                        lastMove = [NSString stringWithFormat:@"%@ & %@ don't match!", card.contents, otherCard.contents];
                    }
                    
                }
            }
            if (!lastMove) {
                self.lastMove = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            }
            else {
                self.lastMove = lastMove;
            }
            
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
    
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

@end
