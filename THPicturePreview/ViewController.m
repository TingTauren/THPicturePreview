//
//  ViewController.m
//  THPicturePreview
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "THPicturePreviewViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(50, 50, 100, 100)];
    [button setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
}

- (void)click {
    NSArray *arr = [NSArray arrayWithObjects:@"http://7xlwc6.com1.z0.glb.clouddn.com/1.jpg",@"http://7xlwc6.com1.z0.glb.clouddn.com/2.jpg",@"http://7xlwc6.com1.z0.glb.clouddn.com/3.jpg",@"http://7xlwc6.com1.z0.glb.clouddn.com/4.jpg",@"http://7xlwc6.com1.z0.glb.clouddn.com/5.jpg",@"http://7xlwc6.com1.z0.glb.clouddn.com/6.jpg", nil];
    
    THPicturePreviewViewController *thpicturePerview = [[THPicturePreviewViewController alloc] init];
    thpicturePerview.PageIndex = 2;
    [thpicturePerview setImages:arr];
    [self presentViewController:thpicturePerview animated:YES completion:nil];
    [thpicturePerview setMenuClick:^(int pageIndex) {
        NSLog(@"菜单点击");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
