//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by Mauro Oviedo on 7/14/13.
//  Copyright (c) 2013 Mauro Oviedo. All rights reserved.
//

#import "MatchismoViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface MatchismoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *cardDeck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButton;


@end

@implementation MatchismoViewController

- (PlayingCardDeck *)cardDeck
{
    if (!_cardDeck) {
        _cardDeck = [[PlayingCardDeck alloc] init];
    }
    return _cardDeck;
}

- (void)setCardButton:(NSArray *)cardButtons
{
    _cardButton = cardButtons;
    for (UIButton *cardButton in cardButtons) {
        PlayingCard *card = (PlayingCard *)[self.cardDeck drawRandomCard];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
    }
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flip: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.flipCount++;
}

@end
