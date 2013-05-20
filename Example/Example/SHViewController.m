//
//  SHViewController.m
//  Example
//
//  Created by Seivan Heidari on 5/14/13.
//  Copyright (c) 2013 Seivan Heidari. All rights reserved.
//




#import "SHViewController.h"

@interface SHViewController ()
-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;
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

@implementation SHViewController
@synthesize name;
-(void)viewDidLoad;{
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated; {
  [super viewDidAppear:animated];
  [self addObserver:<#(NSObject *)#> forKeyPath:<#(NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(void *)#>]
  [self SH_performSegueWithIdentifier:@"push" andPrepareForSegueBlock:^(UIStoryboardSegue *theSegue) {
    id<SHExampleProtocol> destionationController =   theSegue.destinationViewController;
    destionationController.name = theSegue.identifier;
  }];

}

-(IBAction)unwinder:(UIStoryboardSegue *)theSegue;{

}


@end
