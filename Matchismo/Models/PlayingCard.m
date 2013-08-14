//
//  PlayingCard.m
//  Matchismo
//
//  Created by Mauro Oviedo on 7/9/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()

@end

@implementation PlayingCard
@synthesize suit = _suit; // because we provide setter AND getter

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    // 2 card game mode
    if (otherCards.count == 1) {
        id otherCard = [otherCards lastObject];
        
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
            
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                score = 1;
            }
            else if (otherPlayingCard.rank == self.rank) {
                score = 4;
            }
        }
    }
    // 3 card game mode
    else if (otherCards.count == 2) {
        id firstCard = [otherCards objectAtIndex:0];
        id secondCard = [otherCards lastObject];
        
        if ([firstCard isKindOfClass:[PlayingCard class]] && [secondCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *firstPlayingCard = (PlayingCard *)firstCard;
            PlayingCard *secondPlayingCard = (PlayingCard *)secondCard;
            
            if ([firstPlayingCard.suit isEqualToString:self.suit] && [secondPlayingCard.suit isEqualToString:self.suit]) {
                score = 2;
            }
            else if (firstPlayingCard.rank == self.rank && secondPlayingCard.rank == self.rank) {
                score = 8;
            }
        }
        
        
    }
    
    return score;
}

- (NSString *)contents
{
    NSArray * rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
