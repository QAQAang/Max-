//
//  findDetailViewController.h
//  Max+2x
//
//  Created by 谷萌雨 on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "findModel.h"


@protocol GMYReadingDetailViewControllerDelegate <NSObject>

- (void)deleteFromCollection:(NSIndexPath *)indexPath;

@end



@interface findDetailViewController : UIViewController

@property(nonatomic, retain)findModel *findM;


@property (nonatomic, assign) NSInteger index;       // ?
@property (nonatomic, retain) NSIndexPath *indexPath;    // ?

@property (nonatomic, assign) id<GMYReadingDetailViewControllerDelegate>newsDetailDelegate;



@end
