//
//  SetCard.m
//  Matchismo
//
//  Created by Mauro Oviedo on 8/7/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validSymbols
{
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)validColors
{
    return @[@1, @2, @3];
}

+ (NSArray *)validShadings
{
    return @[@0.0, @0.5, @1.0];
}

+ (NSUInteger)maxNumberOfSymbols
{
    return 3;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if (otherCards.count == 2) {
        id firstCard = [otherCards objectAtIndex:0];
        id secondCard = [otherCards lastObject];
        
        if ([firstCard isKindOfClass:[SetCard class]] && [secondCard isKindOfClass:[SetCard class]]) {
            SetCard *firstSetCard = (SetCard *)firstCard;
            SetCard *secondSetCard = (SetCard *)secondCard;
            
            //They all have the same number, or they have three different numbers.
            if (firstSetCard.numberOfSymbols == self.numberOfSymbols && secondSetCard.numberOfSymbols == self.numberOfSymbols) {
                score = 2;
            }
            else if (firstSetCard.numberOfSymbols != self.numberOfSymbols &&
                     secondSetCard.numberOfSymbols != self.numberOfSymbols &&
                     firstSetCard.numberOfSymbols != secondSetCard.numberOfSymbols) {
                score = 8;
            }
            //They all have the same shading, or they have three different shadings.
            else if ([firstSetCard.shading isEqualToNumber:self.shading] && [secondSetCard.shading isEqualToNumber:self.shading]) {
                score = 2;
            }
            else if (![firstSetCard.shading isEqualToNumber:self.shading] &&
                     ![secondSetCard.shading isEqualToNumber:self.shading] &&
                     ![firstSetCard.shading isEqualToNumber:secondSetCard.shading]) {
                score = 8;
            }
            //They all have the same symbol, or they have three different symbols.
            else if ([firstSetCard.symbol isEqualToString:self.symbol] &&
                     [secondSetCard.symbol isEqualToString:self.symbol]) {
                score = 2;
            }
            else if (![firstSetCard.symbol isEqualToString:self.symbol] &&
                     ![secondSetCard.symbol isEqualToString:self.symbol] &&
                     ![firstSetCard.symbol isEqualToString:secondSetCard.symbol]) {
                score = 8;
            }
            //They all have the same color, or they have three different colors.
            else if ([firstSetCard.color isEqualToNumber:self.color] &&
                     [secondSetCard.color isEqualToNumber:self.color]) {
                score = 2;
            }
            else if (![firstSetCard.color isEqualToNumber:self.color] &&
                     ![secondSetCard.color isEqualToNumber:self.color] &&
                     ![firstSetCard.color isEqualToNumber:secondSetCard.color]) {
                score = 8;
            }
        }
    }
    
    return score;
}

- (NSString *)contents
{
    NSString *generatedSymbol = @"";
    generatedSymbol = [generatedSymbol stringByPaddingToLength:self.numberOfSymbols withString:self.symbol startingAtIndex:0];
    return generatedSymbol;
}

- (void)setNumberOfSymbol:(NSUInteger)numberOfSymbols
{
    if (numberOfSymbols <= [SetCard maxNumberOfSymbols]) {
        _numberOfSymbols = numberOfSymbols;
    }
}

@synthesize symbol = _symbol; // because we provide setter AND getter

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

@synthesize color = _color;

- (NSNumber *)color
{
    return _color ? _color : @-1;
}

- (void)setColor:(NSNumber *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

@synthesize shading = _shading;

- (NSNumber *)shading
{
    return _shading ? _shading : @-1;
}

- (void)setShading:(NSNumber *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}
@end
