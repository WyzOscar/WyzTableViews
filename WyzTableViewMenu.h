//
//  WyzTableViewMenu.h
//  iOSTest
//
//  Created by wyz on 16-06-25.
//  Copyright (c) 2016年 wyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandModel.h"
#import "CarSeriesModel.h"
#import "CarModels.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) // 获取屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) // 获取屏幕高度

@class WyzTableViewMenu;
@protocol WyzAssociationMenuViewDelegate <NSObject>

/**
 *  获取第class菜单的secion数量
 *
 *  @param asView 联想菜单
 *  @param idx    第几级
 *
 *  @return 组数量
 */
- (NSInteger)assciationMenuView:(WyzTableViewMenu*)asView sectionForClass:(NSInteger)idx;

/**
 *  获取第class级菜单的数据数量
 *
 *  @param asView 联想菜单
 *  @param idx    第几级
 *
 *  @return 第class级菜单的数据数量
 */
- (NSInteger)assciationMenuView:(WyzTableViewMenu*)asView countForClass:(NSInteger)idx;

/**
 *  获取第一级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *
 *  @return 品牌模型
 */
- (BrandModel*)assciationMenuView:(WyzTableViewMenu*)asView titleForClass_1:(NSInteger)idx_1;

/**
 *  获取第二级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *
 *  @return 车系模型
 */
- (CarSeriesModel*)assciationMenuView:(WyzTableViewMenu*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2;

/**
 *  获取第三级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *  @param idx_3  第三级
 *
 *  @return 型号模型
 */
- (CarModels*)assciationMenuView:(WyzTableViewMenu*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3;
@optional
/**
 *  取消选择
 */
- (void)assciationMenuViewCancel;

/**
 *  选择第一级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *
 *  @return 是否展示下一级
 */
- (BOOL)assciationMenuView:(WyzTableViewMenu*)asView idxChooseInClass1:(NSInteger)idx_1;
/**
 *  选择第二级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *
 *  @return 是否展示下一级
 */
- (BOOL)assciationMenuView:(WyzTableViewMenu*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2;
/**
 *  选择第三级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *  @param idx_3  第三级
 *
 *  @return 是否dismiss
 */
- (BOOL)assciationMenuView:(WyzTableViewMenu*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3;
@end

/**
 *  三级联动菜单
 */
@interface WyzTableViewMenu : UIView{
@private
    NSInteger sels[3];
}
extern __strong NSString *const IDENTIFIER;
@property (weak,nonatomic) id<WyzAssociationMenuViewDelegate> delegate;
/**
 *  设置选中项，-1为未选中
 *
 *  @param idx_1  第一级选中项
 *  @param idx_2  第二级选中项
 *  @param idx_3  第三级选中项
 */
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3;
/**
 *  菜单显示在View的下面
 *
 *  @param view 显示在该view下
 */
- (void)showAsDrawDownView:(UIView*) view;
/**
 *  隐藏菜单
 */
- (void)dismiss;
@end
