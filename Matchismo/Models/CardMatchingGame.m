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
@property (nonatomic) int gameMode;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck
           withGameMode:(NSUInteger)gameMode;
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
        
        self.gameMode = gameMode;
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
            
            // Check game mode
            NSLog(@"Game Mode is: %d", self.gameMode);
            // 2 card game mode
            if (self.gameMode == 0) {
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
            }
            // 3 card game mode
            else if (self.gameMode == 1) {
                NSMutableArray *otherCards = [[NSMutableArray alloc] init];
                
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
                                self.score += matchScore;
                                lastMove = [NSString stringWithFormat:@"Matched %@ & %@ for %dpts",
                                            [self otherCards:otherCards joinedByString:@", "],
                                             card.contents,
                                             matchScore];
                            }
                            else {
                                for (Card *matchedCard in otherCards) {
                                    matchedCard.faceUp = NO;
                                }
                                
                                self.score -= MISMATCH_PENALTY;
                                lastMove = [NSString stringWithFormat:@"%@ & %@ don't match!",
                                            [self otherCards:otherCards joinedByString:@", "],
                                            card.contents];
                            }
                        }
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

- (NSString *)otherCards:(NSArray *)otherCards joinedByString:(NSString *)string
{
    NSString * finalString = @"";
    for (Card *aCard in otherCards)
    {
        if ([otherCards lastObject] == aCard) {
            finalString = [finalString stringByAppendingString:aCard.contents];
        }
        else {
            finalString = [finalString stringByAppendingFormat:@"%@%@ ", aCard.contents, string];
        }
    }
    return finalString;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

@end
