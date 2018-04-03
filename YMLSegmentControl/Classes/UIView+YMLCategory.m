
#import "UIView+YMLCategory.h"

@implementation UIView (YMLCategory)

- (void)setYml_x:(CGFloat)yml_x{
    CGRect frame = self.frame;
    frame.origin.x = yml_x;
    self.frame = frame;
}

- (CGFloat)yml_x{
    return self.frame.origin.x;
}

- (void)setYml_y:(CGFloat)yml_y{
    CGRect frame = self.frame;
    frame.origin.y = yml_y;
    self.frame = frame;
}

- (CGFloat)yml_y{
    return self.frame.origin.y;
}

- (void)setYml_centerX:(CGFloat)yml_centerX{
    CGPoint center = self.center;
    center.x = yml_centerX;
    self.center = center;
}

- (CGFloat)yml_centerX{
    return self.center.x;
}

- (void)setYml_centerY:(CGFloat)yml_centerY{
    CGPoint center = self.center;
    center.y = yml_centerY;
    self.center = center;
}

- (CGFloat)yml_centerY{
    return self.center.y;
}

- (void)setYml_width:(CGFloat)yml_width{
    CGRect frame = self.frame;
    frame.size.width = yml_width;
    self.frame = frame;
}

- (CGFloat)yml_width{
    return self.frame.size.width;
}

- (void)setYml_height:(CGFloat)yml_height{
    CGRect frame = self.frame;
    frame.size.height = yml_height;
    self.frame = frame;
}

- (CGFloat)yml_height{
    return self.frame.size.height;
}

- (void)setYml_size:(CGSize)yml_size{
    CGRect freme = self.frame;
    freme.size = yml_size;
    self.frame = freme;
}

- (CGSize)yml_size{
    return self.frame.size;
}

- (void)setYml_origin:(CGPoint)yml_origin{
    CGRect frame = self.frame;
    frame.origin = yml_origin;
    self.frame   = frame;
}

- (CGPoint)yml_origin{
    return self.frame.origin;
}


@end
