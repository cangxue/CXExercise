//
//  CXCanadaCell.h
//  CXExercise
//
//  Created by xiaoma on 2018/3/1.
//  Copyright © 2018年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXCanadaLayout.h"

@class CXCanadaCell;

@interface CXCanadaView: UIView
@property (nonatomic, strong) UIView *contentView; // 容器
@property (nonatomic, strong) UILabel *canada_titleLabel; // 标题
@property (nonatomic, strong) UILabel *canada_descriptionLabel; // 描述
@property (nonatomic, strong) UIImageView *canada_img; // 图片

@property (nonatomic, strong) CXCanadaLayout *layout;
@property (nonatomic, weak) CXCanadaCell *cell;
    
@end

@interface CXCanadaCell : UITableViewCell

@property (nonatomic, strong) CXCanadaView *canadaView;
- (void)setLayout:(CXCanadaLayout *)layout;

@end
