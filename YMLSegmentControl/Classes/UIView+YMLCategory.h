
#import <UIKit/UIKit.h>

@interface UIView (YMLCategory)

/** x坐标 */
@property (nonatomic, assign) CGFloat yml_x;

/** y坐标 */
@property (nonatomic, assign) CGFloat yml_y;

/** 中心点x坐标 */
@property (nonatomic, assign) CGFloat yml_centerX;

/** 中心点y坐标 */
@property (nonatomic, assign) CGFloat yml_centerY;

/** 宽度 */
@property (nonatomic, assign) CGFloat yml_width;

/** 高度 */
@property (nonatomic, assign) CGFloat yml_height;

/** 尺寸 */
@property (nonatomic, assign) CGSize  yml_size;

/** 坐标点 */
@property (nonatomic, assign) CGPoint yml_origin;


@end

