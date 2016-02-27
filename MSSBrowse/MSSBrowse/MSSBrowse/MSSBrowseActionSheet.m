//
//  MSSBrowseActionSheet.m
//  MSSBrowse
//
//  Created by 于威 on 16/2/14.
//  Copyright © 2016年 于威. All rights reserved.
//

#define kBrowseActionSheetSpace 10.0f
#define kBrowseActionSheetCellHeight 44.0f

#import "MSSBrowseActionSheet.h"
#import "MSSBrowseDefine.h"
#import "MSSBrowseActionSheetCell.h"

@interface MSSBrowseActionSheet ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,copy)NSString *cancelTitle;
@property (nonatomic,copy)MSSBrowseActionSheetDidSelectedAtIndexBlock selectedBlock;
@property (nonatomic,assign)CGFloat tableViewHeight;
@property (nonatomic,strong)UIView *maskView;

@end

@implementation MSSBrowseActionSheet

- (instancetype)initWithTitleArray:(NSArray *)titleArray cancelButtonTitle:(NSString *)cancelTitle didSelectedBlock:(MSSBrowseActionSheetDidSelectedAtIndexBlock)selectedBlock
{
    self = [super initWithFrame:CGRectZero];
    if(self)
    {
        _titleArray = titleArray;
        _cancelTitle = cancelTitle;
        _selectedBlock = selectedBlock;
        _tableViewHeight = (_titleArray.count + 1) * kBrowseActionSheetCellHeight + kBrowseActionSheetSpace;
        [self createBrowseActionSheet];
    }
    return self;
}

- (void)createBrowseActionSheet
{
    _maskView = [[UIView alloc]init];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0.3;
    [self addSubview:_maskView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.bounces = NO;
    [self addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        return kBrowseActionSheetSpace;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor lightGrayColor];
        return view;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return _titleArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    MSSBrowseActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell == nil)
    {
        cell = [[MSSBrowseActionSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.titleLabel.frame = CGRectMake(0, 0, self.mssWidth, kBrowseActionSheetCellHeight);
    cell.bottomLineView.hidden = YES;
    if(indexPath.section == 0)
    {
        cell.titleLabel.text = _titleArray[indexPath.row];
        if(_titleArray.count > indexPath.row + 1)
        {
            cell.bottomLineView.frame = CGRectMake(0, kBrowseActionSheetCellHeight - 1, self.mssWidth,1);
            cell.bottomLineView.hidden = NO;
        }
    }
    else
    {
        cell.titleLabel.text = _cancelTitle;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(_selectedBlock)
        {
            _selectedBlock(indexPath.row);
        }
    }
    [self disMissActionSheet];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self disMissActionSheet];
}

- (void)disMissActionSheet
{
    [UIView animateWithDuration:0.3 animations:^{
        [_tableView setMssY:self.mssHeight];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    self.frame = view.bounds;
    _maskView.frame = view.bounds;
    _tableView.frame = CGRectMake(0, self.mssHeight, self.mssWidth, _tableViewHeight);
    [UIView animateWithDuration:0.3 animations:^{
        [_tableView setMssY:self.mssHeight - _tableViewHeight];
    }];
}

// transform时更新frame
- (void)updateFrame
{
    if(self.superview)
    {
        self.frame = self.superview.bounds;
        _maskView.frame = self.superview.bounds;
        _tableView.frame = CGRectMake(0, self.mssHeight - _tableViewHeight, self.mssWidth, _tableViewHeight);
        [_tableView reloadData];
    }
}

@end
