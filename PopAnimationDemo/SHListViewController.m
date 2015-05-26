//
//  SHListViewController.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/13.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHListViewController.h"
#import "SHListTableViewCell.h"
#import "SHButtonViewController.h"
#import "SHDecayViewController.h"
#import "SHCircleViewController.h"
#import "SHImageViewController.h"
#import "SHFoldingViewController.h"
#import <POP.h>
static NSString * const cellID   = @"cellID";

@interface SHListViewController ()

@property (nonatomic, strong) NSArray *items;
@end

@implementation SHListViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"PopAnimationList";
    
    [self configureTableView];
    [self configureTitleView];
}



#pragma mark - delegate & datesource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text       = [self.items[indexPath.row] firstObject];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *vc              = [self viewControllerForRowAtIndexPath:indexPath];
    vc.title                          = [self titleForRowAtIndexPath:indexPath];    
    CALayer *layer                    = vc.view.layer;
    [layer removeAllAnimations];
    POPSpringAnimation *xAnimaiton    = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    POPSpringAnimation *sizeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    xAnimaiton.fromValue              = @([UIScreen mainScreen].bounds.size.width);
    xAnimaiton.springBounciness       = 16;
    xAnimaiton.springSpeed            = 12;
    
    sizeAnimation.fromValue           = [NSValue valueWithCGSize:CGSizeMake(64, 114)];
    
    [layer pop_addAnimation:xAnimaiton forKey:@"position"];
    [layer pop_addAnimation:sizeAnimation forKey:@"size"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
#pragma mark - 事件相应

#pragma mark - 私有方法

/**
 *  配置tableView
 */
- (void)configureTableView
{
    [self.tableView registerClass:[SHListTableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight      = 50.f;
    
    
}

/**
 *  配置titleView
 */
- (void)configureTitleView
{
    UILabel *headlinelabel      = [[UILabel alloc] init];
    headlinelabel.font          = [UIFont fontWithName:@"Avenir-Light" size:28];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor colorWithRed:0/255.f green:73/255.0f blue:131/255.0f alpha:1.f];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:170/255.f green:70/255.0f blue:48/255.0f alpha:1.f] range:NSMakeRange(3, 9)];
    headlinelabel.attributedText = attributedString;
    [headlinelabel sizeToFit];
    [self.navigationItem setTitleView:headlinelabel];
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items[indexPath.row] firstObject];
}

- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self.items[indexPath.row] lastObject] new];
}
#pragma mark - getters & setters

- (NSArray *)items
{
    if (!_items) {
        _items = @[@[@"按钮动画效果",[SHButtonViewController class]],
                   @[@"物理衰减效果",[SHDecayViewController class]],
                   @[@"绘制圆形",[SHCircleViewController class]],
                   @[@"图片浏览",[SHImageViewController class]],
                   @[@"牛逼的折叠效果",[SHFoldingViewController class]]
                   ];
    }
    return _items;
}
@end
