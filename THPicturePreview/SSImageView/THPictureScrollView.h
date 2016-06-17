//
//  THPictureScrollView.h
//  THScrollerPickDemo
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THPictureScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *images;//!< 图片数据

@property (nonatomic, assign) NSInteger pageIndex;//!< 显示哪一张

@property (nonatomic, assign) NSInteger selectIndex;//!< 当前选中的张数

@property (nonatomic, copy) void(^ScrollEndPageInde)(int);//!< bolk
@property (nonatomic, copy) void(^hiddenMenuViewClick)();//!< bolk

@end
