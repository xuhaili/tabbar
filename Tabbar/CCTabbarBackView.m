//
//  CCTabbarBackView.m
//  Tabbar
//
//  Created by Holly on 2017/8/17.
//  Copyright © 2017年 Holly. All rights reserved.
//

#import "CCTabbarBackView.h"


@interface CCTabbarBackView()

@end

@implementation CCTabbarBackView

-(void)drawRect:(CGRect)rect{
    CGFloat lineY = 0;
    CGFloat radiu = 0;
    CGFloat lineWidth = 0.5;
    lineY = rect.size.height - lineWidth - 50;
    radiu = (rect.size.height - lineWidth *2)/2.0;
//1.左边线条
    UIColor *coloerOne = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [coloerOne set];
    //圆心到 左右横线的垂直距离
    CGFloat  toTop = radiu - lineY + lineWidth;
     //勾股定理
    CGFloat all = pow(radiu, 2)- pow(toTop, 2);
    //对边长（有两个，所以 * 2）
    CGFloat x2 =sqrt(all)*2;
    //线条宽度（视图宽度减去 圆 所占的 宽度 ，除以2 得到 一边的宽度）
    CGFloat line1W = (rect.size.width - x2)/2.0;
    //圆左边点
    CGPoint leftPoint = CGPointMake(line1W, lineY);
    
    UIBezierPath *leftLinePath = [UIBezierPath bezierPath];
    // 起点
    [leftLinePath moveToPoint:CGPointMake(0, lineY)];
    // 其他点
    [leftLinePath addLineToPoint:leftPoint];
    leftLinePath.lineWidth = lineWidth;
    leftLinePath.lineCapStyle = kCGLineCapRound; //线条拐角
    leftLinePath.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    [leftLinePath stroke];
    
//    右边线条
    UIColor *coloerTwo = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [coloerTwo set];
    CGFloat rX = rect.size.width - line1W;
    UIBezierPath *rightLinePath = [UIBezierPath bezierPath];
    //圆右边点
    CGPoint rightPoint = CGPointMake(rX, lineY);
    [rightLinePath moveToPoint:rightPoint];
    // 其他点
    [rightLinePath addLineToPoint:CGPointMake(rect.size.width, lineY)];
    rightLinePath.lineWidth = lineWidth;
    rightLinePath.lineCapStyle = kCGLineCapRound; //线条拐角
    rightLinePath.lineJoinStyle = kCGLineJoinRound; //终点处理
    [rightLinePath stroke];
    
//    弧线
    UIColor *coloerThree = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [coloerThree set];
    CGFloat yyy2 = acos(toTop / radiu);
    CGPoint centerPoint = CGPointMake( rect.size.width / 2, rect.size.height / 2);
    UIBezierPath *roundLinePath = [UIBezierPath bezierPath];
//    clockwise:是否顺时针绘圆
    [roundLinePath addArcWithCenter:centerPoint radius:radiu startAngle:-yyy2 - M_PI_2 endAngle:yyy2 - M_PI_2 clockwise:true];
    roundLinePath.lineWidth = lineWidth;
    roundLinePath.lineCapStyle = kCGLineCapRound; //线条拐角
    roundLinePath.lineJoinStyle = kCGLineJoinRound; //终点处理
    [roundLinePath stroke];
    
//   镂空，去除上边白色部分
    //获取直线下面矩形范围路径
    UIBezierPath *ppp = [UIBezierPath bezierPathWithRect:CGRectMake(0, lineY-lineWidth, rect.size.width, rect.size.height-lineY)];
    //获取圆弧所在圆路径
    [ppp appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake((rect.size.width-rect.size.height)/2, 0, rect.size.height, rect.size.height) cornerRadius:radiu]];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = ppp.CGPath;
    self.layer.mask = shapeLayer;
    
}
@end
