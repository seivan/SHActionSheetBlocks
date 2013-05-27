SHKeyValueObserverBlocks
==========

Overview
--------

Prefixed self cleaning (can be deactivated) block based observers on NSObject. 



Installation
------------

```ruby
pod 'SHKeyValueObserverBlocks'
```

***

Setup
-----

Put this either in specific controllers or your project prefix file

```objective-c
#import 'NSObject+SHKeyValueObserverBlocks.h'
```
or
```objective-c
#import 'SHKeyValueObserverBlocks.h'
```

Usage
-----

With SHKeyValueObserverBlocks you can observe with all optins toggled in a single block:

```objective-c
  NSString * identifier = [self SH_addObserverForKeyPaths:@[@"mutableArray",@"mutableSet"] block:^(id weakSelf, NSString *keyPath, NSDictionary *change) {
    NSLog(@"identifier: %@ - %@",change, keyPath);
  }];


``` 

or if you want setup manual options

```objective-c
-(NSString *)SH_addObserverForKeyPaths:(id<NSFastEnumeration>)theKeyPaths
                           withOptions:(NSKeyValueObservingOptions)theOptions
                                 block:(SHKeyValueObserverBlock)theBlock;

```


Configuration
------ 

You can turn of the auto removal of observers and blocks by setting

```objective-c
+(void)SH_isAutoRemovingObservers:(BOOL)shouldRemoveObservers;

```

In the destinationViewController

```objective-c
self.myDate = self.SH_userInfo[@"date"];
```

or

```objective-c
  [self SH_performSegueWithIdentifier:@"push" 
        andDestionationViewController:^(UIViewController * theDestinationViewController) {

    theDestinationViewController.SH_userInfo = myDictionary

  }];

``` 

Existing Codebase 
-----------------

If you already have  

```objective-c
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
``` 

implemented and used within your code base you can use the block handler

```objective-c
-(BOOL)SH_handlesBlockForSegue:(UIStoryboardSegue *)theSegue;
```

Like this 

```objective-c
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  UIViewController * destionationVc = segue.destinationViewController;
  destionationVc.SH_userInfo = nil;
  if([self SH_handlesBlockForSegue:segue])
    NSLog(@"Performed segueue programatically user info: %@", destionationVc.SH_userInfo);
  else
    NSLog(@"Performed unwind segueue via IB");
}

```
That will check if there is block **and** if there is - execute it. 

Replacing
---------

```objective-c
[self performSegueWithIdentifier:@"theIdentifier" sender:@"lolz"];
```

and then implementing the callback

```objective-c
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
  UIViewController * destinationViewController = segue.destinationViewController;
  destionationViewController.whateverPropety = sender;
}
```


Contact
-------

If you end up using SHSegueBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHSegueBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHSegueBlocks/blob/master/LICENSE.md) file.