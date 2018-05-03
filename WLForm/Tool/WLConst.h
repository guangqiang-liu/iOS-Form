//
//  WLConst.h
//  WLStaticList
//
//  Created by 刘光强 on 2018/4/26.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#ifndef WLConst_h
#define WLConst_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define MinX(v) CGRectGetMinX((v).frame)
#define MinY(v) CGRectGetMinY((v).frame)
#define MidX(v) CGRectGetMidX((v).frame)
#define MidY(v) CGRectGetMidY((v).frame)
#define MaxX(v) CGRectGetMaxX((v).frame)
#define MaxY(v) CGRectGetMaxY((v).frame)

#define WLCellHeight 44
#define WLMarginLeft 10
#define WLMarginTop 8
#define WLMarginRight 10

#define WLTitleWidthLimit 200

#define WLSectionHeaderHeight 0
#define WLSectionFooterHeight 0

#define WLLeftTitleFont [UIFont systemFontOfSize:14]
#define WLRightTitleFont [UIFont systemFontOfSize:14]
#define WLSectionTitleFont [UIFont systemFontOfSize:14]

#define WLLeftImageWidth 30
#define WLLeftImageHeight 30
#define WLRightImageWidth 30
#define WLRightImageHeight 30
#define WLRightArrowWidth 30
#define WLRightArrowHeight 30

#define WLLeftTitleColor [UIColor blackColor]
#define WLRightTitleColor [UIColor blackColor]

#define WLSectionHeaderBgColor [UIColor whiteColor]
#define WLSectionFooterBgColor [UIColor grayColor]

#import "FontConst.h"
#import "ColorConst.h"

#endif /* WLConst_h */
