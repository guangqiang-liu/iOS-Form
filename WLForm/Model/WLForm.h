//
//  WLForm.h
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WLFormSection, WLFormItem;

static NSString *const kLeftKey = @"kLeftKey"; // 标记左侧内容
static NSString *const kRightKey = @"kRightKey"; // 标记右侧内容
static NSString *const kFlagKey = @"kFlagKey"; // 用于标记是否有箭头
static NSString *const kDisableKey = @"kDisableKey"; // 用于标记是否禁用 textField

@interface WLForm : NSObject

@property (nonatomic, strong, readonly) NSMutableArray <WLFormSection *> *sectionArray;
@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) void(^disableBlock)(WLForm *);

- (void)addSection:(WLFormSection *)section;

- (void)removeSection:(WLFormSection *)section;

- (void)reformResRet:(id)res;

- (id)fetchRequestParams;

- (NSDictionary *)validateItems;

- (WLFormItem *)itemWithIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathWithItem:(WLFormItem *) item;

@end
