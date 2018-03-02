//
//  CXCanadaLayout.m
//  CXExercise
//
//  Created by xiaoma on 2018/3/1.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "CXCanadaLayout.h"
#import "CXTool.h"

@implementation CXCanadaLayout
- (instancetype)initWithCanada:(CXCanadaModel *)canada {
    if (!canada) return nil;
    
    self = [super init];
    
    _canada = canada;
    
    [self layout];
    
    return self;

}
    
- (void)layout {
    CGFloat titleHeight = 0;
    CGFloat descriptionHeight = 0;
    CGFloat picHeight = 0;
    
    titleHeight = [CXTool heightForText:_canada.canada_title width:kScreenWidth - 2*kCellTagPadding font:17];
    
    if(_canada.canada_imageHref.length > 0) { // 有图片
        _picSize = [self loadImageSize];
        picHeight = _picSize.height;

        if (_picSize.width == kScreenWidth - 2*kCellTagPadding) {
            descriptionHeight = [CXTool heightForText:_canada.canada_description width:kScreenWidth - 2*kCellTagPadding font:15] + 30;
            _descriptionSize = CGSizeMake(kScreenWidth - 2*kCellTagPadding, descriptionHeight);
        } else {
            descriptionHeight = [CXTool heightForText:_canada.canada_description width:kScreenWidth - 2*kCellTagPadding - _picSize.width font:15] + 30;
            _descriptionSize = CGSizeMake(kScreenWidth - 2*kCellTagPadding - _picSize.width, descriptionHeight);
        }

    } else {
        descriptionHeight = [CXTool heightForText:_canada.canada_description width:kScreenWidth - 2*kCellTagPadding font:15] + 30;
        
        _descriptionSize = CGSizeMake(kScreenWidth - 2*kCellTagPadding, descriptionHeight);
    }
    
    _titleHeight = titleHeight;
    _descriptionHeight = descriptionHeight;
    _picHeight = picHeight;

    _height = titleHeight + MAX(descriptionHeight, picHeight);
}

- (CGSize)loadImageSize {
    CGSize tempsize = CGSizeZero;
    __block UIImage *cachedImage = nil;
    
    cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_canada.canada_imageHref];
    
    if (!cachedImage) {
        tempsize = CGSizeMake(120, 60);
        _pic = [UIImage imageNamed:@"placeholderImg"];
       
    } else {
        _pic = cachedImage;
        _canada.canada_img = cachedImage;
        CGSize size = cachedImage.size;
        CGFloat width = 120;
        CGFloat height = size.height *(width/size.width);
        
        
        tempsize = CGSizeMake(width, height);
    }
    
    return tempsize;
    
}
@end
