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
            SetCard *card = [[SetCard alloc] init];
            
            for (NSNumber *shadingValue in [SetCard validShadings]) {
                card.shading = shadingValue;
                
                for (NSNumber *color in [SetCard validColors]) {
                    card.color = color;
                    
                    for (NSUInteger numberOfSymbol = 1; numberOfSymbol <= [SetCard maxNumberOfSymbols]; numberOfSymbol++) {
                        card.numberOfSymbols = numberOfSymbol;
                        
                    }
                }
            }
            
            [self addCard:card atTop:YES];
        }
    }
    
    return self;
}

@end
