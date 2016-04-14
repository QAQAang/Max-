//
//  GamerMainPageVC.m
//  Max+2x
//
//  Created by dllo on 16/3/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "GamerMainPageVC.h"
#import "menuView.h"
#import <UIImageView+WebCache.h>
#import "StatisticsVC.h"
#import "RadarVC.h"
#import "MaxRecordVC.h"
#import <objc/runtime.h>
#import "TeamMateVC.h"
@interface GamerMainPageVC ()<UIScrollViewDelegate, MenuViewDelegate>

@property (nonatomic, retain) UILabel *gamerName;

@property (nonatomic, retain) UIImageView *gamerHead;

@property (nonatomic, retain) menuView *menu;

@property (nonatomic, retain) UIScrollView *contentScroll;

@property (nonatomic, retain) UIView *contentView;

@end

@implementation GamerMainPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addchildVC];
    [self creatScroll];
    [self creatNavgationbar];
    [self creatTaskData];
}

- (void)creatScroll{
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 124, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 162)];
    self.contentScroll.pagingEnabled = YES;
    self.contentScroll.delegate = self;
    self.contentScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height - 162);
    self.contentScroll.contentOffset = CGPointMake(0, 0);
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        view.backgroundColor = [UIColor greenColor];
        [view addSubview:[self.childViewControllers[i] valueForKey:@"view"]];
        [self.contentScroll addSubview:view];
    }
    [self.contentView addSubview:self.contentScroll];
    [self.view addSubview:self.contentView];
}

- (void)addchildVC{
    StatisticsVC *statistics = [[StatisticsVC alloc] init];
    statistics.name = self.name;
    statistics.areaId = self.areaId;
    [self addChildViewController:statistics];
    RadarVC *radar = [[RadarVC alloc] init];
    radar.name = self.name;
    radar.areaId = self.areaId;
    [self addChildViewController:radar];
    MaxRecordVC *maxRecord = [[MaxRecordVC alloc] init];
    maxRecord.name = self.name;
    maxRecord.areaId = self.areaId;
    [self addChildViewController:maxRecord];
    TeamMateVC *teamMate = [[TeamMateVC alloc] init];
    teamMate.name = self.name;
    teamMate.areaId = self.areaId;
    [self addChildViewController:teamMate];
}

- (void)creatTaskData{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.lolmax.com/api/player/info/?area_id=%@&uid=%@&pkey=MTQ1ODg3NzY0Mi42MTU5NDE4OTg4ODBfMXV6Z3drb251dW1pcHJtc3M__&phone_num=15941898880&game_type=lol&imei=355021060246177&os_type=Android&os_version=5.0&version=3.2.0", self.areaId, [self.name stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSMutableDictionary *dic = [@{@"Referer":@"http://api.maxjia.com/", @"User-Agent":@"Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 ApiMaxJia/1.0", @"Host":@"api.lolmax.com", @"Connection":@"Keep-Alive", @"Accept-Encoding":@"gzip"} mutableCopy];
    [request setAllHTTPHeaderFields:dic];
    request.HTTPMethod = @"GET";
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *dic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:&error] valueForKey:@"result"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.gamerHead sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"image_url"]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
            self.gamerName.text = [dic valueForKey:@"name"];
        });
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

- (void)creatNavgationbar{
    UIImage *orImage = [UIImage imageNamed:@"iconfont-jzuojiantou"];
    orImage = [self imageWithImageSimple:orImage scaledToSize:CGSizeMake(30, 30)];
    [orImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
    buton.frame = CGRectMake(0, 0, 50, 50);
    [buton setImage:orImage forState:UIControlStateNormal];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:orImage style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    leftBar.tintColor = [UIColor colorWithRed:235 green:240 blue:241 alpha:1];
    self.navigationItem.leftBarButtonItem = leftBar;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75, 60)];
    self.gamerHead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    self.gamerHead.layer.cornerRadius = 30;
    self.gamerHead.clipsToBounds = YES;
    [view addSubview:self.gamerHead];
    self.gamerName = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 75, 20)];
    self.gamerName.textColor = [UIColor whiteColor];
    self.gamerName.textAlignment = 1;
    self.gamerName.font = [UIFont systemFontOfSize:15];
    [view addSubview:self.gamerName];
    self.navigationItem.titleView = view;
    self.menu = [[menuView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30) menuArr:[@[@"综合统计", @"雷达图", @"最高记录", @"队友对手"] mutableCopy]];
    self.menu.delegate = self;
    [self.contentView addSubview:self.menu];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [self.menu receiveOffset:self.contentScroll.contentOffset.x];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.contentScroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGRect rect = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x, rect.origin.y, [UIScreen mainScreen].bounds.size.width, 104);
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment: - 40.0 forBarMetrics: UIBarMetricsDefault];
    [self.navigationItem.leftBarButtonItem setBackgroundVerticalPositionAdjustment: - 40.0 forBarMetrics: UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.contentScroll removeObserver:self forKeyPath:@"contentOffset"];
    CGRect rect = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x, rect.origin.y, [UIScreen mainScreen].bounds.size.width, 44);
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment: 0.0 forBarMetrics:UIBarMetricsDefault];
}

- (void)clickItemChangeOffset:(NSInteger)count{
    [self.contentScroll setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * count, 0) animated:NO];
}

- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
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
