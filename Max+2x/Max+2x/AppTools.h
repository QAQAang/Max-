//
//  AppTools.m
//  LSK
//
//  Created by 少凯 on 15/12/21.
//  Copyright © 2015年 李少凯 All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AppToolsBlock)(id) ;
typedef void(^AppToolsErrorBlock)(NSError *error);


@interface AppTools : NSObject

+ (void)getDataWithAFNUrl:(NSString *)urlStr block:(AppToolsBlock)block errorBlock:(AppToolsErrorBlock)errorBlock;

+ (NSString *)createFilePathFromDocumentWithFolders:(NSArray<NSString *> *)folders fileName:(NSString *)fileName;

+ (BOOL)saveDataOnLocal:(NSData *)data localPath:(NSString *)path;


@end
