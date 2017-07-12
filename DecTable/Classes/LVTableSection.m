//
//  LVTableSection.m
//  TableViewTest
//
//  Created by Vyacheslav on 6/21/17.
//  Copyright © 2017 myself. All rights reserved.
//

#import "LVTableSection.h"

@interface LVTableSection()

@property (nonatomic, strong, readonly) NSMutableArray *rows_;

@end

@implementation LVTableSection

- (instancetype)init {
    self = [super init];
    if (self) {
        _rows_ = [NSMutableArray new];
        _headerTitle = nil;
        _headerHeight = 0.0;
        _footerHeight = 0.0;
        _footerView = nil;
        _headerView = nil;
        _footerTitle = nil;
        _headerTitle = nil;
    }
    return self;
}

- (instancetype)initWithHeaderTitle:(NSString *)title headerHeight:(CGFloat)height {
    self = [self init];
    if (self) {
        _headerHeight = height;
        _headerTitle = title;
    }
    return self;
}

- (instancetype)initWithHeaderView:(UIView *)view height:(CGFloat)height {
    self = [self init];
    if (self) {
        _headerView = view;
        _headerHeight = height;
    }
    return self;
}

- (void)addRow:(LVTableRow *)row {
    [_rows_ addObject:row];
}

- (void)addRows:(NSArray <LVTableRow *> *)rows {
    [_rows_ addObjectsFromArray:rows];
}

- (NSArray <LVTableRow *> *)rows {
    return _rows_;
}

- (NSInteger)rowsCount {
    return _rows_.count;
}

- (LVTableRow *)rowAtIndex:(NSInteger)index {
    return _rows_[index];
}

- (void)removeRowAtIndex:(NSInteger)index {
    [_rows_ removeObjectAtIndex:index];
}

- (void)removeRow:(LVTableRow *)row {
    [_rows_ removeObject:row];
}

- (BOOL)isEmpty {
    return _rows_.count == 0;
}

@end
