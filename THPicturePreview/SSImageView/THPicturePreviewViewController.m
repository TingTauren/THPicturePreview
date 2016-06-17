//
//  THPicturePreviewViewController.m
//  THScrollerPickDemo
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "THPicturePreviewViewController.h"
#import "THPictureScrollView.h"//!< 滚动视图

@interface THPicturePreviewViewController () {
    THPictureScrollView *_thScrollView;//!< 滚动视图
    
    UIButton *_collectionButton;
    
    // functionViews
    UIView *_headShowView;//!< 顶部视图
    UIButton *_backBtn;//!< 返回按钮
    UILabel *_showPageIndex;//!< 数量显示
    UIButton *_menuBtn;//!< 菜单按钮
    
    UIView *_downShowView;//!< 底部视图
}

@end

@implementation THPicturePreviewViewController

- (void)setImages:(NSArray *)Images {
    _Images = Images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _thScrollView = [[THPictureScrollView alloc] initWithFrame:CGRectMake(-10, 0, self.view.bounds.size.width + 20, self.view.bounds.size.height)];
    [_thScrollView setPageIndex:_PageIndex];
    [_thScrollView setImages:_Images];
    [self.view addSubview:_thScrollView];
    
    [self createFunctionViews];//!< 创建顶部菜单视图
    
    __weak UILabel *myShowPageIndexLable = _showPageIndex;THPicturePreviewViewController *mySelf = self;UIView *myHeadShowView = _headShowView;
    [_thScrollView setScrollEndPageInde:^(int index) {
        [myShowPageIndexLable setText:[NSString stringWithFormat:@"%d/%d",(int)index+1,(int)mySelf.Images.count]];
    }];
    [_thScrollView setHiddenMenuViewClick:^{
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.4;
        [myHeadShowView.layer addAnimation:animation forKey:nil];
        
        myHeadShowView.hidden = !myHeadShowView.hidden;
    }];
}

#pragma mark - 创建功能视图
- (void)createFunctionViews {
    _headShowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
    [_headShowView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.05]];
    [self.view addSubview:_headShowView];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setFrame:CGRectMake(10, 27, 34, 30)];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"backImage.png"] forState:UIControlStateNormal];
    [_headShowView addSubview:_backBtn];
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _showPageIndex = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_backBtn.frame)+10, 20, CGRectGetWidth(_headShowView.frame)-(CGRectGetMaxX(_backBtn.frame)+10)*2, 44)];
    _showPageIndex.textAlignment = NSTextAlignmentCenter;
    _showPageIndex.textColor = [UIColor whiteColor];
    _showPageIndex.font = [UIFont systemFontOfSize:20];
    [_showPageIndex setText:[NSString stringWithFormat:@"%d/%d",(int)_PageIndex+1,(int)_Images.count]];
    [_headShowView addSubview:_showPageIndex];
    
    _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_menuBtn setFrame:CGRectMake(CGRectGetMaxX(_showPageIndex.frame), 25, 34, 34)];
    [_menuBtn setBackgroundImage:[UIImage imageNamed:@"menuImage.png"] forState:UIControlStateNormal];
    [_headShowView addSubview:_menuBtn];
    [_menuBtn addTarget:self action:@selector(menuBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 功能方法
- (void)backBtnClick {//!< 返回点击
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)menuBtnClick {//!< 菜单点击
    if (self.menuClick) {
        _menuClick((int)_thScrollView.selectIndex);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
