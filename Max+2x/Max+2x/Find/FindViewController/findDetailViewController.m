//
//  findDetailViewController.m
//  Max+2x
//
//  Created by 谷萌雨 on 16/3/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "findDetailViewController.h"
#import "UMSocial.h"
#import "GMYDataBaseManager.h"

@interface findDetailViewController ()<UMSocialDataDelegate, UMSocialUIDelegate>
@property(nonatomic, retain)UIView *titleView;
@property(nonatomic, retain)UIButton *buttonShare;

@end

@implementation findDetailViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    NSMutableArray *array = [[GMYDataBaseManager shareDataBaseManager] selectNewsModel:self.findM.title];
    
    if ([array containsObject:self.findM.title]) {
        UIImage *image = [UIImage imageNamed:@"iconfont-htmal5icon24"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationItem.rightBarButtonItem setImage:image];
        
    }else{
        UIImage *image = [UIImage imageNamed:@"iconfont-unie637"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationItem.rightBarButtonItem setImage:image];
        
    }
    
    
    
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
//    self.titleView.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.titleView = self.titleView;
    
    
    // 设置导航栏左侧按钮
    UIImage *imageBack = [UIImage imageNamed:@"iconfont-fanhui"];
    imageBack = [imageBack imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:imageBack style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    
    // 设置右侧收藏的基本按钮
    // 设置导航栏右侧按钮
    UIImage *imageCollect = [UIImage imageNamed:@"iconfont-unie637"];
    // 取消图片渲染
    imageCollect = [imageCollect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:imageCollect style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction:)];
    
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 30)];
    titleLabel.text = @"Max+新闻";
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [self.titleView addSubview:titleLabel];
    
    self.buttonShare = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonShare.frame = CGRectMake(220, 0, 30, 30);
//    self.buttonShare.backgroundColor = [UIColor purpleColor];
    [self.buttonShare addTarget:self action:@selector(buttonShare:) forControlEvents:UIControlEventTouchUpInside];

    [self.buttonShare setBackgroundImage:[UIImage imageNamed:@"iconfont-fenxiang (1)"]forState:UIControlStateNormal];    //设置button背景显示图片
    
    [self.titleView addSubview:self.buttonShare];
    
    [self createWebView];
    
    

    
}

- (void)createWebView{
    
    NSString *string = self.findM.webUrl;
    //    NSLog(@"=== %@", self.findM.webUrl);
    NSURL *url = [[NSURL alloc]initWithString:string];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height)];
    webview.tag = 1001;
    [webview loadRequest:request];
    [self.view addSubview:webview];
    
}

- (void)buttonShare:(UIButton *)btn{
    
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56fa2b4367e58eb1870001e2"
                                      shareText:[NSString stringWithFormat:@"%@  %@      From Max+", self.findM.title, self.findM.webUrl]
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToRenren,UMShareToDouban,UMShareToTencent,nil]
                                       delegate:self];

    
    
}

-(void)leftButtonAction:(UIBarButtonItem *)barBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)rightButtonAction:(UIBarButtonItem *)barBtn2{
    
    
    // 查询数组 (标题是否被收藏过)
    NSMutableArray *array = [NSMutableArray array];
    array = [[GMYDataBaseManager shareDataBaseManager] selectNewsModel:self.findM.title];
    //    for (NSString *title in array) {
    //        NSLog(@"title----%@", title);
    //    }
    
    if (array.count == 0) {// 如果数组的个数为0 ,则说明没有被收藏过
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:^{
            
            
        }];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 将model插入到数据库中
            [[GMYDataBaseManager shareDataBaseManager] insertNewsModel:self.findM];
            
            UIImage *image = [UIImage imageNamed:@"iconfont-htmal5icon24"];
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [self.navigationItem.rightBarButtonItem setImage:image];
            
            
        }];
        [alertC addAction:action];
        
    }else{// 如果数组个数不为0 ,则提示已收藏过
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏已取消" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:^{
            
            
        }];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[GMYDataBaseManager shareDataBaseManager] deleteNewsModelFromTable:self.findM.title];
            UIImage *image = [UIImage imageNamed:@"iconfont-unie637"];
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [self.navigationItem.rightBarButtonItem setImage:image];
            [self.newsDetailDelegate deleteFromCollection:self.indexPath];
            
            
            
        }];
        
        [alertC addAction:action];
    }

    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
