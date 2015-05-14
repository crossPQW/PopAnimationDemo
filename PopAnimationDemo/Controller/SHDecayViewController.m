//
//  SHDecayViewController.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/13.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//物理衰减动画

#import "SHDecayViewController.h"
#import <POP.h>
@interface SHDecayViewController ()<POPAnimationDelegate>

@property (nonatomic, strong) UIControl *dragView;
@end

@implementation SHDecayViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDragView];
}


#pragma mark - delegate & datesource
- (void)pop_animationDidApply:(POPDecayAnimation *)anim
{
    BOOL isDragViewOutsideOf = !CGRectContainsRect(self.view.frame, self.dragView.frame);
    if (isDragViewOutsideOf) {
        CGPoint currentVelo  = [anim.velocity CGPointValue];
        CGPoint velocity     = CGPointMake(currentVelo.x, -currentVelo.y);
        POPSpringAnimation *positionAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnim.velocity            = [NSValue valueWithCGPoint:velocity];
        positionAnim.toValue             = [NSValue valueWithCGPoint:self.view.center];
        [self.dragView.layer pop_addAnimation:positionAnim forKey:@"layerPositionAnimation"];
                                           
    }
}


#pragma mark - 事件响应
- (void)touchDown:(UIControl *)control
{
    [control.layer pop_removeAllAnimations];
}
- (void)drugView:(UIPanGestureRecognizer *)recongnizer
{
    CGPoint translation                      = [recongnizer translationInView:self.view];
    recongnizer.view.center                  = CGPointMake(recongnizer.view.center.x + translation.x,
                                          recongnizer.view.center.y + translation.y);
    [recongnizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recongnizer.state                    == UIGestureRecognizerStateEnded) {
        CGPoint velocity                     = [recongnizer velocityInView:self.view];
        POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.delegate           = self;
        positionAnimation.velocity           = [NSValue valueWithCGPoint:velocity];
        [recongnizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}

#pragma mark - 私有方法
/**
 *  添加拖动视图
 */
- (void)setupDragView
{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drugView:)];
    UIControl *dragView                = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.dragView                      = dragView;
    dragView.center                    = self.view.center;
    dragView.layer.cornerRadius        = CGRectGetWidth(dragView.bounds) * 0.5;
    dragView.backgroundColor           = [UIColor colorWithRed:170/255.f green:70/255.0f blue:48/255.0f alpha:1.f];
    [dragView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [dragView addGestureRecognizer:recognizer];
    [self.view addSubview:dragView];
}


#pragma mark - getters & setters

@end
