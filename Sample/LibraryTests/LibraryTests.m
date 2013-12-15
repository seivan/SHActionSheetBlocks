//
//  LibraryTests.m
//  LibraryTests
//
//  Created by Seivan Heidari on 2013-12-15.
//  Copyright (c) 2013 Seivan. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LibraryTests : XCTestCase

@end

@implementation LibraryTests

-(void)setUp;{
  [super setUp];
}

-(void)tearDown; {
  [super tearDown];
}

-(void)testExample; {
  XCTAssertEqualObjects(UILabel.new, UILabel.new);
}

-(void)testExampleTwo; {
  id lol = UILabel.new;
  XCTAssertEqualObjects(lol, lol);
}

@end
