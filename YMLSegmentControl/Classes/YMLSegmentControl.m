
#import "YMLSegmentControl.h"
#import "UIView+YMLCategory.h"

#define sWidth  self.frame.size.width
#define sHeight self.frame.size.height
#define sRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0f]

@interface YMLSegmentControl ()

/** 存放按钮 */
@property (strong, nonatomic) NSMutableArray<UIButton *> *buttons;

/** 下标线 */
@property (strong, nonatomic) UIImageView *markLineV;

/** 底部分割线 */
@property (strong, nonatomic) UIImageView *sepLine;

/** scrollView */
@property (strong, nonatomic) UIScrollView *bgScrollView;

@end

@implementation YMLSegmentControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initWithTitles:nil selectBlock:nil];
    }   
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithTitles:nil selectBlock:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectBlock:(SelectedBlock)selectedBlock{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithTitles:titles selectBlock:selectedBlock];
    }
    return self;
}

- (void)initWithTitles:(NSArray *)titles selectBlock:(SelectedBlock)selectedBlock{
    _titles = titles;
    _selectedBlock = selectedBlock;
    [self initBasicParameters];
    [self setupMainView];
    [self resetItems];
}

- (void)initBasicParameters{
    _buttons = [NSMutableArray array];
    _maxShowNum = 4;
    _itemInter = 10.0f;
    _animationDuration = 0.2f;
    _buttonNormalColor = [UIColor darkGrayColor];
    _buttonBackgroundColor = [UIColor clearColor];
    _buttonFont = [UIFont systemFontOfSize:15.0f];
    _buttonSelectColor = sRGB(200, 20, 29);
    _markLineColor = sRGB(200, 20, 29);
    _sepLineColor = sRGB(220, 220, 220);
}

- (void)setupMainView{
    self.backgroundColor = [UIColor whiteColor];
    _bgScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _bgScrollView.backgroundColor = [UIColor clearColor];
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    _bgScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_bgScrollView];
    
    _markLineV = [[UIImageView alloc] initWithFrame:CGRectMake(0, sHeight - 2, 60, 1)];
    _markLineV.backgroundColor = _markLineColor;
    _markLineV.hidden = (_titles == nil || _titles.count == 0);
    [_bgScrollView addSubview:_markLineV];
    
    _sepLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, sHeight - 0.5f, sWidth, 0.5f)];
    _sepLine.backgroundColor = _sepLineColor;
    [self addSubview:_sepLine];
}

- (void)layoutSubviews{
    __block CGFloat btnW = 0, contentW = 0;
    if (self.arrangeType == ItemsArrangeByEqualWidth) {
        if (self.buttons.count >= self.maxShowNum) {
            btnW = (sWidth - (self.maxShowNum + 1) * self.itemInter) / self.maxShowNum;
        }
        else {
            btnW = (sWidth - (self.buttons.count + 1) * self.itemInter) / self.buttons.count;
        }
        [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
            btn.frame = CGRectMake(self.itemInter + (self.itemInter + btnW) * idx , 5, btnW, sHeight - 5 * 2);
        }];
        contentW = btnW * self.buttons.count + (self.buttons.count + 1) * self.itemInter;
    }
    else if (self.arrangeType == ItemsArrangeByItemWidth) {
        contentW = self.itemInter;
        [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
            btnW = [self.titles[idx] sizeWithAttributes:@{NSFontAttributeName:self.buttonFont}].width + 2;
            btn.frame = CGRectMake(contentW, 5, btnW, sHeight - 5 * 2);
            contentW += btnW + self.itemInter;
        }];
        contentW = contentW < self.bgScrollView.yml_width ? self.bgScrollView.yml_width : contentW;
    }
    self.bgScrollView.contentSize = CGSizeMake(contentW, sHeight);
    if (self.buttons.count) {
        self.markLineV.yml_width = self.buttons[self.selectedIndex].yml_width + self.itemInter;
        self.markLineV.yml_centerX = self.buttons[self.selectedIndex].yml_centerX;
    }
}

- (void)resetItems{
    [self.buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buttons removeAllObjects];
    if (!self.titles) return;
    for (int idx = 0; idx < self.titles.count; idx ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.titles[idx] forState:UIControlStateNormal];
        btn.tag = 2000 + idx;
        btn.selected = idx == 0;
        [btn addTarget:self action:@selector(itemDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:btn];
        [self.bgScrollView addSubview:btn];
    }
    [self layoutSubviews];
    [self buttonsConfiguration];
}

- (void)buttonsConfiguration{
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.titleLabel.font = self.buttonFont;
        btn.backgroundColor = self.buttonBackgroundColor;
        [btn setTitleColor:self.buttonNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.buttonSelectColor forState:UIControlStateSelected];
    }];
}

// 调整下标线位置
- (void)adjustButtonsPosition:(UIButton *)button{
    CGFloat btnX = button.yml_centerX;
    CGPoint bgOffset;
    if (btnX < sWidth / 2.0) {
        bgOffset = CGPointZero;
    }
    else if (btnX < self.bgScrollView.contentSize.width - sWidth / 2.0) {
        CGFloat offsetX = self.bgScrollView.contentOffset.x;
        CGFloat deviationX = button.yml_centerX - offsetX - sWidth / 2.0;
        offsetX += deviationX;
        bgOffset = CGPointMake(offsetX, 0);
    }
    else {
        bgOffset = CGPointMake(self.bgScrollView.contentSize.width - sWidth, 0);
    }
    [UIView animateWithDuration:self.animationDuration animations:^{
        if (self.arrangeType == ItemsArrangeByItemWidth) {
            self.markLineV.yml_width = button.yml_width + self.itemInter;
        }
        self.markLineV.yml_centerX = button.yml_centerX;
        self.bgScrollView.contentOffset = bgOffset;
    }];
}

// 根据选中按钮更新所有button状态
- (void)resetButtonsStatus:(UIButton *)button{
    for (UIButton *btn in self.buttons) {
        btn.selected = btn == button;
    }
}

// 按钮点击事件
- (void)itemDidClicked:(UIButton *)button{
    [self adjustButtonsPosition:button];
    [self resetButtonsStatus:button];
    NSInteger idx = button.tag - 2000;
    _selectedIndex = idx;
    if (self.selectedBlock) {
        self.selectedBlock(idx);
    }
    if ([self.delegate respondsToSelector:@selector(segmentControl:didSelectedAtIndex:)]) {
        [self.delegate segmentControl:self didSelectedAtIndex:idx];
    }
}

- (void)itemSelectedAtIndex:(NSInteger)index{
    if (index < 0 || index > self.buttons.count - 1) return;
    _selectedIndex = index;
    [self adjustButtonsPosition:self.buttons[index]];
    [self resetButtonsStatus:self.buttons[index]];
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self resetItems];
    self.markLineV.hidden = self.markLineHidden ?: (titles == nil || titles.count == 0);
}

- (void)setMaxShowNum:(NSInteger)maxShowNum{
    if (maxShowNum <= 0) return;
    _maxShowNum = maxShowNum;
}

- (void)setItemInter:(CGFloat)itemInter{
    if (itemInter < 0) return;
    _itemInter = itemInter;
}

- (void)setMarkLineColor:(UIColor *)markLineColor{
    _markLineColor = markLineColor;
    self.markLineV.backgroundColor = markLineColor;
}

- (void)setMarkLineHidden:(BOOL)markLineHidden{
    _markLineHidden = markLineHidden;
    self.markLineV.hidden = markLineHidden;
}

- (void)setSepLineColor:(UIColor *)sepLineColor{
    _sepLineColor = sepLineColor;
    self.sepLine.backgroundColor = sepLineColor;
}

- (void)setButtonFont:(UIFont *)buttonFont{
    _buttonFont = buttonFont;
    [self buttonsConfiguration];
}

- (void)setButtonNormalColor:(UIColor *)buttonNormalColor{
    _buttonNormalColor = buttonNormalColor;
    [self buttonsConfiguration];
}

- (void)setButtonSelectColor:(UIColor *)buttonSelectColor{
    _buttonSelectColor = buttonSelectColor;
    [self buttonsConfiguration];
}

- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor{
    _buttonBackgroundColor = buttonBackgroundColor;
    [self buttonsConfiguration];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex < 0 || selectedIndex > self.buttons.count - 1) return;
    _selectedIndex = selectedIndex;
    [self itemDidClicked:self.buttons[selectedIndex]];
}

- (void)setAnimationDuration:(CGFloat)animationDuration{
    if (animationDuration < 0) return;
    _animationDuration = animationDuration;
}



@end
