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

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context; {
//  NSLog(@"CALLBACK: %@",change);
//}
-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  self.mutableArray     = [@[] mutableCopy];
  self.mutableSet       = [NSMutableSet set];

  //  [self addObserver:self forKeyPath:@"mutableArray" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld|NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionPrior context:NULL];
  
  NSString * identifier = [self SH_addObserverForKeyPaths:@[@"mutableArray",@"mutableSet"] block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    NSLog(@"identifier: %@ - %@",change, keyPath);
  }];

  NSString * identifier2 = [self SH_addObserverForKeyPaths:@[@"mutableArray",@"mutableSet"] block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    NSLog(@"identifier2: %@ - %@",change,keyPath);
  }];

  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self SH_removeObserversForKeyPaths:@[@"mutableArray", @"mutableSet"] withIdentifiers:@[identifier]];
    [[self mutableArrayValueForKey:@"mutableArray"] addObject:@"DAAAAAAAAMNG"];
    [self SH_removeObserversWithIdentifiers:@[identifier2]];
    //self.mutableArray = @[].mutableCopy;
  });



  
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  UIViewController * destionationVc = segue.destinationViewController;
  destionationVc.SH_userInfo = nil;
  [self SH_handlesBlockForSegue:segue];
  
  
}



@end
