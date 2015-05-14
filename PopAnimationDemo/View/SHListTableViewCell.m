//
//  SHListTableViewCell.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/13.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHListTableViewCell.h"

#import <POP.h>
@implementation SHListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.textColor = [UIColor colorWithRed:170/255.f green:70/255.0f blue:48/255.0f alpha:1.f];
        self.accessoryType       = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.font      = [UIFont fontWithName:@"helvetica" size:20];
        self.selectionStyle      = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (self.highlighted) {//高亮状态
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration           = 0.1f;
        scaleAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(0.9f, 0.9f)];
        [self.textLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }else{//正常状态
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity            = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness    = 20.f;
        [self.textLabel  pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}
@end
