//
//  Card.h
//  Matchismo
//
//  Created by Mauro Oviedo on 7/9/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

- (int)match:(NSArray *)otherCards;

@end
