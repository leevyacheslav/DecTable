	//
//  LVTableDirector.m
//  TableViewTest
//
//  Created by Vyacheslav on 6/21/17.
//  Copyright © 2017 myself. All rights reserved.
//

#import "LVTableDirector.h"
#import "LVTableSection.h"
#import "LVTableRow.h"
#import "LVTableCellRegistrator.h"

static const NSString *kRemoveDefaultTitle = @"Delete";
static const CGFloat kDefaultRowHeight = 44.0;

@interface LVTableDirector () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sections;

@end

@implementation LVTableDirector

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _tableView.delegate  = self;
        _tableView.dataSource  = self;
        _sections = [NSMutableArray new];
        _animation = UITableViewRowAnimationAutomatic;
        _cellRegsitrator = [[LVTableCellRegistrator alloc] initWithTableView:tableView];
    }
    return self;
}

#pragma mark - Public

- (void)setDimension {
    self.tableView.estimatedRowHeight = kDefaultRowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)reload {
    [self.tableView reloadData];
}

- (void)clear {
    [self.sections removeAllObjects];
}

#pragma mark - Sections

- (void)addSection:(LVTableSection *)section {
    [self.sections addObject:section];
}

- (void)addSections:(NSArray <LVTableSection *> *)sections {
    [self.sections addObjectsFromArray:sections];
}

- (void)removeSectionAtIndex:(NSInteger)index {
    [self.sections removeObjectAtIndex:index];
}

- (void)removeSection:(LVTableSection *)section {
    [self.sections removeObject:section];
}

- (void)removeRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    [self removeRowAtIndexPath:indexPath];
    if (animated) {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:self.animation];
        [self.tableView endUpdates];
    }
}

- (LVTableSection *)sectionAtIndex:(NSInteger)index {
    if (index < self.sections.count) {
        LVTableSection *section = self.sections[index];
        return section;
    }
    return nil;
}

#pragma mark - Rows

- (void)addRow:(LVTableRow *)row {
    LVTableSection *section = [self defaultSection];
    [section addRow:row];
}

- (void)addRows:(NSArray <LVTableRow *> *)rows {
    [[self defaultSection] addRows:rows];
}

- (void)removeRow:(LVTableRow *)row {
    [[self defaultSection] removeRow:row];
}

- (void)removeRowAtIndex:(NSInteger)index {
    [[self defaultSection] removeRowAtIndex:index];
}

#pragma mark - Utils

- (LVTableSection *)defaultSection {
    LVTableSection *section = self.sections.firstObject;
    if (section == nil) {
        section = [LVTableSection new];
        [self addSection:section];
    }
    return section;
}

- (void)removeRowAtIndexPath:(NSIndexPath *)indexPath {
    LVTableSection *section = self.sections[indexPath.section];
    [section removeRowAtIndex:indexPath.row];
    if (section.isEmpty) {
        [self removeSection:section];
    }
}

- (NSInteger)sectionsCount {
    if (self.sections.count == 0) {// section count always should be >= 1
        return 1;
    }
    return self.sections.count;
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self sectionsCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LVTableSection *lvsection = [self sectionAtIndex:section];
    return lvsection.rowsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LVTableRow *row = [[self sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];
    [self.cellRegsitrator registerClass:row.class withReuseIdentifier:row.reuseIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:row.reuseIdentifier forIndexPath:indexPath];
    if (row.config) {
        row.config(cell, indexPath);
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self sectionAtIndex:section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return  [self sectionAtIndex:section].footerTitle;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LVTableRow *row = [[self sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];
    if (row.didSelect) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        row.didSelect(cell, indexPath);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self sectionAtIndex:section].headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self sectionAtIndex:section].footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat heigth = [self sectionAtIndex:section].footerHeight;
    return heigth == 0.0 ? UITableViewAutomaticDimension : heigth;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat heigth = [self sectionAtIndex:section].headerHeight;
    return heigth == 0.0 ? UITableViewAutomaticDimension : heigth;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    LVTableRow *row = [[self sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];
    NSString *title = row.removeTitle ?: kRemoveDefaultTitle;
    return title;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    LVTableRow *row = [[self sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];
    return row.remove != nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LVTableRow *row = [[self sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row];
        if (row.remove) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            row.remove(cell, indexPath);
        }
    }
}

@end
