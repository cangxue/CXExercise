//
//  CXCanadaModel.h
//  CXExercise
//
//  Created by xiaoma on 2018/3/1.
//  Copyright © 2018年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCanadaModel : NSObject

/// 标题
@property (nonatomic, copy) NSString *canada_title;

/// 描述
@property (nonatomic, copy) NSString *canada_description;

/// 图片链接
@property (nonatomic, copy) NSString *canada_imageHref;
 
/// 加载的图片
@property (nonatomic, strong) UIImage *canada_img;

@end
