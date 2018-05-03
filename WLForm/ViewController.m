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
#import "StepperCell.h"
#import "WLFormMoreInfoCell.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
    [self configForm];
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
    section.headerTitle = @"账号";
    section.headerHeight = 50;
    section.sectionHeaderBgColor = [UIColor whiteColor];
    section.headerTitleMarginLeft = 15;
    section.headerTopSepLineHeight = 10;
    section.headerTopSepLineColor = sepLineColor;
    
    NSDictionary *dic = @{kLeftKey:@"Email", kRightKey:@"大傻逼"};
    row = [self rowForFieldWithUserInfo:dic];
    row.hasTopSep = YES;
    row.reformResRetBlock = ^(id ret, id value) {
        NSLog(@"ssss");
    };
    [section addItem:row];
    
    dic = @{kLeftKey:@"Password"};
    WLFormItem *row1 = [self rowForFieldWithUserInfo:dic];
    [section addItem:row1];
    
    dic = @{kLeftKey:@"Repeat Password"};
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
    section.headerTitle = @"详情";
    section.headerHeight = 50;
    section.sectionHeaderBgColor = [UIColor whiteColor];
    section.headerTitleMarginLeft = 15;
    section.headerTopSepLineHeight = 10;
    section.headerTopSepLineColor = sepLineColor;
    
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
    
    return section;
}

- (WLFormSection *)moreInfoSection {
    WLFormSection *section = nil;
    WLFormItem *row = nil;
    
    section = [[WLFormSection alloc] init];
    
    row = [self rowForMoreInfo];
    row.hasTopSep = YES;
    [section addItem:row];
    
    return section;
}

- (WLFormItem *)rowForMoreInfo {
    WLFormItem *row = nil;
    row = [[WLFormItem alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MoreInfo"];
    row.cellClass = [WLFormMoreInfoCell class];
    row.itemHeight = 54.f;
    row.itemConfigBlock = ^(WLFormMoreInfoCell *cell, id value, NSIndexPath *indexPath) {
        cell.textLabel.text = value[kLeftKey];
    };
    return row;
}

- (WLFormItem *)rowForGender {
    WLFormItem *row = nil;
    NSDictionary *dic = @{kLeftKey:@"Gender",
                          kFlagKey:@YES,
                          kDisableKey:@YES};
    row = [self rowForFieldWithUserInfo:dic];
    __weak typeof(self) weakSelf = self;
    row.didSelectCellBlock = ^(NSIndexPath *indexPath, id value, id cell) {
        GenderPickerViewVC *vc = [[GenderPickerViewVC alloc] init];
        vc.pickBlock = ^(BOOL isMale) {
            [weakSelf.navigationController popToViewController:weakSelf animated:YES];
            value[kRightKey] = isMale ? @"Male" : @"Female";
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
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
    row = [[WLFormItem alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Stepper"];
    row.cellClass = [StepperCell class];
    row.itemHeight = 44.f;
    row.value = @{kLeftKey:@"Age"}.mutableCopy;
    row.itemConfigBlock = ^(StepperCell *cell, id value, NSIndexPath *indexPath) {
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
    row = [[WLFormItem alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"lableFiled"];
    row.itemHeight = 44.f;
    row.cellClass = [WLFormTextInputCell class];
    row.value = userInfo.mutableCopy;
    row.itemConfigBlock = ^(WLFormTextInputCell *cell, id value, NSIndexPath *indexPath) {
        cell.leftlabel.text = value[kLeftKey];
        cell.rightField.text = value[kRightKey];
        cell.rightField.enabled = ![value[kDisableKey] boolValue];
        cell.rightField.placeholder = value[kLeftKey];
        BOOL hasArrow =  [value[kFlagKey] boolValue];
        cell.accessoryType = hasArrow ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        cell.textChangeBlock = ^(NSString *text){
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
