//
//  ExampleTests.m
//  ExampleTests
//
//  Created by Seivan Heidari on 7/27/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//


#import "SHActionSheetBlocks.h"
#import <SenTestingKit/SenTestingKit.h>



@interface SHActionSheetBlocksSuper : SenTestCase

@property(nonatomic,strong) UIViewController    * vc;
@property(nonatomic,strong) UIActionSheet       * sheet;
@property(nonatomic,copy)   SHActionSheetBlock  block;

@end

