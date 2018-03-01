//
//  CXCanadaModel.m
//  CXExercise
//
//  Created by xiaoma on 2018/3/1.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "CXCanadaModel.h"
#import "CXTool.h"

@implementation CXCanadaModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"canada_title" : @"title",
             @"canada_description" : @"description",
             @"canada_imageHref" : @"imageHref",
             };
}

MJCodingImplementation

@end


