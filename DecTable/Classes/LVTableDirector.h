//
//  LVTableDirector.h
//  TableViewTest
//
//  Created by Vyacheslav on 6/21/17.
//  Copyright © 2017 myself. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LVTableSection;
@class LVTableRow;
@class LVTableCellRegistrator;

@interface LVTableDirector : NSObject

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, readonly) LVTableCellRegistrator *cellRegsitrator;
// common animation
@property (nonatomic) UITableViewRowAnimation animation;

- (instancetype)initWithTableView:(UITableView *)tableView;
- (void)setDimension;
- (void)addSection:(LVTableSection *)section;
- (void)addSections:(NSArray <LVTableSection *> *)sections;
- (void)removeSectionAtIndex:(NSInteger)index;
- (void)removeSection:(LVTableSection *)section;
- (void)removeRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (LVTableSection *)sectionAtIndex:(NSInteger)index;
- (void)addRow:(LVTableRow *)row;
- (void)addRows:(NSArray <LVTableRow *> *)rows;
- (void)removeRow:(LVTableRow *)row;
- (void)removeRowAtIndex:(NSInteger)index;
- (void)reload;
- (void)clear;

@end
