//
//  RadarVC.m
//  Max+2x
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "RadarVC.h"

@implementation RadarVC

- (void)viewDidLoad{
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 162)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.lolmax.com/api/player/power_value_web/?area_id=%@&uid=%@&pkey=MTQ1ODg3NzY0Mi42MTU5NDE4OTg4ODBfMXV6Z3drb251dW1pcHJtc3M__&phone_num=15941898880&imei=355021060246177&os_type=Android&os_version=5.0&version=3.2.0", self.areaId, [self.name stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]]]]]];
    [self.view addSubview:webView];
}

@end
