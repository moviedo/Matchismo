//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Mauro Oviedo on 8/16/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSNumber *shadingValue in [SetCard validShadings]) {
                for (NSNumber *color in [SetCard validColors]) {
                    for (NSUInteger numberOfSymbol = 1; numberOfSymbol <= [SetCard maxNumberOfSymbols]; numberOfSymbol++) {
                        SetCard *card = [[SetCard alloc] init];
                        
                        card.symbol = symbol;
                        card.shading = shadingValue;
                        card.color = color;
                        card.numberOfSymbols = numberOfSymbol;
                        
                        [self addCard:card atTop:YES];
                        
                    }
                }
            }
        }
    }
    
    return self;
}

@end
