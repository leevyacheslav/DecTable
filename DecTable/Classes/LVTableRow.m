//
//  LVTableRow.m
//  TableViewTest
//
//  Created by Vyacheslav on 6/21/17.
//  Copyright © 2017 myself. All rights reserved.
//

#import "LVTableRow.h"

@implementation LVTableRow

- (instancetype)initWithCellClass:(Class)cellClass {
    self = [super init];
    if (self) {
        _cellClass = cellClass;
        _reuseIdentifier = NSStringFromClass(cellClass);
    }
    return self;
}

- (instancetype)initWithCellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier {
    self = [self initWithCellClass:cellClass];
    if (self) {
        _reuseIdentifier = reuseIdentifier;
    }
    return self;
}

@end
