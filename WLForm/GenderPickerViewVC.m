//
//  GenderPickerViewVC.m
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "GenderPickerViewVC.h"

@interface GenderPickerViewVC ()

@end

@implementation GenderPickerViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    for (NSInteger i = 0; i < 2; ++i) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = 88;
        [button setTitle:i ? @"Male" :@"Female" forState:UIControlStateNormal];
        button.frame = CGRectMake(50 + i * (width + 20), 100, width, 50);
        button.tag = i;
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)button {
    !self.pickBlock ?: self.pickBlock(button.tag);
}

@end
