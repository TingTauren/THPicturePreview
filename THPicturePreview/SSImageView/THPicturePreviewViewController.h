//
//  THPicturePreviewViewController.h
//  THScrollerPickDemo
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THPicturePreviewViewController : UIViewController

@property (nonatomic, strong) NSArray *Images;//!< 图片数据

@property (nonatomic, assign) NSInteger PageIndex;//!< 显示位置

@property (nonatomic, copy) void(^menuClick)(int);//!< 菜单按钮点击

@end
