//
//  StatesTableViewCell.h
//  States
//
//  Created by Brian Olencki on 1/9/16.
//  Copyright © 2016 bolencki13. All rights reserved.
//

#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"

@interface StatesTableViewCell : MGSwipeTableCell {
    BOOL _hasBeenVisited;
}
@property (nonatomic, assign) BOOL hasBeenVisited;
- (NSString*)cellTextForVisitationState;
@end
