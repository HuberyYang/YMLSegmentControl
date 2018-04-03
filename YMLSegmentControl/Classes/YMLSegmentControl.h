
#import <UIKit/UIKit.h>

/** item布局样式 */
typedef NS_ENUM(NSUInteger, ItemsArrangeType) {
    ItemsArrangeByItemWidth = 0,  // 按 item 的 width 依次布局,此模式不显示下标线
    ItemsArrangeByEqualWidth,     // 每个 item 等宽布局
};

/** 回调block */
typedef void(^SelectedBlock)(NSInteger index);

@class YMLSegmentControl;
@protocol YMLSegmentControlDelegate<NSObject>
@optional;

- (void)segmentControl:(YMLSegmentControl *)segmentControl didSelectedAtIndex:(NSInteger)index;

@end



@interface YMLSegmentControl : UIView

/** items 布局方式，默认以 item 的宽度布局
 *  当 'arrangeType' 为 'ItemsArrangeByItemWidth' 时，'maxShowNum' 设置无效 */
@property (assign, nonatomic) ItemsArrangeType arrangeType;

/** 按钮选择回调 */
@property (copy, nonatomic) SelectedBlock selectedBlock;

/** delegate */
@property (weak, nonatomic) id<YMLSegmentControlDelegate>delegate;

/** 按钮标题 */
@property (strong, nonatomic) NSArray<NSString *> *titles;

/** 屏幕内最大显示按钮数，默认为4个 */
@property (assign, nonatomic) NSInteger maxShowNum;

/** item 间距，默认为10.0f */
@property (assign, nonatomic) CGFloat itemInter;

/** 下标线颜色 */
@property (strong, nonatomic) UIColor *markLineColor;

/** 下标线是否隐藏，默认NO */
@property (assign, nonatomic) BOOL markLineHidden;

/** 底部分割线颜色 */
@property (strong, nonatomic) UIColor *sepLineColor;

/** 按钮背景色 */
@property (strong, nonatomic) UIColor *buttonBackgroundColor;

/** 按钮选中状态颜色 */
@property (strong, nonatomic) UIColor *buttonSelectColor;

/** 按钮未选中状态颜色 */
@property (strong, nonatomic) UIColor *buttonNormalColor;

/** 按钮标题字体 */
@property (strong, nonatomic) UIFont *buttonFont;

/** 当前选中的下标 */
@property (assign, nonatomic) NSInteger selectedIndex;

/** 动画持续时间，默认 0.2s */
@property (assign, nonatomic) CGFloat animationDuration;


/// init
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectBlock:(SelectedBlock)selectedBlock;

/// 从外部设置选中的button，不会触发回调block
- (void)itemSelectedAtIndex:(NSInteger)index;




@end
