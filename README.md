SHActionSheetBlocks
==========

Screenshots
------------
[![Green default](/Screenshots/Green/default_th.jpg "Green default")](https://raw.github.com/seivan/SHActionSheetBlocks/develop/Screenshots/Green/default.png)
[![Green selected](/Screenshots/Green/selected_th.jpg "Green selected")](https://raw.github.com/seivan/SHActionSheetBlocks/develop/Screenshots/Green/selected.png)
[![Green cancel-selected](/Screenshots/Green/cancel-selected_th.jpg "Green cancel-selected")](https://raw.github.com/seivan/SHActionSheetBlocks/develop/Screenshots/Green/cancel-selected.png)

[![Blue default](/Screenshots/Blue/default_th.jpg "Blue default")](https://raw.github.com/seivan/SHActionSheetBlocks/develop/Screenshots/Blue/default.png)
[![Blue selected](/Screenshots/Blue/selected_th.jpg "Blue selected")](https://raw.github.com/seivan/SHActionSheetBlocks/develop/Screenshots/Blue/selected.png)
[![Blue cancel-selected](/Screenshots/Blue/cancel-selected_th.jpg "Blue cancel-selected")](https://raw.github.com/seivan/SHActionSheetBlocks/develop/Screenshots/Blue/cancel-selected.png)

[![Purple default](/Screenshots/Purple/default_th.jpg "Purple default")](https://raw.github.com/seivan/SHActionSheetBlocks/develop/Screenshots/Purple/default.png)
[![Purple selected](/Screenshots/Purple/selected_th.jpg "Purple selected")](https://raw.github.com/seivan/SHActionSheetBlocks/develop/Screenshots/Purple/selected.png)
[![Purple cancel-selected](/Screenshots/Purple/cancel-selected_th.jpg "Purple cancel-selected")](https://raw.github.com/seivan/SHActionSheetBlocks/develop/Screenshots/Purple/cancel-selected.png)

Overview
--------
The blocks are automatically removed once the sheet is gone, so it isn't necessary to clean up - Swizzle Free(™)

### API

#### [Init](https://github.com/seivan/SHActionSheetBlocks#init-1)

#### [Add](https://github.com/seivan/SHActionSheetBlocks#add-1)

#### [Properties](https://github.com/seivan/SHActionSheetBlocks#properties-1)


Installation
------------

```ruby
pod 'SHActionSheetBlocks'
```

***

Setup
-----

Put this either in specific files or your project prefix file

```objective-c
#import 'UIActionSheet+SHActionSheetBlocks.h'
```
or
```objective-c
#import 'SHActionSheetBlocks.h'
```

API
-----

### Init

```objective-c
#pragma mark -
#pragma mark Init
+(instancetype)SH_actionSheetWithTitle:(NSString *)theTitle;

```

### Add

```objective-c
#pragma mark -
#pragma mark Add
-(NSUInteger)SH_addButtonWithTitle:(NSString *)theTitle
                      withBlock:(SHActionSheetBlock)theBlock;

-(NSUInteger)SH_setDestructiveButtonWithTitle:(NSString *)theTitle
                                 withBlock:(SHActionSheetBlock)theBlock;

-(NSUInteger)SH_setCancelButtonWithTitle:(NSString *)theTitle
                            withBlock:(SHActionSheetBlock)theBlock;

```

### Properties

```objective-c
#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Setters

-(void)SH_setWillShowBlock:(SHActionSheetWillShowBlock)theBlock;
-(void)SH_setDidShowBlock:(SHActionSheetDidShowBlock)theBlock;

-(void)SH_setWillDismissBlock:(SHActionSheetWillDismissBlock)theBlock;
-(void)SH_setDidDismissBlock:(SHActionSheetDidDismissBlock)theBlock;

#pragma mark -
#pragma mark Getters


@property(nonatomic,readonly) SHActionSheetWillShowBlock    SH_blockWillShow;
@property(nonatomic,readonly) SHActionSheetDidShowBlock     SH_blockDidShow;

@property(nonatomic,readonly) SHActionSheetWillDismissBlock SH_blockWillDismiss;
@property(nonatomic,readonly) SHActionSheetDidDismissBlock  SH_blockDidDismiss;

```


Contact
-------

If you end up using SHActionSheetBlocks in a project, I'd love to hear about it.

email: [seivan.heidari@icloud.com](mailto:seivan.heidari@icloud.com)  
twitter: [@seivanheidari](https://twitter.com/seivanheidari)

## License

SHActionSheetBlocks is © 2013 [Seivan](http://www.github.com/seivan) and may be freely
distributed under the [MIT license](http://opensource.org/licenses/MIT).
See the [`LICENSE.md`](https://github.com/seivan/SHActionSheetBlocks/blob/master/LICENSE.md) file.

