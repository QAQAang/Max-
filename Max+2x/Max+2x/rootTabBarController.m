//
//  rootTabBarController.m
//  Max_2x_kj
//
//  Created by dllo on 16/3/24.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "rootTabBarController.h"
#import "findViewController.h"
#import "mineViewController.h"
@interface rootTabBarController ()

@end

@implementation rootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    mineViewController *mine = [[mineViewController alloc] init];
    mine.title = @"我";
    mine.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *navMine = [[UINavigationController alloc] initWithRootViewController:mine];
    mine.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
    mine.navigationController.navigationBar.titleTextAttributes = dict;
    findViewController *find = [[findViewController alloc] init];
    find.title = @"发现";
    find.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *navFind = [[UINavigationController alloc] initWithRootViewController:find];
    find.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45 / 255.0 green:56 / 255.0 blue:65 / 255.0 alpha:1.000];
    find.navigationController.navigationBar.titleTextAttributes = dict;
    [self addChildViewController:navMine];
    [self addChildViewController:navFind];
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
