//
//  LVTableCellRegistrator.m
//  TableViewTest
//
//  Created by Vyacheslav on 6/21/17.
//  Copyright © 2017 myself. All rights reserved.
//

#import "LVTableCellRegistrator.h"

@implementation LVTableCellRegistrator

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _registeredIds = [NSMutableSet new];
    }
    return self;
}

- (void)registerClass:(Class)cellClass withReuseIdentifier:(NSString *)reuseIdentifier {
    if ([self.registeredIds containsObject:reuseIdentifier]) {
        return;
    }
    if ([self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier]) {
        [self.registeredIds addObject:reuseIdentifier];
        return;
    }
    
    NSString *className = NSStringFromClass(cellClass);
    NSAssert(![className isEqualToString:reuseIdentifier], @"Class name and reuseIdentifier must be same");
    
    NSBundle *bundle = [NSBundle bundleForClass:cellClass];
    if ([bundle pathForResource:reuseIdentifier ofType:@"nib"]) {
        [self.tableView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:bundle] forCellReuseIdentifier:reuseIdentifier];
    }
    else {
        [self.tableView registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
    }
    [self.registeredIds addObject:reuseIdentifier];
}

@end
