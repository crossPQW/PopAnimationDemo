//
//  SHImageView.m
//  PopAnimationDemo
//
//  Created by 黄少华 on 15/5/15.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "SHImageView.h"

@interface SHImageView()

@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation SHImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 5.f;
        self.layer.masksToBounds = YES;
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    [self.imageView setImage:image];
    _image = image;
}
@end
