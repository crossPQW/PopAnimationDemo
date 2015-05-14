//
//  SHCircleView.h
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/14.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCircleView : UIView

@property (nonatomic, strong) UIColor *color;

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end
