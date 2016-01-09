//
//  ViewController.m
//  States
//
//  Created by Brian Olencki on 1/8/16.
//  Copyright © 2016 bolencki13. All rights reserved.
//

#import "StatesViewController.h"
#import "StatesTableViewCell.h"
#import "StatesDetailViewController.h"

@interface StatesViewController () <UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate> {
    UITableView *_tblStates;
    NSArray *_aryStates;
    NSMutableArray *_aryStatesVisited;
    
    NSUserDefaults *_prefs;
}
@end

@implementation StatesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"States";
    _prefs = [NSUserDefaults standardUserDefaults];
    
    _aryStates = [self getStates];
    _aryStatesVisited = [[self getVisitedStates] mutableCopy];
    if (_aryStatesVisited == nil || _aryStatesVisited == NULL) {
        _aryStatesVisited = [NSMutableArray new];
    }
    
    _tblStates = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tblStates.delegate = self;
    _tblStates.dataSource = self;
    self.view = _tblStates;

//    UIBarButtonItem *btnBarSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search.png"] style:UIBarButtonItemStylePlain target:self action:@selector(startSearch)];
//    self.navigationItem.rightBarButtonItem = btnBarSearch;
    UIBarButtonItem *btnBarTotal = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%i",(int)[_aryStatesVisited count]] style:UIBarButtonItemStylePlain target:self action:@selector(totalStates)];
    self.navigationItem.leftBarButtonItem = btnBarTotal;
}

#pragma mark - Search
- (void)startSearch {
//    Not yet implemented
}
- (void)totalStates {
    NSString *message = @"";
    for (NSString *item in _aryStatesVisited) {
        message = [NSString stringWithFormat:@"%@\n%@",message, item];
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"States" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Other
- (NSArray*)getStates {
    return @[
             @"Alabama",
             @"Alaska",
             @"Arizona",
             @"Arkansas",
             @"California",
             @"Colorado",
             @"Connecticut",
             @"Delaware",
             @"Florida",
             @"Georgia",
             @"Hawaii",
             @"Idaho",
             @"Illinois",
             @"Indiana",
             @"Iowa",
             @"Kansas",
             @"Kentucky",
             @"Louisiana",
             @"Maine",
             @"Maryland",
             @"Massachusetts",
             @"Michigan",
             @"Minnesota",
             @"Mississippi",
             @"Missouri",
             @"Montana",
             @"Nebraska",
             @"Nevada",
             @"New Hampshire",
             @"New Jersey",
             @"New Mexico",
             @"New York",
             @"North Carolina",
             @"North Dakota",
             @"Ohio",
             @"Oklahoma",
             @"Oregon",
             @"Pennsylvania",
             @"Rhode Island",
             @"South Carolina",
             @"South Dakota",
             @"Tennessee",
             @"Texas",
             @"Utah",
             @"Vermont",
             @"Virginia",
             @"Washington",
             @"West Virginia",
             @"Wisconsin",
             @"Wyoming"
             ];
}
- (NSArray*)getVisitedStates {
    return [_prefs objectForKey:@"visitedStates"];
}
- (UIImage*)getImageForState:(NSString*)state {
    NSString *fullName = [[NSString stringWithFormat:@"state-%@.png",[state stringByReplacingOccurrencesOfString:@" " withString:@"-"]] lowercaseString];
    return [UIImage imageNamed:fullName];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_aryStates count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"CellIdentifier";
    StatesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[StatesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [_aryStates objectAtIndex:indexPath.row];
    cell.imageView.image = [self getImageForState:[_aryStates objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.delegate = self;
    cell.leftButtons = @[
                         [MGSwipeButton buttonWithTitle:[cell cellTextForVisitationState] icon:nil backgroundColor:[UIColor greenColor]]
                         ];
    cell.leftExpansion.buttonIndex = 0;
    cell.leftExpansion.fillOnTrigger = YES;
    if ([_aryStatesVisited containsObject:cell.textLabel.text]) {
        cell.hasBeenVisited = YES;
    } else {
        cell.hasBeenVisited = NO;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StatesDetailViewController *detailViewController = [[StatesDetailViewController alloc] initWithCell:[tableView cellForRowAtIndexPath:indexPath]];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - MGSwipeTableCell Delegate
- (BOOL)swipeTableCell:(MGSwipeTableCell*)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion {
    if (direction == MGSwipeDirectionLeftToRight) {
        ((StatesTableViewCell*)cell).hasBeenVisited = !((StatesTableViewCell*)cell).hasBeenVisited;
        if (((StatesTableViewCell*)cell).hasBeenVisited == YES) {
            [_aryStatesVisited addObject:cell.textLabel.text];
        } else {
            [_aryStatesVisited removeObject:cell.textLabel.text];
        }
        [_prefs setObject:_aryStatesVisited forKey:@"visitedStates"];
        [_prefs synchronize];
        
        self.navigationItem.leftBarButtonItem.title = [NSString stringWithFormat:@"%i",(int)[_aryStatesVisited count]];
    }
    return YES;
}
@end
