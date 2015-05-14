//
//  SHCircleView.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/14.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHCircleView.h"
#import <POP.h>
@interface SHCircleView()

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@end
@implementation SHCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        NSAssert(frame.size.width == frame.size.height, @"宽高必须一致");
        [self setupCircleLayer];
    }
    return self;
}

- (void)setColor:(UIColor *)color
{
    self.circleLayer.strokeColor = color.CGColor;
    _color = color;
}

- (void)setupCircleLayer
{
    CGFloat lineWith         = 5.f;
    CGFloat radius           = CGRectGetWidth(self.bounds) * 0.5 - lineWith * 0.5;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    self.circleLayer         = shapeLayer;
    CGRect rect              = CGRectMake(lineWith *0.5, lineWith * 0.5, radius * 2, radius * 2);
    shapeLayer.path          = [UIBezierPath bezierPathWithRoundedRect:rect  cornerRadius:radius].CGPath;
    shapeLayer.strokeColor   = self.tintColor.CGColor;
    shapeLayer.fillColor     = nil;
    shapeLayer.lineWidth     = lineWith;
    shapeLayer.lineCap       = kCALineCapRound;
    shapeLayer.lineJoin      = kCALineJoinRound;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)animateToStrokeEnd:(CGFloat)strokeEnd
{
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue             = @(strokeEnd);
    strokeAnimation.springBounciness    = 12;
    strokeAnimation.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
}

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
        return;
    }
    self.circleLayer.strokeEnd = strokeEnd;
}
@end
