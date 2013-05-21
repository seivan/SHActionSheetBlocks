//
//  SHSecondViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//

#import "SHSecondViewController.h"

@interface SHSecondViewController ()
-(IBAction)tapProgUnwind:(id)sender;
@property(nonatomic,strong) NSString * string;
@property(nonatomic,strong) NSMutableString * mutableString;

@property(nonatomic,strong) NSArray * array;
@property(nonatomic,strong) NSMutableArray * mutableArray;

@property(nonatomic,strong) NSDictionary * dictionary;
@property(nonatomic,strong) NSMutableDictionary * mutableDictionary;

@property(nonatomic,strong) NSSet * set;
@property(nonatomic,strong) NSMutableSet * mutableSet;

@property(nonatomic,strong) NSOrderedSet * orderedSet;
@property(nonatomic,strong) NSMutableOrderedSet * mutableOrderedSet;

@property(nonatomic,strong) NSNumber * number;

@end

@implementation SHSecondViewController
@synthesize name;

-(IBAction)tapProgUnwind:(id)sender; {
  //[self performSegueWithIdentifier:@"unwinder" sender:self];
  [self SH_performSegueWithIdentifier:@"unwinder" withUserInfo:@{@"date" : [NSDate date]}];
}


-(void)viewDidLoad;{
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  self.mutableArray       = [@[] mutableCopy];
//  __weak typeof(self) lol = self;
  [self SH_addObserverForKeyPaths:@[@"mutableArray"] task:^(id obj, NSString *keyPath, NSDictionary * change) {
    NSLog(@"KEYPATH: %@", keyPath);
    NSLog(@"OBJ: %@", obj);
    NSLog(@"%@", change);
//    [self.mutableArray addObject:@"zzzzzze"];
  }];

//  self.mutableString      = [@"LOL" mutableCopy];
//  self.mutableOrderedSet  = [NSMutableOrderedSet orderedSet];
//  self.mutableOrderedSet  = [NSMutableSet set];
//  self.number             = @(666);
  
  
//  [self SH_addObserverForKeyPaths:@[@"mutableString", @"number", @"mutableOrderedSet", @"mutableSet", @"mutableDictionary"] task:^(id obj, NSString *keyPath) {
//    NSLog(@"KEYPATH: %@", keyPath);
//    NSLog(@"OBJ: %@", obj);
//  }];
  
  [self.mutableArray addObject:@"FOCK"];
//  [self.mutableArray addObject:@"DAMN"];
//    [self.mutableArray addObject:@"DAMN"];
//    [self.mutableArray addObject:@"DAMN"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  UIViewController * destionationVc = segue.destinationViewController;
  destionationVc.SH_userInfo = nil;
  [self SH_handlesBlockForSegue:segue];
  
  
}



@end
