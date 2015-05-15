//
//  SHImageViewController.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/15.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHImageViewController.h"
#import "SHImageView.h"
#import <POP.h>

typedef struct {
    CGFloat progress;
    CGFloat toValue;
    CGFloat currentValue;
}AnimationStatue;

@interface SHImageViewController ()

@end

@implementation SHImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupImageView];
}

- (void)setupImageView
{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    CGFloat width                      = CGRectGetWidth(self.view.bounds) - 20.f;
    CGFloat height                     = roundf(width * 0.75f);
    SHImageView *imageView             = [[SHImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    imageView.image                    = [UIImage imageNamed:@"d50735fae6cd7b8988bdc4fd0c2442a7d8330efe.jpg"];
    imageView.center                   = self.view.center;
    [imageView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [imageView addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addGestureRecognizer:recognizer];
    
    [self.view addSubview:imageView];
}

- (void)touchDown:(UIControl *)control
{
    [self pauseAllAnimations:YES forLayer:control.layer];
}

- (void)touchUpInside:(UIControl *)sender {
    AnimationStatue animationStatus = [self animationInfoForLayer:sender.layer];
    BOOL hasAnimations              = sender.layer.pop_animationKeys.count;
    
    if (hasAnimations && animationStatus.progress < 0.98) {
        [self pauseAllAnimations:NO forLayer:sender.layer];
        return;
    }
    
    [sender.layer pop_removeAllAnimations];
    if (animationStatus.toValue == 1 || sender.layer.affineTransform.a == 1) {
        [self scaleDownView:sender];
        return;
    }
    
    [self scaleUpView:sender];
        
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    [self scaleDownView:recognizer.view];
    
    CGPoint translation      = [recognizer translationInView:self.view];
    recognizer.view.center   = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateFailed) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity            = [NSValue valueWithCGPoint:velocity];
        positionAnimation.dynamicsTension     = 10.f;
        positionAnimation.dynamicsFriction    = 1.f;
        positionAnimation.springBounciness    = 12.f;
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}

- (void)scaleUpView:(UIView *)view
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.toValue             = [NSValue valueWithCGPoint:self.view.center];
    [view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    
    POPSpringAnimation *scaleAnimation    = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue                = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    scaleAnimation.springBounciness       = 10.f;
    [view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)scaleDownView:(UIView *)view
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue             = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    scaleAnimation.springBounciness    = 10.f;
    [view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)pauseAllAnimations:(BOOL)pause forLayer:(CALayer *)layer
{
    for (NSString *key in layer.pop_animationKeys) {
        POPAnimation *animation = [layer pop_animationForKey:key];
        [animation setPaused:pause];
    }
}

- (AnimationStatue)animationInfoForLayer:(CALayer *)layer
{
    POPSpringAnimation *animation = [layer pop_animationForKey:@"scaleAnimation"];
    CGPoint toValue               = [animation.toValue CGPointValue];
    CGPoint currentValue          = [[animation valueForKey:@"currentValue"] CGPointValue];
    
    CGFloat min                   = MIN(toValue.x, currentValue.x);
    CGFloat max                   = MAX(toValue.x, currentValue.x);
    
    AnimationStatue status;
    status.toValue                = toValue.x;
    status.currentValue           = currentValue.x;
    status.progress               = min/max;
    return status;
}
@end
