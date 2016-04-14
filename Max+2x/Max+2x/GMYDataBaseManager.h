//
//  GMYDataBaseManager.h
//  AttitudeNews_GMY
//
//  Created by 谷萌雨 on 16/3/10.
//  Copyright © 2016年 谷萌雨. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "findModel.h"
//#import "LQNVideoModel.h"


@interface GMYDataBaseManager : NSObject




+ (instancetype)shareDataBaseManager;

// 打开数据库
- (void)openDataBase;


// 创建news表
- (void)createNewsModelTable;

// 创建视频表
- (void)createVideoModelTable;


// 插入新闻数据
- (void)insertNewsModel:(findModel *)newsModel;

// 根据视频名查询视频
- (NSMutableArray *)selectTitleFromVideoTable:(NSString *)title;

// 删除新闻
- (void)deleteNewsModelFromTable:(NSString *)title;

// 删除视频

- (void)deleteVideoModelFromTable:(NSString *)title;

// 根据新闻名字查询
- (NSMutableArray *)selectNewsModel:(NSString *)title;

// 查询所有新闻
- (NSMutableArray *)selectAllNewsModel;

// 查询所有视频
//- (NSMutableArray *)selectAllVideo;


// 删除表
- (void)dropTable;

// 删除视频表
- (void)dropVideoTable;







@end
