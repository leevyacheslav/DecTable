//
//  LVTableRow.h
//  TableViewTest
//
//  Created by Vyacheslav on 6/21/17.
//  Copyright © 2017 myself. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^LVTableRowBlock) (id cell, NSIndexPath *indexPath);

@interface LVTableRow : NSObject

@property (nonatomic, strong, readonly) NSString *reuseIdentifier;
// default is 0.0 wiil use UITableViewAutomaticDimension
@property (nonatomic) CGFloat height;
@property (nonatomic) BOOL autoDeselect;
@property (nonatomic, strong) NSString *removeTitle;
@property (nonatomic, readonly) Class cellClass;
@property (nonatomic, copy) LVTableRowBlock config;
@property (nonatomic, copy) LVTableRowBlock didSelect;
@property (nonatomic, copy) LVTableRowBlock remove;
// designed initializer
- (instancetype)initWithCellClass:(Class)cellClass;
- (instancetype)initWithCellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier;

@end
