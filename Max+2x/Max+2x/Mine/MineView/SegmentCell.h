//
//  SegmentCell.h
//  Max+2x
//
//  Created by dllo on 16/3/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentCell : UICollectionViewCell

@property (nonatomic, retain) UILabel *textLabel;

@property (nonatomic, assign) NSInteger pick;

@property(nonatomic,assign)BOOL select_not;

@end
