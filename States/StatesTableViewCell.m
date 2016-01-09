//
//  StatesTableViewCell.m
//  States
//
//  Created by Brian Olencki on 1/9/16.
//  Copyright © 2016 bolencki13. All rights reserved.
//

#import "StatesTableViewCell.h"

@interface StatesTableViewCell () {
    UIView *viewIndicator;
}

@end

@implementation StatesTableViewCell
@synthesize hasBeenVisited = _hasBeenVisited;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _hasBeenVisited = NO;
        
        viewIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.frame.size.height)];
        viewIndicator.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:viewIndicator];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    viewIndicator.frame = CGRectMake(0, 0, 10, self.frame.size.height);
    viewIndicator.backgroundColor = _hasBeenVisited ? [UIColor greenColor] : [UIColor clearColor];
}
- (void)setHasBeenVisited:(BOOL)hasBeenVisited {
    _hasBeenVisited = hasBeenVisited;
    
    viewIndicator.backgroundColor = _hasBeenVisited ? [UIColor greenColor] : [UIColor clearColor];
    [[self.leftButtons objectAtIndex:0] setTitle:[self cellTextForVisitationState] forState:UIControlStateNormal];
}
- (NSString*)cellTextForVisitationState {
    return _hasBeenVisited ? @"Mark as\nnot visited" : @"Mark as\nvisited";
}
@end
