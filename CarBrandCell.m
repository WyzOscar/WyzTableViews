//
//  CarBrandCell.m
//  AssociationMenuViewTest
//
//  Created by Wyz on 16/6/27.
//  Copyright © 2016年 skytoup. All rights reserved.
//

#import "CarBrandCell.h"

@implementation CarBrandCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(BrandModel *)model{
    if (model!=nil) {
        _model=model;
        self.iconImageView.image=[UIImage imageNamed:model.name];
        self.brandNameLabel.text=model.name;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
