//
//  AnanlysisViewController.m
//  MiWiFi
//
//  Created by Huang Zhe on 14-12-29.
//  Copyright (c) 2014年 Huang Zhe. All rights reserved.
//

#import "AnanlysisViewController.h"

@interface AnanlysisViewController ()

@end

@implementation AnanlysisViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self showBarLine];
    
    [self showCircle];
   
}


-(void)showBarLine{
    
    
    UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 30)];
    barChartLabel.text = @"关键词统计";
    barChartLabel.textColor = PNFreshGreen;
    barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    barChartLabel.textAlignment = NSTextAlignmentCenter;
    
    //PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH-70, 200.0)];
    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 110.0, SCREEN_WIDTH, 200.0)];
    barChart.backgroundColor = [UIColor clearColor];
    barChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    barChart.labelMarginTop = 5.0;
    [barChart setXLabels:@[@"星冰乐",@"团购",@"牛腩",@"牛排",@"三杯鸡",@"蔓越莓",@"抽奖"]];
    [barChart setYValues:@[@10,@24,@12,@18,@30,@10,@21]];
    [barChart setStrokeColors:@[PNRed,PNGreen,PNYellow,PNGreen,PNGreen,PNRed,PNGreen]];
    // Adding gradient
    
    
    [barChart strokeChart];
    
    barChart.delegate = self;
    
    [self.view addSubview:barChartLabel];
    [self.view addSubview:barChart];
    
    
    
}


-(void)showCircle{
    
    UILabel * pieChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 340, SCREEN_WIDTH, 30)];
    pieChartLabel.text = @"访客应用";
    pieChartLabel.textColor = PNFreshGreen;
    pieChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    pieChartLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNLightGreen  description:@"美团"],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNFreshGreen description:@"微博"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNDeepGreen description:@"微信"],
                       ];
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(70.0, 400.0, 240.0, 240.0) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    pieChart.descriptionTextShadowColor = [UIColor clearColor];
    [pieChart strokeChart];
    [self.view addSubview:pieChartLabel];
    [self.view addSubview:pieChart];
    
}



@end
