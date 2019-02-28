//
//  ScrollBarChartViewCell.h
//  ScrollBarChartDemo
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollBarChartViewModel.h"

@interface ScrollBarChartViewCell : UITableViewCell

@property (nonatomic,copy) NSString *maxValue;

@property (nonatomic,strong) ScrollBarChartViewModel *model;

+(instancetype)cellViewWithTableView:(UITableView *)tableView;

@end
