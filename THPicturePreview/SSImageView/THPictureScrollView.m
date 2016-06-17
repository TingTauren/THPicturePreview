//
//  THPictureScrollView.m
//  THScrollerPickDemo
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "THPictureScrollView.h"
#import "SSImageView.h"

#define windWidth [UIScreen mainScreen].bounds.size.width
#define windHeight [UIScreen mainScreen].bounds.size.height

@implementation THPictureScrollView {
    NSMutableArray *_ssImages;//!< 显示图片数组
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.delegate = self;
        _ssImages = [NSMutableArray array];
        _pageIndex = 0;
        
        UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
        [self addGestureRecognizer:doubleTapGestureRecognizer];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenMenuView)];
        [tapGesture setNumberOfTapsRequired:1];
        [self addGestureRecognizer:tapGesture];
        
        [tapGesture requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    }
    return self;
}

- (void)setImages:(NSArray *)images {
    _images = images;
    
    CGFloat ssImageX = 10.0;
    for (int i=0; i<_images.count; i++) {
        SSImageView *ssimage = [[SSImageView alloc] initWithFrame:CGRectMake(ssImageX, 0, windWidth, self.bounds.size.height)];
        if (i == _pageIndex) {
            [ssimage setImageWithUrl:[_images objectAtIndex:i]];
        }
        [self addSubview:ssimage];
        ssImageX += self.bounds.size.width;
        
        [_ssImages addObject:ssimage];//!< 存在数组里面
    }
    
    [self setContentSize:CGSizeMake(ssImageX-10, self.bounds.size.height)];
    if (_pageIndex > 0 && _pageIndex < _images.count) {
        [self setContentOffset:CGPointMake(_pageIndex*self.bounds.size.width, 0)];
        _selectIndex = _pageIndex;//!< 初始化当前选中Index
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = (int)(scrollView.contentOffset.x/scrollView.bounds.size.width);
    int indexLeft = index - 1 < 0 ? 0 : index - 1;
    int indexRight = index + 1 > (_ssImages.count-1) ? (int)(_ssImages.count-1) : index + 1;
    
    //!< 设置图片
    SSImageView *imageSelect = (SSImageView *)[_ssImages objectAtIndex:index];
    if (!imageSelect.isSetImage) {
        [imageSelect setImageWithUrl:[_images objectAtIndex:index]];
    }
    
    SSImageView *imageLeft = (SSImageView *)[_ssImages objectAtIndex:indexLeft];
    [imageLeft RetureZoomScale];
    
    SSImageView *imageRight = (SSImageView *)[_ssImages objectAtIndex:indexRight];
    [imageRight RetureZoomScale];
    
    _selectIndex = index;//!< 赋值当前选中index
    if (self.ScrollEndPageInde) {
        _ScrollEndPageInde(index);//!< blok回调
    }
}

#pragma mark - 点击事件
- (void)doubleTap:(UITapGestureRecognizer *) tapGesture {//!< 双击手势
    CGPoint point = [tapGesture locationInView:[[UIApplication sharedApplication].windows firstObject].maskView];
    SSImageView *imageSelect = (SSImageView *)[_ssImages objectAtIndex:_selectIndex];
    [imageSelect changeZoomScale:point];
}
- (void)hiddenMenuView {//!< 单击手势
    if (self.hiddenMenuViewClick) {
        _hiddenMenuViewClick();
    }
}

@end
