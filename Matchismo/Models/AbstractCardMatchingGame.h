//
//  AbstractCardMatchingGame.h
//  Matchismo
//
//  Created by Mauro Oviedo on 9/22/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractCardMatchingGame.h"


@interface CardMatchingGame : NSObject

- (void)flipCardAtIndex:(NSUInteger)index; //abstract

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) int lastMove;// Output will be either CARD_FLIP, CARD_MATHCED or CARD_MISMATCH
@property (strong, nonatomic) NSArray *positionsOfLastCardsPlayed;

@end
