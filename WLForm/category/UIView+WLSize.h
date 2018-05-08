//
//  UIView+WLSize.h
//  WLForm
//
//  Created by 刘光强 on 2018/5/4.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLSize)

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;

- (CGFloat)calculateHeightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font spacing:(NSInteger)spacing;
@end
