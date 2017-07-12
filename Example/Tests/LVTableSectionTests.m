//
//  LVTableSectionTests.m
//  DecTable
//
//  Created by Vyacheslav on 7/12/17.
//  Copyright © 2017 vahob@utilitynyc.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DecTable/LVDecTable.h>

@interface LVTableSectionTests : XCTestCase

@property (nonatomic, strong) LVTableSection *section;

@end

@implementation LVTableSectionTests

- (void)setUp {
    [super setUp];
    self.section = [LVTableSection new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    self.section = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithHeaderTitle {
    NSString *title = @"TestTitle";
    CGFloat height = 44.0;
    LVTableSection *section = [[LVTableSection alloc] initWithHeaderTitle:title headerHeight:height];
    XCTAssertEqualObjects(title, section.headerTitle, @"Section title equality");
    XCTAssertTrue(height == section.headerHeight, @"Section height equality");
}

- (void)testInitWithHeaderView {
    UIView *view = [UIView new];
    CGFloat height = 44.0;
    LVTableSection *section = [[LVTableSection alloc] initWithHeaderView:view height:height];
    XCTAssertEqualObjects(view, section.headerView, @"Section headerView equality");
    XCTAssertTrue(height == section.headerHeight, @"Section height equality");
}

- (void)testEmptyRows {
    XCTAssertTrue(self.section.isEmpty, @"Rows must be empty");
}

- (void)testAddRow {
    LVTableRow *row = [LVTableRow new];
    [self.section addRow:row];
    XCTAssertEqualObjects(row, self.section.rows.firstObject, @"Row must be added");
}

- (void)testAddRows {
    LVTableRow *row = [LVTableRow new];
    LVTableRow *row1 = [LVTableRow new];
    NSArray *rows = @[row, row1];
    [self.section addRows:rows];
    XCTAssertTrue(self.section.rows.count == rows.count, @"Rows count must be equal");
}

- (void)testRowsCount {
    XCTAssertTrue(self.section.rows.count == self.section.rowsCount, @"Rows count must be equal");
}

- (void)testRowAtIndex {
    LVTableRow *row = [LVTableRow new];
    [self.section addRow:row];
    XCTAssertEqualObjects(row, [self.section rowAtIndex:0], @"Row must be same");
}

- (void)testRemoveRowAtIndex {
    LVTableRow *row = [LVTableRow new];
    [self.section addRow:row];
    NSInteger index = [self.section.rows indexOfObject:row];
    [self.section removeRowAtIndex:index];
    XCTAssertFalse([self.section.rows containsObject:row], @"Section not contain removed row");
}

- (void)testRemoveRow {
    LVTableRow *row = [LVTableRow new];
    [self.section addRow:row];
    [self.section removeRow:row];
    XCTAssertFalse([self.section.rows containsObject:row], @"Section not contain removed row");
}

@end
