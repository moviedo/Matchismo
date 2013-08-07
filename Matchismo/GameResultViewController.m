//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Mauro Oviedo on 8/6/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()

@property (weak, nonatomic) IBOutlet UITextView *display;
@property (nonatomic) SEL sortSelector;

@end

@implementation GameResultViewController

- (void)updateUI
{
    NSString *displayText = @"";
    
    for (GameResult *gameResult in [[GameResult allGameResults] sortedArrayUsingSelector:self.sortSelector]) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", gameResult.score, gameResult.start, round(gameResult.duration)];
    }
    self.display.text = displayText;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}


@synthesize sortSelector = _sortSelector;  // because we implement BOTH setter and getter

// return default sort selector if none set (by score)
- (SEL)sortSelector
{
    if (!_sortSelector) _sortSelector = @selector(compareScoreToGameResult:);
    return _sortSelector;
}

// update the UI when changing the sort selector
- (void)setSortSelector:(SEL)sortSelector
{
    _sortSelector = sortSelector;
    [self updateUI];
}

- (IBAction)sortByDate {
    self.sortSelector = @selector(compareEndDateToGameResult:);
}

- (IBAction)sortByScore {
    self.sortSelector = @selector(compareScoreToGameResult:);
}

- (IBAction)sortByDuration {
    self.sortSelector = @selector(compareDurationToGameResult:);
}

@end
