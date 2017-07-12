//
//  LVTableCellRegistrator.h
//  TableViewTest
//
//  Created by Vyacheslav on 6/21/17.
//  Copyright © 2017 myself. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LVTableCellRegistrator : NSObject

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) NSMutableSet *registeredIds;

- (instancetype)initWithTableView:(UITableView *)tableView;
- (void)registerClass:(Class)cellClass withReuseIdentifier:(NSString *)reuseIdentifier;

@end
