//
//  MatchTeamCell.h
//  Max+2x
//
//  Created by dllo on 16/4/6.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchModel.h"
@interface MatchTeamCell : UITableViewCell

@property (nonatomic, retain) MatchModel *model;

@property (nonatomic, retain) UILabel *textLabelName;

@end
