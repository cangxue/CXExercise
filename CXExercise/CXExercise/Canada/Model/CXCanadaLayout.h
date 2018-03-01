//
//  CXCanadaLayout.h
//  CXExercise
//
//  Created by xiaoma on 2018/3/1.
//  Copyright © 2018年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXCanadaModel.h"

#define kCellTagPadding 8         // tag 留白

@interface CXCanadaLayout : NSObject

- (instancetype)initWithCanada:(CXCanadaModel *)canada;

- (void)layout; // 计算布局

@property (nonatomic, strong) CXCanadaModel *canada;

// 标题
@property (nonatomic, assign) CGFloat titleHeight; //标题栏高度，0为没标题栏

// 描述
@property (nonatomic, assign) CGFloat descriptionHeight; //标题栏高度，0为没标题栏
@property (nonatomic, assign) CGSize descriptionSize;
    
// 图片
@property (nonatomic, strong) UIImage *pic;
@property (nonatomic, assign) CGFloat picHeight; //图片高度，0为没图片
@property (nonatomic, assign) CGSize picSize;

// 总高度
@property (nonatomic, assign) CGFloat height;

@end

