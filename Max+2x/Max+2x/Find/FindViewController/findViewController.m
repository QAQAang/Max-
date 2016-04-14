//
//  findViewController.m
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "findViewController.h"
#import "AppTools.h"
#import "findModel.h"
#import "findTableViewCell.h"
#import "findDetailViewController.h"
#import "CollectViewController.h"


@interface findViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)UITableView *findTableView;
@property(nonatomic, retain)NSMutableArray *arrayFind;

@end

@implementation findViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"发现";
    
    
    // 设置导航栏右侧按钮
    UIImage *imageCollect = [UIImage imageNamed:@"iconfont-liebiao"];
    // 取消图片渲染
    imageCollect = [imageCollect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:imageCollect style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction:)];
    
    
    
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:8 / 255.0 blue:18 / 255.0 alpha:1.000];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.arrayFind = [NSMutableArray array];
    
    [self createTableView];
    
    [self getDataSource];

    
    
}

- (void)createTableView{
    
    self.findTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.findTableView];
    
    self.findTableView.delegate = self;
    self.findTableView.dataSource = self;
    
    [self.findTableView registerClass:[findTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.findTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayFind.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    findTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.findM = [self.arrayFind objectAtIndex:indexPath.row];
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)getDataSource{
    
    NSString *url = [NSString stringWithFormat:@"http://news.maxjia.com/maxnews/app/list/?lang=zh-cn&phone_num=00000000000&pkey=randpkey&os_type=iOS&os_version=9.2.1&_time=1458820057&version=3.3.1&device_id=1B071974-EC35-4805-9B39-A8F5349D8112&game_type=lol&game_type=lol&limit=30&offset=0"];
    
    [AppTools getDataWithAFNUrl:url block:^(id result) {
        
        NSArray *arr = result[@"result"];
        for (NSDictionary *dic in arr) {
            findModel *findM = [[findModel alloc] init];
            [findM setValuesForKeysWithDictionary:dic];
            [self.arrayFind addObject:findM];
        }
        
        [self.findTableView reloadData];
    } errorBlock:^(NSError *error) {
        
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    findDetailViewController *findVC = [[findDetailViewController alloc] init];
    
    [self.navigationController pushViewController:findVC animated:YES];
    
    findVC.findM = [self.arrayFind objectAtIndex:indexPath.row];
    
    
    
}

-(void)rightButtonAction:(UIBarButtonItem *)barBtn2{
    
    
    CollectViewController *collectVC = [[CollectViewController alloc] init];
    [self.navigationController pushViewController:collectVC animated:YES];

    
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
