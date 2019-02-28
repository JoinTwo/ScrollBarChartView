//
//  ScrollBarChartView.h
//  ScrollBarChartDemo
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 123. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ScrollBarChartView;

@protocol ScrollBarChartViewDelegate <NSObject>

-(void)loadMoreData:(ScrollBarChartView *)view;

@end

@interface ScrollBarChartView : UIView

/**
 * 是否显示加载更多菊花
 */
@property (nonatomic,assign) BOOL showLodingMore;

/**
 * 正在加载更多
 */
@property (nonatomic,assign) BOOL loadingMore;

/**
 * 完成加载所有数据
 */
@property (nonatomic,assign) BOOL loadingAllData;


/**
 * 数据源数组
 */
@property (nonatomic,strong) NSMutableArray *dataArray;

/**
 * 代理
 */
@property (nonatomic,weak) id<ScrollBarChartViewDelegate>delegate;

/**
 * 刷新数据
 */
-(void)reloadData;

/**
 * 隐藏加载更多菊花
 */
-(void)cancelFootIndicatorView;

@end
