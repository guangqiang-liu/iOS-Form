//
//  GenderPickerViewVC.h
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenderPickerViewVC : UIViewController

@property (nonatomic, copy) void(^pickBlock)(BOOL isMale);
@end
