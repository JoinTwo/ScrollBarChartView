//
//  ScrollBarChartViewCell.m
//  ScrollBarChartDemo
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 123. All rights reserved.
//

#import "ScrollBarChartViewCell.h"
#import "Masonry.h"

#define HKColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface ScrollBarChartViewCell()
@property (nonatomic,strong) UIView *colorView;
@property (nonatomic,strong) UILabel *yValueLabel;
@property (nonatomic,strong) UILabel *xValueLabel;
@end


@implementation ScrollBarChartViewCell

-(void)setModel:(ScrollBarChartViewModel *)model{
    _model = model;
    self.xValueLabel.text = model.xValue;
    self.yValueLabel.text = model.yValue;
    NSNumber *num = [NSNumber numberWithInteger:[model.yValue integerValue]];
    NSNumber *max = [NSNumber numberWithInteger:[self.maxValue integerValue]];
    CGFloat totalLenght = 200 - 30 - 30;
    
    CGFloat coverWidth = ([num floatValue] / [max floatValue]) * totalLenght;
    
    [self.colorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.width.offset(coverWidth);
    }];
}


+(instancetype)cellViewWithTableView:(UITableView *)tableView{
    
    static NSString *reuseCell = @"ScrollBarChartViewCell";
    ScrollBarChartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    if (cell == nil) {
        cell = [[ScrollBarChartViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCell];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        for (int i = 0; i<6; i++) {
            [path moveToPoint:CGPointMake(200-30 - i*(170/6),0)];
            [path addLineToPoint:CGPointMake(200-30 - i*(170/6),60)];
        }
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor grayColor].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineWidth = 0.2;
        /************虚线********/
        [layer setLineJoin:kCALineJoinRound];
        //线的宽度 每条线的间距
        [layer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],nil]];
        /************虚线********/
        
        [self.layer insertSublayer:layer atIndex:0];
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.colorView = [UIView new];
    self.colorView.backgroundColor = HKColor(195, 76, 124);
    [self.contentView addSubview:self.colorView];
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.left.equalTo(self.contentView.mas_left).offset(30);
    }];
    self.xValueLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.xValueLabel];
    [self.xValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(40);
        make.height.offset(30);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(5);
    }];
    self.xValueLabel.textAlignment = NSTextAlignmentCenter;
    self.xValueLabel.text = @"0/20";
    self.xValueLabel.font = [UIFont systemFontOfSize:12];
    self.xValueLabel.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    
    self.yValueLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.yValueLabel];
    [self.yValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(40);
        make.height.offset(30);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.right.equalTo(self.colorView.mas_left).offset(10);
    }];
    self.yValueLabel.textAlignment = NSTextAlignmentCenter;
    self.yValueLabel.text = @"800";
    self.yValueLabel.font = [UIFont systemFontOfSize:12];
    self.yValueLabel.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    
}


@end
