//
//  WLForm+section.h
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLForm.h"
@class WLFormSection;
@interface WLForm (section)

- (WLFormSection *)getSectionWithIndex:(NSInteger) index;
- (void)setSection:(WLFormSection *)section index:(NSInteger)index;
@end
