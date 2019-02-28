//
//  ScrollBarChartView.m
//  ScrollBarChartDemo
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 123. All rights reserved.
//

#import "ScrollBarChartView.h"
#import "Masonry.h"
#import "UIView+Frame.h"
#import "ScrollBarChartViewCell.h"


#define kScreenBounds         [UIScreen mainScreen].bounds
#define kScreenSize           [[UIScreen mainScreen] bounds].size
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

@interface ScrollBarChartView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) UIView *activityIndicatorView;

@end

@implementation ScrollBarChartView

-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIView *headerView = [UIView new];
    headerView.height = 8;
    self.tableView.tableHeaderView = headerView;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(200);
        make.height.offset(kScreenWidth - 30);
        make.centerX.equalTo(self.mas_centerX).offset(30);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    self.tableView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
    UIView *yLine = [UIView new];
    //y轴的颜色,这里clearColor就看不见了
    yLine.backgroundColor = [UIColor clearColor];
    [self addSubview:yLine];
    [yLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(0.5);
        make.top.bottom.equalTo(self).offset(29);
        make.left.equalTo(self.mas_left).offset(47);
        make.bottom.equalTo(self.mas_bottom).offset(-29);
    }];
    
    for (int i = 0; i<6; i++) {
        UILabel *zeroLabel = [UILabel new];
        NSInteger value = 130 * i;
        zeroLabel.text = [NSString stringWithFormat:@"%ld",(long)value];
        zeroLabel.font = [UIFont systemFontOfSize:12];
        zeroLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:zeroLabel];
        [zeroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(yLine.mas_left).offset(-5);
            make.bottom.equalTo(self.mas_bottom).offset(-25 - i*(170/6));
        }];
    }
}

-(void)setShowLodingMore:(BOOL)showLodingMore{
    _showLodingMore = showLodingMore;
    if (showLodingMore) {
        [self setFootIndicatorView];
    }
}

#pragma mark - 监听scrollView的滑动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!self.showLodingMore) {
        return;
    }
    if(!_loadingMore && !_loadingAllData &&scrollView.contentOffset.y >= ((scrollView.contentSize.height - (kScreenWidth - 30)))){
        NSLog(@"开始加载");
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadMoreData:)]) {
            [self.delegate loadMoreData:self];
        }
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScrollBarChartViewCell *cell = [ScrollBarChartViewCell cellViewWithTableView:tableView];
    cell.maxValue = @"2000";
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 1; i < 10; i++) {
            
            ScrollBarChartViewModel *model = [ScrollBarChartViewModel new];
            model.xValue = [NSString stringWithFormat:@"%d日",i];
            model.yValue = [NSString stringWithFormat:@"%d",i * 10];
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

-(UIActivityIndicatorView *)activityIndicator{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _activityIndicator.frame = CGRectMake(10, 0, 20, 20);
        //设置小菊花颜色
        _activityIndicator.color = [UIColor blackColor];
        //设置背景颜色
        _activityIndicator.backgroundColor = [UIColor whiteColor];
        [_activityIndicator startAnimating];
    }
    return _activityIndicator;
}


-(void)setFootIndicatorView{
    self.tableView.tableFooterView.height = 30;
    self.tableView.tableFooterView = self.activityIndicatorView;
}

-(void)cancelFootIndicatorView{
    self.tableView.tableFooterView.height = 0;
    self.tableView.tableFooterView = [UIView new];
}

-(void)reloadData{
    [self.tableView reloadData];
}

-(UIView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [UIView new];
        [_activityIndicatorView addSubview:self.activityIndicator];
        [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_activityIndicatorView.mas_top);
            make.centerX.equalTo(_activityIndicatorView.mas_centerX);
            make.width.height.offset(30);
        }];
    }
    return _activityIndicatorView;
}

@end
