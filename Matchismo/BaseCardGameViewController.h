//
//  BaseCardGameViewController.h
//  Matchismo
//
//  Created by Mauro Oviedo on 8/9/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameResult.h"

@interface BaseCardGameViewController : UIViewController

@property (nonatomic) int flipCount;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *lastMove;
@property (strong, nonatomic) GameResult *gameResult;

- (void)resetInformationalLabels;

@end
