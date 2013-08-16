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
    return @[@"△",@"○",@"□"];
}

+ (NSArray *)validColors
{
    return @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor]];
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
            if (firstSetCard.number == self.number && secondSetCard.number == self.number) {
                score = 2;
            }
            else if (firstSetCard.number != self.number &&
                     secondSetCard.number != self.number &&
                     firstSetCard.number != secondSetCard.number) {
                score = 8;
            }
            //They all have the same shading, or they have three different shadings.
            else if (firstSetCard.shading == self.shading && secondSetCard.shading == self.shading) {
                score = 2;
            }
            else if (firstSetCard.shading != self.shading &&
                     secondSetCard.shading != self.shading &&
                     firstSetCard.shading != secondSetCard.shading) {
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
            else if (YES) {
                
            }
            else if (YES) {
                
            }
        }
    }
    
    return score;
}

- (NSString *)contents
{
    NSString *generatedSymbol = @"";
    for (int i=0; i < self.number; i++) {
        generatedSymbol = [generatedSymbol stringByAppendingString:self.symbol];
    }
    return generatedSymbol;
}

@synthesize symbol = _symbol; // because we provide setter AND getter

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumberOfSymbols]) {
        _number = number;
    }
}

@end
