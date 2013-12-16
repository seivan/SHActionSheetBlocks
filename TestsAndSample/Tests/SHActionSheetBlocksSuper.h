//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import <XCTest/XCTest.h>

#import "KIF.h"
#import "SHTestCaseAdditions.h"
#import "SHActionSheetBlocks.h"


@interface SHActionSheetBlocksSuper : KIFTestCase

@property(nonatomic,strong) UIViewController    * vc;
@property(nonatomic,strong) UIActionSheet       * sheet;
@property(nonatomic,copy)   SHActionSheetBlock  block;

@end

