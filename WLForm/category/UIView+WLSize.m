//
//  UIView+WLSize.m
//  WLForm
//
//  Created by 刘光强 on 2018/5/4.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "UIView+WLSize.h"

@implementation UIView (WLSize)

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font {
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:font}
                                           context:nil];
    return CGSizeMake(textRect.size.width, textRect.size.height);
}

- (CGFloat)calculateHeightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font spacing:(NSInteger)spacing {
    CGSize size = CGSizeMake(width, 2000);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:spacing];
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}
@end
