//
//  CarBrandCell.h
//  AssociationMenuViewTest
//
//  Created by Wyz on 16/6/27.
//  Copyright © 2016年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandModel.h"
@interface CarBrandCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
/**
 *  车辆品牌模型
 */
@property(nonatomic,strong)BrandModel *model;
@end
