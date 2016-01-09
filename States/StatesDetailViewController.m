//
//  StatesDetailViewController.m
//  States
//
//  Created by Brian Olencki on 1/9/16.
//  Copyright © 2016 bolencki13. All rights reserved.
//

#import "StatesDetailViewController.h"

@interface StatesDetailViewController () {
    UIImageView *_imgViewFlat;
    
    UILabel *_lblVisitationStatus;
}

@end

@implementation StatesDetailViewController
- (instancetype)initWithCell:(StatesTableViewCell *)cell {
    if (self == [super init]) {
        self.navigationItem.title = cell.textLabel.text;
        
        _imgViewFlat = [[UIImageView alloc] initWithFrame:CGRectMake(25, 75, self.view.frame.size.width-50, self.view.frame.size.width-50)];
        _imgViewFlat.image = cell.imageView.image;
        _imgViewFlat.backgroundColor = [UIColor blackColor];
        _imgViewFlat.layer.cornerRadius = 5;
        _imgViewFlat.layer.masksToBounds = YES;
        [self.view addSubview:_imgViewFlat];
        
        _lblVisitationStatus = [[UILabel alloc] initWithFrame:CGRectMake(25, _imgViewFlat.frame.origin.y+_imgViewFlat.frame.size.height+15, self.view.frame.size.width-50, 35)];
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Visitation Status: %@", cell.hasBeenVisited ? @"Visited" : @"Not Visited"]];
        
        [text addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 19)];
        [text addAttribute:NSForegroundColorAttributeName value:(cell.hasBeenVisited ? [UIColor greenColor]: [UIColor redColor]) range:NSMakeRange(19, text.length-19)];
        [_lblVisitationStatus setAttributedText:text];
        [self.view addSubview:_lblVisitationStatus];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}
@end
