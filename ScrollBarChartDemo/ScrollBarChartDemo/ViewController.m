//
//  ViewController.m
//  ScrollBarChartDemo
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 123. All rights reserved.
//

#import "ViewController.h"
#import "ScrollBarChartView.h"
#import "Masonry.h"
#import "ScrollBarChartViewModel.h"

@interface ViewController ()<ScrollBarChartViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ScrollBarChartView *chatView = [[ScrollBarChartView alloc] init];
    chatView.showLodingMore = YES;
    chatView.delegate = self;
    [self.view addSubview:chatView];
    [chatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(60);
        make.height.offset(200);
    }];
}

-(void)loadMoreData:(ScrollBarChartView *)view{
    view.loadingMore = YES;
    for (int j = 0; j < 10; j++) {
        ScrollBarChartViewModel *model = [ScrollBarChartViewModel new];
        model.xValue = [NSString stringWithFormat:@"%d月",j];
        model.yValue = [NSString stringWithFormat:@"%d",j * 100];
        [view.dataArray addObject:model];
        [view reloadData];
        view.loadingMore = NO;
    }
}


@end
