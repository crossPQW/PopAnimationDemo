//
//  SHButtonViewController.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/13.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHButtonViewController.h"
#import "SHButton.h"
#import "SHLikeBtn.h"
#import <POP.h>
@interface SHButtonViewController ()

@property (nonatomic, strong) SHButton *btn;
@property (nonatomic, strong) UIActivityIndicatorView *juhua;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) SHLikeBtn *likeBtn;
@end

@implementation SHButtonViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupButton];
    [self setupLabel];
    [self setupJuhua];//创建菊花,之所以这么命名是因为那个控件名太长了啊摔
    [self setupLikeBtn];
    
}



#pragma mark - delegate & datesource



#pragma mark - 事件响应
- (void)loginBtnClick:(SHButton *)btn
{
    NSLog(@"外界相应");
    [self hideLabel];
    [self.juhua startAnimating];
    btn.userInteractionEnabled = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.juhua stopAnimating];
        [self shakeButton];
        [self showLabel];
    });
}

#pragma mark - 私有方法
- (void)setupButton
{
    SHButton *btn                                 = [SHButton button];
    self.btn                                      = btn;
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:@"登陆" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0f
                                                          constant:0.1]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.f
                                                          constant:0.f]];
}

- (void)setupLabel
{
    UILabel *errorLabel                                  = [[UILabel alloc] init];
    self.errorLabel                                      = errorLabel;
    errorLabel.font                                      = [UIFont fontWithName:@"Avenir-Light" size:18];
    errorLabel.textColor                                 = [UIColor colorWithRed:170/255.f green:70/255.0f blue:48/255.0f alpha:1.f];
    errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    errorLabel.text                                      = @"(*^__^*) 嘻嘻……登不上";
    errorLabel.textAlignment                             = NSTextAlignmentCenter;
    [self.view insertSubview:errorLabel belowSubview:self.btn];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:errorLabel
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.btn
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:errorLabel
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.btn
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
    errorLabel.layer.transform = CATransform3DMakeScale(0.5f, 0.5f, 1.f);
}

- (void)setupJuhua
{
    UIActivityIndicatorView *juhua         = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.juhua                             = juhua;
    UIBarButtonItem *item                  = [[UIBarButtonItem alloc] initWithCustomView:juhua];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setupLikeBtn
{
    SHLikeBtn *likeBtn = [SHLikeBtn likeBtn];
    self.likeBtn       = likeBtn;
    likeBtn.frame      = CGRectMake(100, 100, 20, 20);
    [self.view addSubview:likeBtn];
}

#pragma mark - animation
- (void)shakeButton
{
    POPSpringAnimation *positionAni = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAni.velocity            = @2000;
    positionAni.springBounciness    = 20;
    [positionAni setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.btn.userInteractionEnabled = YES;
    }];
    [self.btn.layer pop_addAnimation:positionAni forKey:@"positionAnimation"];
}

- (void)showLabel
{
    self.errorLabel.layer.opacity              = 1.0;
    POPSpringAnimation *layerScaleAnimation    = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.springBounciness       = 18;
    layerScaleAnimation.toValue                = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.errorLabel.layer pop_addAnimation:layerScaleAnimation forKey:@"labelScaleAnimation"];
    
    POPSpringAnimation *layerPositionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue                = @(self.btn.layer.position.y + self.btn.intrinsicContentSize.height);
    layerPositionAnimation.springBounciness       = 12;
    [self.errorLabel.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];
}

- (void)hideLabel
{
    POPBasicAnimation *laberScaleAnimation    = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    laberScaleAnimation.toValue               = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    [self.errorLabel.layer pop_addAnimation:laberScaleAnimation forKey:@"layerScaleAnimation"];
    
    POPBasicAnimation *layerPositionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue            = @(self.btn.layer.position.y);
    [self.errorLabel.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];
}

#pragma mark - getters & setters

@end
