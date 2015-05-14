//
//  SHCycleViewController.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/14.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHCircleViewController.h"
#import "SHCircleView.h"
@interface SHCircleViewController ()

@property (nonatomic, strong) SHCircleView *circleView;
@end

@implementation SHCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupCircleView];
    [self setupSlider];
}

- (void)setupCircleView
{
    SHCircleView *circleView = [[SHCircleView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.circleView          = circleView;
    circleView.color         = [UIColor colorWithRed:0/255.f green:73/255.0f blue:131/255.0f alpha:1.f];
    circleView.center        = self.view.center;
    [self.view addSubview:circleView];
}

- (void)setupSlider
{
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    slider.tintColor = [UIColor colorWithRed:0/255.f green:73/255.0f blue:131/255.0f alpha:1.f];
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    CGPoint viewCenter = self.view.center;
    CGPoint sliderCenter = CGPointMake(viewCenter.x, viewCenter.y + 150);
    slider.center = sliderCenter;
    [self.view addSubview:slider];
    
    [self.circleView setStrokeEnd:slider.value animated:NO];
}

- (void)sliderChange:(UISlider *)slider
{
    [self.circleView setStrokeEnd:slider.value animated:YES];
}
@end
