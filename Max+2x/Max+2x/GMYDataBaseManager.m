//
//  GMYDataBaseManager.m
//  AttitudeNews_GMY
//
//  Created by 谷萌雨 on 16/3/10.
//  Copyright © 2016年 谷萌雨. All rights reserved.
//

#import "GMYDataBaseManager.h"



#import "FMDatabase.h"
#import "FMDatabaseQueue.h"


@interface GMYDataBaseManager ()
// 定义一个数据库对象
@property (nonatomic, retain) FMDatabase *fmdb;
@property (nonatomic, copy) NSString *filePath;

@end

@implementation GMYDataBaseManager


// 创建数据库单例
+ (instancetype)shareDataBaseManager{
    
    static GMYDataBaseManager *dataBaseManager = nil;
    if (!dataBaseManager) {
        dataBaseManager = [[GMYDataBaseManager alloc] init];
    }
    return dataBaseManager;
    
}

- (void)openDataBase{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    self.filePath = [documentPath stringByAppendingPathComponent:@"LQNNews.sqlite"];
//    NSLog(@"self.filePath == %@", self.filePath);
    
    // 创建数据库对象
    self.fmdb = [[FMDatabase alloc] initWithPath:self.filePath];
    
    // 打开数据库
    BOOL result = [self.fmdb open];
    if (result) {
//        NSLog(@"打开成功");
    }else{
//        NSLog(@"打开失败");
    }
}

// 将执行的sql语句封装起来
- (void)executeSqlWithString:(NSString *)sql showLog:(NSString *)message{
    
    BOOL result = [self.fmdb executeUpdate:sql];
    NSString *string = @"";
    if (result) {
        string = [NSString stringWithFormat:@"%@ 成功", message];
    }else{
        string = [NSString stringWithFormat:@"%@ 失败", message];
        
    }
//    NSLog(@"result === %@", string);
    
}

// 创建news表
- (void)createNewsModelTable{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS newsModelTable(num INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, docid TEXT)";
    [self executeSqlWithString:sql showLog:@"创建newsModel表"];
    
}

// 创建视频表
- (void)createVideoModelTable{
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS videoModelTable(num INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, mp4_url TEXT, replyid, TEXT)";
    [self executeSqlWithString:sql showLog:@"创建video表成功"];
    
}


// 插入新闻数据
- (void)insertNewsModel:(findModel *)newsModel{
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO newsModelTable(title, docid) VALUES ('%@', '%@')", newsModel.title, newsModel.webUrl];
    
    [self executeSqlWithString:sql showLog:@"插入新闻"];
}

//// 插入视频数据
//- (void)insertVideoModel:(LQNVideoModel *)videoModel{
//    NSString *sql = [NSString stringWithFormat:@"INSERT INTO videoModelTable(title, mp4_url, replyid) VALUES ('%@', '%@', '%@')", videoModel.title, videoModel.mp4_url, videoModel.replyid];
//    
//    [self executeSqlWithString:sql showLog:@"插入视频"];
//    
//}

// 删除新闻
- (void)deleteNewsModelFromTable:(NSString *)title{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM newsModelTable WHERE title = '%@'", title];
    [self executeSqlWithString:sql showLog:@"删除新闻"];
    
}

// 删除视频

- (void)deleteVideoModelFromTable:(NSString *)title{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM videoModelTable WHERE title = '%@'", title];
    [self executeSqlWithString:sql showLog:@"删除视频"];
}

// 查询指定条件
- (NSMutableArray *)selectNewsModel:(NSString *)title{
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM newsModelTable WHERE title = '%@'", title];
    // 执行查询语句
    // FMResultSet 实例是用来遍历表中符合要求的每一行
    FMResultSet *resultSet = [[FMResultSet alloc] init];
    resultSet = [self.fmdb executeQuery:sql];
    
    while ([resultSet next]) {
        // 取出表中字段为title的值
        NSString *title = [resultSet stringForColumn:@"title"];
//        NSLog(@"title====%@", title);
        [array addObject:title];
    }
    return array;
}


// 根据视频名查询视频
- (NSMutableArray *)selectTitleFromVideoTable:(NSString *)title{
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM videoModelTable WHERE title = '%@'", title];
    
    FMResultSet *resultSet = [[FMResultSet alloc] init];
    resultSet = [self.fmdb executeQuery:sql];
    while ([resultSet next]) {
        NSString *title = [resultSet stringForColumn:@"title"];
        [array addObject:title];
    }
    return array;
}


// 查询所有新闻
- (NSMutableArray *)selectAllNewsModel{
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM newsModelTable"];
    FMResultSet *resultSet = [[FMResultSet alloc] init];
    resultSet = [self.fmdb executeQuery:sql];
    
    while ([resultSet next]) {
        
        NSString *title = [resultSet stringForColumn:@"title"];
        NSString *webUrl = [resultSet stringForColumn:@"webUrl"];
        findModel *findMod = [[findModel alloc] init];
        findMod.title = title;
        findMod.webUrl = webUrl;
        
        [array addObject:findMod];
    }
    return array;
}


//// 查询所有视频
//- (NSMutableArray *)selectAllVideo{
//    NSMutableArray *array = [NSMutableArray array];
//    
//    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM videoModelTable"];
//    FMResultSet *resultSet = [[FMResultSet alloc] init];
//    resultSet = [self.fmdb executeQuery:sql];
//    
//    while ([resultSet next]) {
//        NSString *title = [resultSet stringForColumn:@"title"];
//        NSString *mp4_url = [resultSet stringForColumn:@"mp4_url"];
//        NSString *replyid = [resultSet stringForColumn:@"replyid"];
//        LQNVideoModel *videoModel = [[LQNVideoModel alloc] init];
//        videoModel.title = title;
//        videoModel.mp4_url = mp4_url;
//        videoModel.replyid = replyid;
//        [array addObject:videoModel];
//    }
//    return array;
//}


// 删除表
- (void)dropTable{
    NSString *sql = @"DROP TABLE newsModelTable";
    [self executeSqlWithString:sql showLog:@"删除新闻表"];
}


// 删除视频表
- (void)dropVideoTable{
    NSString *sql = @"DROP TABLE videoModelTable";
    [self executeSqlWithString:sql showLog:@"删除视频表"];
}




@end
