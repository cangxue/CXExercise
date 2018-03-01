//
//  CXTool.m
//  CXExercise
//
//  Created by xiaoma on 2018/3/1.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "CXTool.h"

@implementation CXTool
    
#pragma mark - 计算文本高度
+ (CGFloat)heightForText:(NSString *)text width:(CGFloat)width font:(CGFloat)size
    {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
        CGSize aSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:Nil].size;
        return aSize.height;
    }
    
    
@end
