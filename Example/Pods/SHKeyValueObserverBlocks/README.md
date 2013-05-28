SHKeyValueObserverBlocks
==========

Overview
--------

#### [Check the creating section](https://github.com/seivan/SHKeyValueObserverBlocks#creating)

You can setup observers with all options on multiple keypaths

You can setup observers with specified options on multiple keypaths 

#### [Check the removing section](https://github.com/seivan/SHKeyValueObserverBlocks#removing)

You can remove based on a list of keypaths or identifiers.

You can remove based on both a list of keypaths and and identifiers

#### [Check the configuration section](https://github.com/seivan/SHKeyValueObserverBlocks#configuration)

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

### Creating

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