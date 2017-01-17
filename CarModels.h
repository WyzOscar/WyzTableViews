//
//  CarModels.h
//  红方投资
//
//  Created by Wyz on 16/3/3.
//  Copyright © 2016年 LWP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModels : NSObject
/**
 *  型号id
 */
@property(nonatomic,copy)NSString *id;
/**
 *
 */
@property(nonatomic,copy)NSString *autohomeId;
/**
 *  型号名称
 */
@property(nonatomic,copy)NSString *name;
/**
 *  车系id
 */
@property(nonatomic,copy)NSString *seriesId;


/**
 *  系列名称 立阳
 */
@property(nonatomic,copy)NSString *series_name;
/**
 *  车系id
 */
@property(nonatomic,copy)NSString *series_id;
@end
