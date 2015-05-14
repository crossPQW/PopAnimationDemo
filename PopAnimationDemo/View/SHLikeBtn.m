//
//  SHLikeBtn.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/14.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHLikeBtn.h"
#import <POP.h>
@implementation SHLikeBtn

+ (instancetype)likeBtn
{
    return [self buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"icon_like_selected"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(scaleAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)scaleAnimation
{
    POPSpringAnimation *popSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    popSpringAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1.2f, 1.2f)];
    [self pop_addAnimation:popSpringAnimation forKey:@"popSpringScaleAnimation"];
    
}

@end
