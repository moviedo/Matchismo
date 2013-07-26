//
//  PlayingCard.h
//  Matchismo
//
//  Created by Mauro Oviedo on 7/9/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

- (int)match:(NSArray *)otherCards;

@end
