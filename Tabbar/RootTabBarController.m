//
//  RootTabBarController.m
//  Tabbar
//
//  Created by Holly on 2017/8/17.
//  Copyright © 2017年 Holly. All rights reserved.
//

#import "RootTabBarController.h"
#import "CCTabbarBackView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "fiveViewController.h"

@interface RootTabBarController ()
@property (nonatomic, assign) CGFloat myHeight;
@property (nonatomic, strong) NSMutableArray <UIView *> *viewArray;

@end

@implementation RootTabBarController

+(void)load{
    
    NSArray *array = [NSArray arrayWithObjects:[self class], nil];
    UITabBarItem *item=[UITabBarItem appearanceWhenContainedInInstancesOfClasses:array];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[self convertColorWithString:@"d5ac6c"],NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myHeight = 70;
    _viewArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self clearTabBarTopLine];
    CCTabbarBackView *bgV =[[CCTabbarBackView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, _myHeight)];
    bgV.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:bgV];
    [self creatSubViewCtrs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clearTabBarTopLine{
    CGRect rect = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef  clearColor =[[UIColor clearColor] CGColor];
    CGContextSetFillColor(context, CGColorGetComponents(clearColor));
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.tabBar.backgroundImage = img;
    self.tabBar.shadowImage = img;
}
-(void)viewWillLayoutSubviews{
    CGRect frame = self.tabBar.frame;
    frame.size.height = _myHeight;
    frame.origin.y = self.view.frame.size.height - _myHeight;
    self.tabBar.frame = frame;
    self.tabBar.barStyle = UIBarStyleDefault;
    for (int i=0; i<self.tabBar.items.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        if (i!=2) {
            item.imageInsets = UIEdgeInsetsMake(_myHeight-50-10, 0, -(_myHeight - 50 - 10), 0);
            item.titlePositionAdjustment = UIOffsetMake(0, -3);

        }else{
            item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            item.titlePositionAdjustment = UIOffsetMake(0, -3);

        }
    }
}
-(void)creatSubViewCtrs{
    
    [self setTabBarChildViewControllersWithController:[OneViewController new] Title:@"首页" imgName:@"home"];
    
    [self setTabBarChildViewControllersWithController:[TwoViewController new] Title:@"一" imgName:@"discount"];
    [self setTabBarChildViewControllersWithController:[ThreeViewController new] Title:@"二" imgName:@"diamond"];

    [self setTabBarChildViewControllersWithController:[FourViewController new] Title:@"三" imgName:@"com"];
    
    [self setTabBarChildViewControllersWithController:[fiveViewController new] Title:@"我的" imgName:@"user"];
}

- (void)setTabBarChildViewControllersWithController:(UIViewController *)controlller Title:(NSString *)title imgName:(NSString *)imgName
{
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:controlller];
    controlller.title = title;
    
    controlller.tabBarItem.image = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //保持图片不被渲染
    NSString *selectImgName = [NSString stringWithFormat:@"%@_s",imgName];
    controlller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:nvc];
}

+ (UIColor *)convertColorWithString:(NSString *)hexColor
{
    NSMutableString *color = [NSMutableString stringWithString:[NSString stringWithFormat:@"0x%@",hexColor]];
    // 十六进制字符串转成整形。
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B =  colorLong & 0x0000FF;
    
    //string转color
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
}

@end
