# YMLSegmentControl
A simple and easy to use segment control.

> 当前版本：`1.0.1`

## How To Use

- 引入

	```objc
	#import <YMLSegmentControl/YMLSegmentControl.h>
	```

- 初始化并使用`block`处理点击事件

	```objc
	YMLSegmentControl *segmentControl = [[YMLSegmentControl alloc] initWithFrame:frame titles:titles selectBlock:^(NSInteger index) {
		NSLog(@"click at index : %ld",index); 
	}];
	```

- 或者使用`delegate`处理点击事件

	```objc
	segmentControl.delegate = self;
	
	#pragma mark -- YMLSegmentControlDelegate
	- (void)segmentControl:(YMLSegmentControl *)segmentControl didSelectedAtIndex:(NSInteger)index{
	    NSLog(@"click at index : %ld",index);
	}
	```
	
## Installation

YMLSegmentControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YMLSegmentControl'
```

## Author

[HuberyYang](http://www.huberyyang.com)

Email: yml_hubery@sina.com


## License

YMLSegmentControl is available under the MIT license. See the LICENSE file for more info.
