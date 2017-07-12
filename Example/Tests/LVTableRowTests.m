//
//  LVTableRowTests.m
//  DecTable
//
//  Created by Vyacheslav on 7/12/17.
//  Copyright © 2017 Vyacheslav. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DecTable/LVDecTable.h>


@interface LVTableRowTests : XCTestCase

@end

@implementation LVTableRowTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTableRowInitWithClass {
    LVTableRow *tableRow = [[LVTableRow alloc] initWithCellClass:[NSString class]];
    XCTAssertEqualObjects([NSString class], tableRow.cellClass, @"Class must be same");
    XCTAssertEqualObjects(tableRow.reuseIdentifier, NSStringFromClass([NSString class]), @"Class name and reuseIdentifier must be same");
}

- (void)testTableRowInitClassAndReuseIdentifier {
    NSString *reuseIdentifier = @"TestIdentifier";
    Class rowClass = [NSString class];
    LVTableRow *tableRow = [[LVTableRow alloc] initWithCellClass:rowClass reuseIdentifier:reuseIdentifier];
    XCTAssertEqualObjects(rowClass, tableRow.cellClass, @"Class must be same");
    XCTAssertEqualObjects(tableRow.reuseIdentifier, reuseIdentifier, @"Class name and reuseIdentifier must be same");
}

@end
