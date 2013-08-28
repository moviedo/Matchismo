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

#define RED_COLOR @1
#define BLUE_COLOR @2
#define GREEN_COLOR @3

+ (NSArray *)validColors
{
    return @[RED_COLOR, BLUE_COLOR, GREEN_COLOR];
}

#define NO_SHADING @0.0
#define PARTIAL_SHADING @0.2
#define SOLID_SHADING @1.0

+ (NSArray *)validShadings
{
    return @[NO_SHADING, PARTIAL_SHADING, SOLID_SHADING];
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
            if ((firstSetCard.numberOfSymbols == self.numberOfSymbols &&
                secondSetCard.numberOfSymbols == self.numberOfSymbols)
                ||
                (firstSetCard.numberOfSymbols != self.numberOfSymbols &&
                secondSetCard.numberOfSymbols != self.numberOfSymbols &&
                firstSetCard.numberOfSymbols != secondSetCard.numberOfSymbols)) {
                    
                    //They all have the same shading, or they have three different shadings.
                    if (([firstSetCard.shading isEqualToNumber:self.shading] &&
                        [secondSetCard.shading isEqualToNumber:self.shading])
                        ||
                        (![firstSetCard.shading isEqualToNumber:self.shading] &&
                         ![secondSetCard.shading isEqualToNumber:self.shading] &&
                         ![firstSetCard.shading isEqualToNumber:secondSetCard.shading])) {
                            
                            //They all have the same symbol, or they have three different symbols.
                            if (([firstSetCard.symbol isEqualToString:self.symbol] &&
                                [secondSetCard.symbol isEqualToString:self.symbol])
                                ||
                                (![firstSetCard.symbol isEqualToString:self.symbol] &&
                                 ![secondSetCard.symbol isEqualToString:self.symbol] &&
                                 ![firstSetCard.symbol isEqualToString:secondSetCard.symbol])) {
                                    
                                     //They all have the same color, or they have three different colors.
                                    if (([firstSetCard.color isEqualToNumber:self.color] &&
                                        [secondSetCard.color isEqualToNumber:self.color])
                                        ||
                                        (![firstSetCard.color isEqualToNumber:self.color] &&
                                         ![secondSetCard.color isEqualToNumber:self.color] &&
                                         ![firstSetCard.color isEqualToNumber:secondSetCard.color])) {
                                            score = 2;
                                        }
                                }
                        }
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
