//
//  ViewController.m
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "ViewController.h"
#import "WLFormItem.h"
#import "WLFormSection.h"
#import "WLForm.h"
#import "WLFormTextInputCell.h"
#import "GenderPickerViewVC.h"
#import "WLFormStepperCell.h"
#import "WLFormMoreInfoCell.h"
#import "WLFormBottomTipCell.h"
#import "WLFormBottomButtonCell.h"
#import "WLFormRadioCell.h"
#import "WLFormSelectCell.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
    [self configForm];
    
//    [self.form reformResRet:@{@"name":@"xx",@"sex":@"pp"}];
//    [self.tableView reloadData];
}

#pragma mark - event response
- (void)submit:(id)sender {
    NSDictionary *dic = [self.form validateItems];
    if (![dic[kValidateRetKey] boolValue]) {
        [self alertMsg:dic[kValidateMsgKey]];
    } else {
        NSString *msg = [[self.form fetchRequestParams] description];
        [self alertMsg:msg title:@"Params are OK"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - private methods
- (void)configForm {
    [self.form addSection:[self accountSection]];
    [self.form addSection:[self detailSection]];
    [self.form addSection:[self moreInfoSection]];
}

- (WLFormSection *)accountSection {
    WLFormSection *section = nil;
    WLFormItem *row = nil;
    
    section = [[WLFormSection alloc] init];
    section.headerHeight = 50;
    section.sectionHeaderBgColor = [UIColor whiteColor];
    section.headerTitleMarginLeft = 15;
    section.headerTopSepLineHeight = 10;
    section.headerTopSepLineColor = sepLineColor;
    section.headerTitleColor = HexRGB(0x434343);
    section.headerTitleFont = H16;
    section.headerTitle = @"账号";
    
    NSDictionary *dic = @{kLeftKey:@"Email", kPlaceholder:@"请输入商户名称"};
    row = [self rowForFieldWithUserInfo:dic];
    row.hasTopSep = YES;
    row.reformResRetBlock = ^(id ret, id value) {
        NSLog(@"ssss");
    };
    [section addItem:row];
    
    dic = @{kLeftKey:@"Password", kPlaceholder:@"请输入Password"};
    WLFormItem *row1 = [self rowForFieldWithUserInfo:dic];
    [section addItem:row1];
    
    dic = @{kLeftKey:@"Repeat Password", kPlaceholder:@"请输入Repeat Password"};
    row = [self rowForFieldWithUserInfo:dic];
    row.hasBottomSep = NO;
    row.valueValidateBlock = ^NSDictionary *(id value) {
        if ([row1.value[kRightKey] isEqualToString:value[kRightKey]]) return itemValid();
        return itemInvalid(@"Two password should be the same");
    };
    
    [section addItem:row];
    return section;
}

- (WLFormSection *)detailSection {
    
    WLFormSection *section = nil;
    WLFormItem *row = nil;
    
    section = [[WLFormSection alloc] init];
    section.headerHeight = 50;
    section.sectionHeaderBgColor = [UIColor whiteColor];
    section.headerTitleMarginLeft = 15;
    section.headerTopSepLineHeight = 10;
    section.headerTopSepLineColor = sepLineColor;
    section.headerTitleColor = HexRGB(0x434343);
    section.headerTitleFont = H16;
    section.headerTitle = @"详情";
    
    NSDictionary *dic = @{kLeftKey:@"Name"};
    row = [self rowForFieldWithUserInfo:dic];
    row.hasTopSep = YES;
    [section addItem:row];
    
    row = [self rowForGender];
    [section addItem:row];
    
    row = [self rowForBirthDay];
    row.hidden = YES;
    [section addItem:row];
    
    row = [self rowForStepper];
    row.hasBottomSep = NO;
    [section addItem:row];
    
    dic = @{kLeftKey:@"更多信息（选填）"};
    row = [self rowForMoreInfo:dic];
    row.bottomSepLineMarginLeft = 0;
    [section addItem:row];
    return section;
}

- (WLFormSection *)moreInfoSection {
    WLFormSection *section = nil;
    WLFormItem *row = nil;
    NSDictionary *dic = @{};
    
    section = [[WLFormSection alloc] init];
    
    row = [self rowForStepper];
    [section addItem:row];
    
    row = [self rowForStepper];
    [section addItem:row];
    
    row = [self rowForStepper];
    row.hasBottomSep = NO;
    [section addItem:row];
    
    dic = @{kLeftKey:@"说明：请输入新邮箱后点击提交，系统会给您重新发送电子发票,请输入新邮箱后点击提交，系统会给您重新发送电子发票"};
    row = [self rowForBottomTip:dic];
    row.bottomSepLineMarginLeft = 0;
    [section addItem:row];
    
    dic = @{kLeftKey:@"提交"};
    row = [self rowForBottomButton:dic];
    row.bottomSepLineMarginLeft = 0;
    [section addItem:row];
    
    dic = @{@"leftTitle":@"税控盘类型", @"leftButtonTitle":@"航信金税盘", @"rightButtonTitle":@"百望税控盘"};
    row = [self rowForRadio:dic];
    row.bottomSepLineMarginLeft = 0;
    [section addItem:row];
    
    dic = @{@"leftTitle":@"是否已开通电子发票业务", @"leftButtonTitle":@"未开通", @"rightButtonTitle":@"已开通"};
    row = [self rowForRadio:dic];
    row.bottomSepLineMarginLeft = 0;
    [section addItem:row];
    return section;
}

- (WLFormItem *)rowForRadio:(NSDictionary *)info {
    WLFormItem *row = nil;
    row = [[WLFormItem alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormRadioCell"];
    row.cellClass = [WLFormRadioCell class];
    row.itemHeight = 48.f;
    row.itemConfigBlock = ^(WLFormRadioCell *cell, id value, NSIndexPath *indexPath) {
        cell.radioInfo = info;
    };
    return row;
}

- (WLFormItem *)rowForBottomTip:(NSDictionary *)info {
    WLFormItem *row = nil;
    row = [[WLFormItem alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormBottomTipCell"];
    row.cellClass = [WLFormBottomTipCell class];
    row.itemHeight = 54.f;
    row.itemConfigBlock = ^(WLFormBottomTipCell *cell, id value, NSIndexPath *indexPath) {
        cell.tipStr = info[kLeftKey];
    };
    return row;
}

- (WLFormItem *)rowForBottomButton:(NSDictionary *)info {
    WLFormItem *row = nil;
    row = [[WLFormItem alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormBottomButtonCell"];
    row.cellClass = [WLFormBottomButtonCell class];
    row.itemHeight = 44.f;
    __weak typeof(self) weakSelf = self;
    row.itemConfigBlock = ^(WLFormBottomButtonCell *cell, id value, NSIndexPath *indexPath) {
        cell.title = info[kLeftKey];
        cell.bottomButtonBlock = ^{
            NSLog(@"点击了提交按钮");
        };
    };
    return row;
}

- (WLFormItem *)rowForMoreInfo:(NSDictionary *)info {
    WLFormItem *row = nil;
    row = [[WLFormItem alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormMoreInfoCell"];
    row.cellClass = [WLFormMoreInfoCell class];
    row.itemHeight = 54.f;
    row.value = info.mutableCopy;
    row.itemConfigBlock = ^(WLFormMoreInfoCell *cell, id value, NSIndexPath *indexPath) {
        cell.leftTitle.text = value[kLeftKey];
        cell.moreInfoBlock = ^{
            WLFormSection *section = self.form.sectionArray[2];
            section.hidden = !section.hidden;
            [self.tableView reloadData];
        };
    };
    return row;
}

- (WLFormItem *)rowForGender {
    WLFormItem *row = nil;
    NSDictionary *dic = @{kLeftKey:@"Gender",
                          kRightKey:@"请选择性别",
                          kFlagKey:@YES};
    row = [self rowForSelect:dic];
    __weak typeof(self) weakSelf = self;
    row.didSelectCellBlock = ^(NSIndexPath *indexPath, id value, WLFormSelectCell *cell) {
        GenderPickerViewVC *vc = [[GenderPickerViewVC alloc] init];
        vc.pickBlock = ^(BOOL isMale) {
            [weakSelf.navigationController popToViewController:weakSelf animated:YES];
            value[kRightKey] = isMale ? @"Male" : @"Female";
            cell.rightTitle = isMale ? @"Male" : @"Female";
            cell.hasSelected = YES;
            // 这个地方，当执行刷新操作时，会将之前的部分状态重置掉，这个地方需求修改
//            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return row;
}

- (WLFormItem *)rowForSelect:(NSDictionary *)info {
    WLFormItem *row = nil;
    row = [[WLFormItem alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormSelectCell"];
    row.itemHeight = 48;
    row.cellClass = [WLFormSelectCell class];
    row.value = info.mutableCopy;
    row.itemConfigBlock = ^(WLFormSelectCell *cell, id value, NSIndexPath *indexPath) {
        cell.leftLable.text = value[kLeftKey];
        cell.rightTitle = value[kRightKey];
    };
    return row;
}

- (WLFormItem *)rowForBirthDay {
    WLFormItem *row = nil;
    NSDictionary *dic = @{kLeftKey:@"Date of Birth"};
    row = [self rowForFieldWithUserInfo:dic];
    row.disableValidateBlock = ^NSDictionary *(id value, BOOL didClicked) {
        [self.form reformResRet:@{@"key":@"value"}];
        NSString *msg = @"此行已禁用，暂不支持";
        if (didClicked) [self alertMsg:msg];
        return itemInvalid(msg);
    };
    return row;
}

- (WLFormItem *)rowForStepper {
    WLFormItem *row = nil;
    row = [[WLFormItem alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"StepperCell"];
    row.cellClass = [WLFormStepperCell class];
    row.itemHeight = 44.f;
    row.value = @{kLeftKey:@"Age"}.mutableCopy;
    row.itemConfigBlock = ^(WLFormStepperCell *cell, id value, NSIndexPath *indexPath) {
        cell.textLabel.text = value[kLeftKey];
        [cell updateValue:[value[kRightKey] doubleValue]];
        cell.stepperBlock = ^(double newValue){
            value[kRightKey] = @(newValue);
        };
    };
    return row;
}

- (WLFormItem *)rowForFieldWithUserInfo:(NSDictionary *)userInfo {
    WLFormItem *row = nil;
    row = [[WLFormItem alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormTextInputCell"];
    row.itemHeight = 48;
    row.cellClass = [WLFormTextInputCell class];
    row.value = userInfo.mutableCopy;
    row.itemConfigBlock = ^(WLFormTextInputCell *cell, id value, NSIndexPath *indexPath) {
        cell.leftlabel.text = value[kLeftKey];
        cell.rightField.text = value[kRightKey];
        cell.rightField.enabled = ![value[kDisableKey] boolValue];
        cell.rightField.placeholder = value[kPlaceholder];
        cell.textChangeBlock = ^(NSString *text) {
            value[kRightKey] = text;
        };
    };
    row.requestParamsConfigBlock = ^(id value) {
        NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:1];
        ret[value[kLeftKey]] = value[kRightKey];
        return ret;
    };
    return row;
}

- (void)setupViews {
    self.title = @"WLForm";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(submit:)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)alertMsg:(NSString *)msg title:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:done];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alertMsg:(NSString *)msg {
    [self alertMsg:nil title:msg];
}

@end
