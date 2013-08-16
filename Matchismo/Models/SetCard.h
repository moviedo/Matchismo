//
//  SetCard.h
//  Matchismo
//
//  Created by Mauro Oviedo on 8/7/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger numberOfSymbols;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSNumber *color;
@property (strong, nonatomic) NSNumber *shading;

+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumberOfSymbols;

- (int)match:(NSArray *)otherCards;

@end
