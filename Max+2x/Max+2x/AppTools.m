//
//  AppTools.m
//  LSK
//
//  Created by 少凯 on 15/12/21.
//  Copyright © 2015年 李少凯 All rights reserved.
//

#import "AppTools.h"
#import "AFNetworking.h"
@implementation AppTools

+ (void)getDataWithAFNUrl:(NSString *)urlStr block:(AppToolsBlock)block errorBlock:(AppToolsErrorBlock)errorBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"使用AFN进行get请求 ===  %@",responseObject);
        // 回调
        block(responseObject);
        
        NSString *path = [NSString stringWithFormat:@"%ld.plist", [urlStr hash]];
        // 存储的沙盒路径
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // 归档
        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"失败==== %@",error);
        
        // 失败时回调
        errorBlock(error);
        
        // 缓存的文件夹
        NSString *path = [NSString stringWithFormat:@"%ld.plist", [urlStr hash]];
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
        block(result);
    }];
}

+ (NSString *)createFilePathFromDocumentWithFolders:(NSArray<NSString *> *)folders fileName:(NSString *)fileName{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [NSString stringWithFormat:@"%@", document];
    for (NSString *folder in folders) {
        filePath = [filePath stringByAppendingPathComponent:folder];
        
    }
    [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    filePath = [filePath stringByAppendingPathComponent:fileName];
    return filePath;
}

+ (BOOL)saveDataOnLocal:(NSData *)data localPath:(NSString *)path{
    return [data writeToFile:path atomically:YES];
}


@end
