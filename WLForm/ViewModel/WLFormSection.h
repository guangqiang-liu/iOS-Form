//
//  WLFormSection.h
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WLFormItem;

@interface WLFormSection : NSObject

@property (nonatomic, strong, readonly) NSMutableArray <WLFormItem *> *itemArray;
@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, assign, getter=isHidden) BOOL hidden;
@property (nonatomic, copy) NSString *headerTitle;

- (void)addItem:(WLFormItem *)item;
- (void)addItemWithArray:(NSArray <WLFormItem *> *)itemArray;

@end
