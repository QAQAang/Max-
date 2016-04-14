//
//  RoleTableViewCell.h
//  Max+2x
//
//  Created by dllo on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkipView.h"
@interface RoleTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *imageViewHead;

@property (nonatomic, retain) UILabel *textLabelName;

@property (nonatomic, retain) SkipView *skipView;

@end
