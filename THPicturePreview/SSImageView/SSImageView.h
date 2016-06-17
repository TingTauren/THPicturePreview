//
//  SSImageView.h
//  THScrollerPickDemo
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSImageView : UIView<UIScrollViewDelegate>{
    UIImageView *_imageView;
    UIScrollView *_contentView;
}

- (void)showImage;

- (void)hideImage;

- (void)setImage:(UIImage *) image;

- (void)RetureZoomScale;

+ (void)viewWithImage:(UIImage *) image;

- (void)setImageWithUrl:(NSString *) imageUrl;

- (void)changeZoomScale:(CGPoint) point;//!< 改变放大大小

@property (nonatomic, assign) BOOL isSetImage;

@end
