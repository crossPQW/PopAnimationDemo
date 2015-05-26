//
//  SHFoldingViewController.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/15.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHFoldingViewController.h"
#import "FoldingView.h"
@interface SHFoldingViewController ()

@property (nonatomic, strong) FoldingView *foldingView;
@end

@implementation SHFoldingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupFoldingView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.foldingView poke];
}

- (void)setupFoldingView
{
    CGFloat padding       = 30.f;
    CGFloat width         = CGRectGetWidth(self.view.bounds) - padding * 2;
    FoldingView *foldView = [[FoldingView alloc] initWithFrame:CGRectMake(0, 0, width, width) image:[UIImage imageNamed:@"d50735fae6cd7b8988bdc4fd0c2442a7d8330efe.jpg"]];
    self.foldingView      = foldView;
    foldView.center       = self.view.center;
    [self.view addSubview:foldView];
}


@end
