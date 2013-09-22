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
@property (strong, nonatomic) NSArray *positionsOfCardsPlayed;

@property (nonatomic) int gameMode;
@property (nonatomic, readwrite) int lastMove;
@property (nonatomic, readwrite) int score;

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

#define MATCH_CARD_GAME_MODE 0
#define SET_CARD_GAME_MODE 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card =[self cardAtIndex:index];
    NSNumber *cardFlipped = [[NSNumber alloc] initWithInt:index];
    self.positionsOfCardsPlayed = [NSArray arrayWithObject:cardFlipped];
    self.lastMove = FLIP_COST;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            
            // 2 card game mode
            if (self.gameMode == MATCH_CARD_GAME_MODE) {
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
                        self.positionsOfCardsPlayed = [[NSArray alloc] initWithObjects:cardFlipped, otherCardPlayed, nil];
                    }
                }
            }
            // 3 card game mode
            else if (self.gameMode == SET_CARD_GAME_MODE) {
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
                            self.positionsOfCardsPlayed = [[NSArray alloc] initWithObjects:cardFlipped, otherCardPlayed_1, otherCardPlayed_2, nil];
                        }
                    }
                }
            }
            
            self.score -= FLIP_COST;
            
        }
        card.faceUp = !card.isFaceUp;
    }
    
}

-(NSArray *)positionsOfLastCardsPlayed;
{
    if (!_positionsOfCardsPlayed) {
        _positionsOfCardsPlayed = [[NSArray alloc] init];
    }
    
    return _positionsOfCardsPlayed;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

@end
