//
//  WyzTableViewMenu.m
//
//  Created by wyz on 16-06-25.
//  Copyright (c) 2016年 wyz. All rights reserved.
//

#import "WyzTableViewMenu.h"
#import "CarBrandCell.h"
NSString *const IDENTIFIER = @"CELL";

NSString *const CARBRANDCELL=@"CarBrandCell";

@interface WyzTableViewMenu () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    NSArray *tables;
    UIView *bgView;
}
/**
 *  索引数组
 */
@property(nonatomic,strong)NSMutableArray *indexArray;
@end

@implementation WyzTableViewMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化选择项
        for(int i=0; i!=3; ++i) {
            sels[i] = -1;
        }
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.userInteractionEnabled = YES;
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = self.frame;
        [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        // 初始化菜单
        tables = @[[[UITableView alloc] init], [[UITableView alloc] init], [[UITableView alloc] init] ];
        [tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger idx, BOOL *stop) {
            /**
             *  显示品牌的cell
             */
            if(idx==0){
                //初始化索引数组
                self.indexArray=[NSMutableArray array];
            
                for(char c ='A';c<='Z';c++){
                    //当前字母
                    
                    NSString *zimu=[NSString stringWithFormat:@"%c",c];
                    //排除 i o u v字母
                    if (![zimu isEqualToString:@"I"]&&![zimu
                                                   isEqualToString:@"O"]&&![zimu
                                                                            isEqualToString:@"U"]&&![zimu isEqualToString:@"V"]){
                        
                        [self.indexArray addObject:[NSString stringWithFormat:@"%c",c]];
                        
                    }
                    
                }
                UINib *CarBrandCell = [UINib nibWithNibName:CARBRANDCELL bundle:nil];
                [table registerNib:CarBrandCell forCellReuseIdentifier:CARBRANDCELL];
                //改变索引的颜色
                table.sectionIndexColor = [UIColor blueColor];
                //改变索引选中的背景颜色
                table.sectionIndexTrackingBackgroundColor = [UIColor grayColor];

            }else{
                
                [table registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER ];
            }
            table.dataSource = self;
            table.delegate = self;
            table.frame = CGRectMake(0, 0, 0, 0);
            table.backgroundColor = [UIColor clearColor];
            table.tableFooterView = [UIView new];
        }];
        bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:.0f green:.0f blue:.0f alpha:.3f];
        bgView.userInteractionEnabled = YES;
        [bgView addSubview:[tables objectAtIndex:0] ];
    }
    return self;
}

#pragma mark private
/**
 *  调整每个tableview的位置、大小
 */
- (void)adjustTableViews{
    int w = SCREEN_WIDTH;
    int __block showTableCount = 0;
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        CGRect rect = t.frame;
        rect.size.height = SCREEN_HEIGHT - bgView.frame.origin.y;
        t.frame = rect;
        if(t.superview)
            ++showTableCount;
    }];
    
    for(int i=0; i!=showTableCount; ++i){
        UITableView *t = [tables objectAtIndex:i];
        CGRect f = t.frame;
        f.size.width = w / showTableCount;
        f.origin.x = f.size.width * i;
        t.frame = f;
    }
}
/**
 *  取消选择
 */
- (void)cancel{
    [self dismiss];
    if([self.delegate respondsToSelector:@selector(assciationMenuViewCancel)]) {
        [self.delegate assciationMenuViewCancel];
    }
}

/**
 *  保存table选中项
 */
- (void)saveSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        sels[idx] = t.superview ? t.indexPathForSelectedRow.row : -1;
    }];
}

/**
 *  加载保存的选中项
 */
- (void)loadSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger i, BOOL *stop) {
        [t selectRowAtIndexPath:[NSIndexPath indexPathForRow:sels[i] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        if((sels[i] != -1 && !t.superview) || !i) {
            [bgView addSubview:t];
        }
    }];
}

#pragma mark public
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3 {
    sels[0] = idx_1;
    sels[1] = idx_2;
    sels[2] = idx_3;
}

- (void)showAsDrawDownView:(UIView *)view {
    CGRect showFrame = view.frame;
    CGFloat x = 0.f;
    CGFloat y = showFrame.origin.y+showFrame.size.height;
    CGFloat w = SCREEN_WIDTH;
    CGFloat h = SCREEN_HEIGHT-y;
    bgView.frame = CGRectMake(x, y, w, h);
    if(!bgView.superview) {
        [self addSubview:bgView];
    }
    [self loadSels];
    [self adjustTableViews];
    if(!self.superview) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        self.alpha = .0f;
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = 1.0f;
        }];
    }
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
}

- (void)dismiss{
    if(self.superview) {
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = .0f;
        } completion:^(BOOL finished) {
            [bgView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            [self removeFromSuperview];
        }];
    }
}

#pragma mark UITableViewDateSourceDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == [tables objectAtIndex:0]){
        CarBrandCell *cell=[tableView dequeueReusableCellWithIdentifier:CARBRANDCELL];
        if (cell==nil) {
            cell= (CarBrandCell *)[[[NSBundle  mainBundle]  loadNibNamed:CARBRANDCELL owner:self options:nil]  lastObject];
        }
        BrandModel *model=[_delegate assciationMenuView:self titleForClass_1:indexPath.row];
        cell.model =model;
        return cell;
        return cell;
    }else if(tableView == [tables objectAtIndex:1]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
        CarSeriesModel *seriesModel=[_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:indexPath.row];
        cell.textLabel.text = seriesModel.name;
        return cell;
    }else if(tableView == [tables objectAtIndex:2]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
        CarModels *model= [_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:((UITableView*)tables[1]).indexPathForSelectedRow.row class_3:indexPath.row];
        cell.textLabel.text=model.name;
        return cell;
    }
    return nil;
}


//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView==[tables objectAtIndex:0]) {
        return self.indexArray;
        
    }
    return 0;
}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
   
    if(tableView==[tables objectAtIndex:0]){
        [tableView  scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index-4]
                          atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        
        return index-4;
        
    }
    return 0;

}

//返回每个索引的内容
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView==[tables objectAtIndex:0]){
        
        return [self.indexArray objectAtIndex:section];
    }
    return nil;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger __block count;
    [tables enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==0) {
            count=[_delegate assciationMenuView:self sectionForClass:idx];
            *stop=YES;
        }
        
    }];
    return count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger __block count;
    [tables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(obj == tableView) {
            count = [_delegate assciationMenuView:self countForClass:idx];
            *stop = YES;
        }
    }];
    return count;
}



#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableView *t0 = [tables objectAtIndex:0];
    UITableView *t1 = [tables objectAtIndex:1];
    UITableView *t2 = [tables objectAtIndex:2];
    BOOL isNexClass = true;
    if(tableView == t0){
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:indexPath.row];
        }
        if(isNexClass) {
            [t1 reloadData];
            if(!t1.superview) {
                [bgView addSubview:t1];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self adjustTableViews];
        }else{
            if(t1.superview) {
                [t1 removeFromSuperview];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self saveSels];
            [self dismiss];
        }
    }else if(tableView == t1) {
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:indexPath.row];
        }
        if(isNexClass){
            [t2 reloadData];
            if(!t2.superview) {
                [bgView addSubview:t2];
            }
            [self adjustTableViews];
        }else{
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self saveSels];
            [self dismiss];
        }
    }else if(tableView == t2) {
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:class3:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:t1.indexPathForSelectedRow.row class3:indexPath.row];
        }
        if(isNexClass) {
            [self saveSels];
            [self dismiss];
        }
    }
}

@end
