//
//  WLFormMoreInfoCell.m
//  WLForm
//
//  Created by 刘光强 on 2018/5/3.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLFormMoreInfoCell.h"

@interface WLFormMoreInfoCell()

@property (nonatomic, strong) UIView *sepLine;
@property (nonatomic, strong) UIButton *foldButton;
@end

@implementation WLFormMoreInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self renderViews];
    }
    return self;
}

- (void)renderViews {
    [self.contentView addSubview:self.sepLine];
    [self.contentView addSubview:self.foldButton];
}

- (void)foldClick {
    
}

- (UIView *)sepLine {
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        _sepLine.backgroundColor = sepLineColor;
    }
    return _sepLine;
}

- (UIButton *)foldButton {
    if (!_foldButton) {
        _foldButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _foldButton.frame = CGRectMake(0, 10, SCREEN_WIDTH, 44);
        [_foldButton setTitle:@"更多信息(选填)" forState:UIControlStateNormal];
        [_foldButton addTarget:self action:@selector(foldClick) forControlEvents:UIControlEventTouchUpInside];
        [_foldButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _foldButton;
}

@end
