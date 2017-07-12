//
//  LVTableSection.h
//  TableViewTest
//
//  Created by Vyacheslav on 6/21/17.
//  Copyright © 2017 myself. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LVTableRow;

@interface LVTableSection : NSObject

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic) CGFloat headerHeight;
@property (nonatomic) CGFloat footerHeight;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

- (instancetype)initWithHeaderTitle:(NSString *)title headerHeight:(CGFloat)height;
- (instancetype)initWithHeaderView:(UIView *)view height:(CGFloat)height;

- (void)addRow:(LVTableRow *)row;
- (void)addRows:(NSArray <LVTableRow *> *)rows;
- (NSArray <LVTableRow *> *)rows;
- (NSInteger)rowsCount;
- (LVTableRow *)rowAtIndex:(NSInteger)index;
- (void)removeRowAtIndex:(NSInteger)index;
- (void)removeRow:(LVTableRow *)row;
- (BOOL)isEmpty;

@end
