SHGestureRecognizerBlocks
==========

Overview
--------

#### [Check the creating section](https://github.com/seivan/SHGestureRecognizerBlocks#creating)

Create blocks directly from convenience class selectors

Add additional blocks on the gesture recognizer

#### [Check the removing section](https://github.com/seivan/SHGestureRecognizerBlocks#removing)

You can remove based on a list of keypaths or identifiers.

You can remove based on both a list of keypaths and and identifiers

#### [Check the properties section](https://github.com/seivan/SHGestureRecognizerBlocks#properties)

NSSet with all active unqiue blocks



Installation
------------

```ruby
pod 'SHGestureRecognizerBlocks'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import 'UIGestureRecognizer+SHGestureRecognizerBlocks.h'
```
or
```objective-c
#import 'SHGestureRecognizerBlocks.h'
```

Usage
-----

### Creating

With SHGestureRecognizerBlocks you can set auto-removed blocks instead of using selectors

```objective-c
  UITapGestureRecognizer * tapRecognizer = [UITapGestureRecognizer SH_gestureRecognizerWithBlock:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    NSLog(@"callback");
  }];

  [self.view addGestureRecognizer:tapRecognizer];

``` 

or if you want add additional blocks

```objective-c

  UITapGestureRecognizer * tapRecognizer = [UITapGestureRecognizer SH_gestureRecognizerWithBlock:block];

  SHGestureRecognizerBlock block = ^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    NSLog(@"CALLBACK block1");
  };


  SHGestureRecognizerBlock block2 = ^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
    NSLog(@"CALLBACK block2");
  };

  [tapRecognizer SH_addBlock:block];
  [tapRecognizer SH_addBlock:block2];

  [self.view addGestureRecognizer:tapRecognizer];

```

### Removing


#### If you want to deal with the cleanup manually (I can understand if you want to avoid the Swizzle)

```objective-c
-(void)SH_removeAllObservers;
```

#### Get rid of all observers of certain keypaths (regardless of identifier)

```objective-c
-(void)SH_removeObserversForKeyPaths:(id<NSFastEnumeration>)theKeyPaths;
```

#### Get rid of all observers of certain identifiers (regardless of keypaths)

```objective-c
-(void)SH_removeObserversWithIdentifiers:(id<NSFastEnumeration>)theIdentifiers;
```

#### Get rid of all observers of certain keypaths with certain idenitifers;

```objective-c
-(void)SH_removeObserversForKeyPaths:(id<NSFastEnumeration>)theKeyPaths
                         withIdentifiers:(id<NSFastEnumeration>)theIdentifiers;
```

Configuration
------ 

You can turn off the auto removal of observers and blocks by setting

```objective-c
+(void)SH_isAutoRemovingObservers:(BOOL)shouldRemoveObservers;

```

Existing Codebase 
-----------------

If you already have  

```objective-c
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
``` 

implemented and used within your code base you can use the block handler

```objective-c
-(BOOL)SH_handleObserverForKeyPath:(NSString *)theKeyPath
                        withChange:(NSDictionary *)theChange
                           context:(void *)context;
```

Like this 

```objective-c
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;  {
  if([self SH_handleObserverForKeyPath:keyPath withChange:change context:context])
    NSLog(@"TAKEN CARE OF BY BLOCK");
  else
    NSLog(@"Take care of here!");
    
}
```
That will check if there is block **and** if there is - execute it. 

Replacing
---------

```objective-c
[self addObserver:self forKeyPath:@"mutableArray" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld|NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionPrior context:NULL]
```


Contact
-------

If you end up using SHKeyValueObserverBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHKeyValueObserverBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHKeyValueObserverBlocks/blob/master/LICENSE.md) file.