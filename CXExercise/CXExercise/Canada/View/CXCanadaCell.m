//
//  CXCanadaCell.m
//  CXExercise
//
//  Created by xiaoma on 2018/3/1.
//  Copyright © 2018年 CX. All rights reserved.
//

#import "CXCanadaCell.h"

@implementation CXCanadaView
    
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = 1;
    }
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    _contentView = [UIView new];
    _contentView.width = kScreenWidth;
    _contentView.height = 1;
    _contentView.backgroundColor = [UIColor whiteColor];
   
    [self addSubview:_contentView];
    
    _canada_titleLabel = [UILabel new];
    _canada_titleLabel.numberOfLines = 0;
    _canada_titleLabel.textColor = [UIColor blueColor];
    _canada_titleLabel.font = [UIFont systemFontOfSize:17.0];
    [_contentView addSubview:_canada_titleLabel];

    
    _canada_descriptionLabel = [UILabel new];
    _canada_descriptionLabel.numberOfLines = 0;
    _canada_titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_contentView addSubview:_canada_descriptionLabel];
    
    _canada_img = [UIImageView new];
    [_contentView addSubview:_canada_img];
    
    return self;
}
    
- (void)setLayout:(CXCanadaLayout *)layout {
    _layout = layout;
    self.height = layout.height;
    _contentView.top = kCellTagPadding;
    _contentView.height = layout.height - 2*kCellTagPadding;
    
    CGFloat top = 0;

    if (layout.titleHeight > 0) {
        _canada_titleLabel.hidden = NO;
        _canada_titleLabel.text = layout.canada.canada_title;
        _canada_titleLabel.frame = CGRectMake(kCellTagPadding, 0, kScreenWidth - 2*kCellTagPadding, layout.titleHeight);
        
        top = layout.titleHeight;
    } else {
        _canada_titleLabel.hidden = YES;
    }

    
    if (layout.picHeight > 0) {
        CGSize picSize = layout.picSize;
        _canada_img.hidden = NO;
        _canada_img.image = layout.pic;
        _canada_img.frame = CGRectMake(kScreenWidth - picSize.width, top, picSize.width, layout.picHeight);
    } else {
        _canada_img.hidden = YES;
    }
    
    if (layout.descriptionHeight > 0) {
        _canada_descriptionLabel.text = layout.canada.canada_description;
        _canada_descriptionLabel.hidden = NO;
        if (layout.picSize.width == kScreenWidth - 2*kCellTagPadding) {
            _canada_descriptionLabel.frame = CGRectMake(kCellTagPadding, top + layout.picHeight, layout.descriptionSize.width, layout.descriptionHeight);
        } else {
            _canada_descriptionLabel.frame = CGRectMake(kCellTagPadding, top, layout.descriptionSize.width, layout.descriptionHeight);
        }
        
        _canada_descriptionLabel.frame = CGRectMake(kCellTagPadding, top, layout.descriptionSize.width, layout.descriptionHeight);
        
    } else {
        _canada_descriptionLabel.hidden = YES;
    }
}
    
@end

@implementation CXCanadaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _canadaView = [CXCanadaView new];
    _canadaView.cell = self;
    [self.contentView addSubview:_canadaView];
    return self;
}

- (void)setLayout:(CXCanadaLayout *)layout {
    self.height = layout.height;
    self.contentView.height = layout.height;
    _canadaView.layout = layout;
}

@end
