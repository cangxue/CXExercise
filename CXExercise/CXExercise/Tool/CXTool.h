//
//  CXTool.h
//  CXExercise
//
//  Created by xiaoma on 2018/3/1.
//  Copyright © 2018年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXTool : NSObject

// 计算文本高度
+ (CGFloat)heightForText:(NSString *)text width:(CGFloat)width font:(CGFloat)size;
@end
