//
//  SHButton.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/13.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHButton.h"
#import <POP.h>
@implementation SHButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)button
{
    return [self buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}


#pragma mark - private method
- (void)setup
{
    self.backgroundColor    = [UIColor colorWithRed:0/255.f green:73/255.0f blue:131/255.0f alpha:1.f];
    self.layer.cornerRadius = 4.f;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font    = [UIFont fontWithName:@"Avenir-Medium" size:22];
    [self addTarget:self action:@selector(scaleToSmall) forControlEvents:UIControlEventTouchDown |UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault) forControlEvents:UIControlEventTouchDragExit];
}

- (void)scaleToSmall
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(0.9f, 0.9f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation
{
    NSLog(@"scaleAnimation");
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity            = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue             = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness    = 18.0f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

-(void)scaleToDefault
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue            = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}

- (UIEdgeInsets)titleEdgeInsets
{
    return UIEdgeInsetsMake(4.0f, 28.0f, 4.f, 28.0f);
}

- (CGSize)intrinsicContentSize
{
    CGSize s = [super intrinsicContentSize];
    
    return CGSizeMake(s.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right,
                      s.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom);
}
@end
