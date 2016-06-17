//
//  SSImageView.m
//  THScrollerPickDemo
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SSImageView.h"
#import "AppDelegate.h"
#import "ProgressView.h"//!< 环形进度条
#import "UIImageView+WebCache.h"

@interface SSImageView() {
    ProgressView *_progress;//!< 进度
}
//全屏显示时图片的size
- (CGSize)preferredSize:(UIImage *)image;

@end

@implementation SSImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _contentView.backgroundColor = [UIColor blackColor];
        _contentView.delegate = self;
        _contentView.bouncesZoom = YES;
        
        _contentView.minimumZoomScale = 0.5;
        _contentView.maximumZoomScale = 5.0;
        
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        [self addSubview:_contentView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.userInteractionEnabled = YES;
        
        [_contentView addSubview:_imageView];
        
        _progress = [[ProgressView alloc]initWithFrame:CGRectMake((CGRectGetWidth(frame)-80)/2, (CGRectGetHeight(frame)-80)/2, 60, 60)];
        _progress.arcFinishColor = [UIColor whiteColor];
        _progress.arcUnfinishColor = [UIColor whiteColor];
        _progress.arcBackColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _progress.centerColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _progress.width = 4;
        _progress.percent = 0.0;
        [self addSubview:_progress];
    }
    return self;
}

- (void)didClickCollectionButtonAction:(UIButton *) button {
    [self RetureZoomScale];
}

- (void)setImageWithUrl:(NSString *)imageUrl {
    _isSetImage = YES;//!< 是否加载图片
    
    NSString *urlStr = imageUrl;
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [_imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"DefaultImage"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        _progress.hidden = NO;
        _progress.percent = (float)receivedSize/expectedSize;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            [self setShowImageSize:image];//!< 设置显示图片尺寸
        } else {
            [self setShowImageSize:[UIImage imageNamed:@"DefaultImage"]];//!< 设置显示图片尺寸
        }
        if (error) {
            _isSetImage = NO;//!< 是否加载图片
        }
        _progress.hidden = YES;
    }];
    
    //    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    //    [manager downloadImageWithURL:url options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    //        _progress.hidden = NO;
    //        _progress.percent = (float)receivedSize/(float)expectedSize;
    //        NSLog(@"%ld -- %ld",receivedSize,expectedSize);
    //    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
    //        [self setShowImageSize:image];//!< 设置显示图片尺寸
    //
    //        _progress.hidden = YES;
    //        _imageView.image = image;
    //        NSLog(@" ----- %@",error);
    //    }];
}

- (void)setImage:(UIImage *)image {
    _isSetImage = YES;//!< 是否加载图片
    
    [self setShowImageSize:image];//!< 设置显示图片尺寸
    
    _imageView.image = image;
}

- (void)setShowImageSize:(UIImage *) image {
    CGSize size = [self preferredSize:image];
    _imageView.frame = CGRectMake(0, 0, size.width, size.height);
    
    _contentView.contentSize = size;
    
    _imageView.center = _contentView.center;
    
    [self showImage];
}

- (CGSize)preferredSize:(UIImage *)image {
    CGFloat width = 0.0, height = 0.0;
    CGFloat rat0 = image.size.width / image.size.height;
    CGFloat rat1 = self.frame.size.width / self.frame.size.height;
    if (rat0 > rat1) {
        width = self.frame.size.width;
        height = width / rat0;
    } else {
        height = self.frame.size.height;
        width = height * rat0;
    }
    
    return CGSizeMake(width, height);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat x = scrollView.center.x,y = scrollView.center.y;
    x = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : x;
    y = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : y;
    _imageView.center = CGPointMake(x, y);
}

- (void)showImage {
//    _contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
//    _contentView.alpha = 0;
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        _contentView.alpha = 1.0;
//        _contentView.transform = CGAffineTransformMakeScale(1, 1);
//        _contentView.center = self.center;
//    }];
    
    _imageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _imageView.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        _imageView.alpha = 1.0;
        _imageView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)hideImage {
    [UIView animateWithDuration:0.25 animations:^{
        _contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        _contentView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            _contentView.alpha = 1;
            [_contentView removeFromSuperview];
            [_imageView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)RetureZoomScale {
    [_contentView setZoomScale:1.0 animated:YES];
}

+ (void)viewWithImage:(UIImage *)image {
    AppDelegate *delegate = ((AppDelegate *)[UIApplication sharedApplication].delegate);
    UIWindow *window = delegate.window;
//    NSLog(@"%f - %f - %f - %f",window.frame.origin.x,window.frame.origin.y,window.frame.size.width,window.frame.size.height);
    SSImageView *imageViewer = [[SSImageView alloc] initWithFrame:window.frame];
    [imageViewer setImage:image];
    
    [window addSubview:imageViewer];
    [imageViewer showImage];
}

- (void)changeZoomScale:(CGPoint)point {//!< 改变变化大小
    if (_contentView.zoomScale == 1) {
        [_contentView zoomToRect:CGRectMake(point.x, point.y, 0, 0) animated:YES];
    } else {
        [_contentView setZoomScale:1.0 animated:YES];
    }
}

- (void)dealloc {
    _contentView = nil;
    _imageView = nil;
}

@end
