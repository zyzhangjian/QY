//
//  LPRefreshIndicator.m
//  LPRefresh
//
//  Created by FineexMac on 16/1/6.
//  Copyright © 2016年 LPiOS. All rights reserved.
//
//  作者GitHub主页 https://github.com/SwiftLiu
//  作者邮箱 1062014109@qq.com
//  下载链接 https://github.com/SwiftLiu/LPRefresh.git

#import "LPRefreshIndicator.h"
#import "GCD.h"
///主题颜色
#define LPRefreshMainColor(_alpha) [UIColor colorWithWhite:0.7 alpha:_alpha]
///图片路径
#define LPRefreshSrcName(file) [@"LPRefresh.bundle" stringByAppendingPathComponent:file]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

///下拉到此偏移量开始拉伸
const CGFloat LPBeganStretchOffset = 36;
///下拉到此偏移量开始刷新
const CGFloat LPBeganRefreshOffset = 90;

const CGFloat LPRefreshMargin = 3;
const NSTimeInterval LPRefreshAnimateDuration = 0.5;

@interface LPRefreshIndicator ()
{
    //绘制视图
    CALayer *drawLayer;

    //指示器图标
    UIImage *image;
    
    //状态
    BOOL refreshing;
    //执行控制
    BOOL shouldDo;
    
    //是否在进行回弹动画
    BOOL backing;
    //回弹动画结束立即执行结束的动画
    void (^backCompleteBlock)();
    
    //刷新成功提示
    NSAttributedString *capionSuccess;
    //刷新失败提示
    NSAttributedString *capionFail;
}
@end

@interface LPRefreshIndicator()

//指示器
@property(nonatomic,strong) UIActivityIndicatorView *indicatorView;

@end

@implementation LPRefreshIndicator

#pragma mark - 设置下拉偏移量
- (void)setPullProgress:(CGFloat)pullProgress
{
    if (pullProgress == _pullProgress) return;
    if (!refreshing) {
        //①开始拖出
        if (pullProgress <= LPBeganStretchOffset) {
            if (_pullProgress<=3 && pullProgress>3) {
                shouldDo = YES;
                [self drawHeight:LPBeganStretchOffset];//绘制圆
            }
        }
        //②拉伸阶段
        else if (pullProgress < LPBeganRefreshOffset) {
            if (shouldDo) [self drawHeight:pullProgress];//绘制橡皮筋
        }
        //③开始刷新
        else if (shouldDo) {
            shouldDo = NO;
            refreshing = YES;
            [self backAnimate:LPBeganRefreshOffset];//回弹动画
            if (_refreshBlock) _refreshBlock();//执行刷新代码
        }
    }
    //④刷新状态下回弹需停顿
    else if (_pullProgress > LPBeganStretchOffset && pullProgress < LPBeganStretchOffset) {
        [self superviewScrollTo:-LPBeganStretchOffset];//滚动
        
    }
    _pullProgress = pullProgress;
    
    //高度位置
    CGRect frame = self.frame;
    frame.size.height = MAX(LPBeganStretchOffset, pullProgress);
    frame.origin.y = -frame.size.height;
    self.frame = frame;
}

#pragma mark - 橡皮筋自动回弹动画
- (void)backAnimate:(CGFloat)animateH
{
    backing = YES;//回弹动画执行中
    //橡皮筋回弹
    CGFloat endOffset = LPBeganStretchOffset+15;//回弹结束偏移量
    if (animateH >= endOffset) {
        animateH -= 3;
        [self drawHeight:animateH];
        //循环调用
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.014 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self backAnimate:animateH];
        });
    }
    //显示指示器
    else{
       
        drawLayer.contents = nil;
        
        [self.indicatorView startAnimating];
        
        backing = NO;//回弹动画结束
        if (backCompleteBlock) {
            backCompleteBlock();
            backCompleteBlock = nil;
        }
    }
}

#pragma mark - 结束刷新
- (void)refreshSuccess:(BOOL)isSuccess
{
    if (refreshing) {
        //正在进行回弹动画时，结束动画放在回弹动画结束后执行
        if (backing) {
            __weak LPRefreshIndicator *weakSelf = self;
            backCompleteBlock = ^{
                refreshing = NO;
                [weakSelf endAnimate:isSuccess];
            };
        }
        //未进行回弹动画时，直接执行结束动画
        else {
            refreshing = NO;
            [self endAnimate:isSuccess];
        }
    }
}

#pragma mark - 结束动画
- (void)endAnimate:(BOOL)isSuccess
{

    if (_pullProgress==LPBeganStretchOffset) {
        
        [self superviewScrollTo:0];//滚动到顶部
        
    }
    
    [[GCDQueue mainQueue] execute:^{
        
        [self.indicatorView removeFromSuperview];
        self.indicatorView = nil;
        
    }];
}

-(UIActivityIndicatorView *)indicatorView {
    
    if (_indicatorView == nil) {
        
        //指示器
        _indicatorView = [UIActivityIndicatorView new];
        _indicatorView.center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, LPBeganStretchOffset/2.l);
        _indicatorView.color = [UIColor grayColor];
        [self addSubview:_indicatorView];

    }
    
    return _indicatorView;
}

#pragma mark - 绘制
- (void)drawHeight:(CGFloat)h
{
    //初始化画布
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGSize size = drawLayer.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, screenScale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    //拉伸度
    CGFloat s = (h-LPBeganStretchOffset) / (LPBeganRefreshOffset-LPBeganStretchOffset);
    // ①绘制橡皮筋部分
    //阴影颜色
    drawLayer.shadowColor = [UIColor colorWithWhite:0 alpha:.6+.4*s].CGColor;
    //填充颜色
    CGColorRef color = UIColorFromRGB(0x40c996).CGColor;
    if (refreshing) color = UIColorFromRGB(0x40c996).CGColor;
    CGContextSetFillColorWithColor(ctx, color);
    //大圆半径
    CGFloat w = size.width / 2.l;
    CGFloat R = w - w*.3 * (backing?1:s);
    //坐标移动至大圆圆心
    CGContextTranslateCTM(ctx, w, w+LPRefreshMargin);
    //小圆半径
    CGFloat r = (backing?.4:1)*w*(1-s)+3*s;
    //小圆圆心
    CGPoint o = CGPointMake(0, h-w-r-LPRefreshMargin*2);
    //各曲线交点
    double agl = M_PI_2 / 9.l;
    CGPoint a1 = CGPointMake(-R*cos(agl), R*sin(agl));
    CGPoint a2 = CGPointMake(-a1.x, a1.y);
//    CGPoint b1 = CGPointMake(-r, o.y);
    CGPoint b2 = CGPointMake(r, o.y);
    //贝塞尔曲线控制点
    CGPoint c1 = CGPointMake(-r, o.y/2.l);
    CGPoint c2 = CGPointMake(-c1.x, c1.y);
    //路径
    CGContextMoveToPoint(ctx, a2.x, a2.y);
    CGContextAddArc(ctx, 0, 0, R, agl, 2*M_PI+agl, NO);
    CGContextAddQuadCurveToPoint(ctx, c2.x, c2.y, b2.x, b2.y);
    CGContextAddArc(ctx, o.x, o.y, r, 0, M_PI, NO);
    CGContextAddQuadCurveToPoint(ctx, c1.x, c1.y, a1.x, a1.y);
    //绘制路径
    CGContextDrawPath(ctx, kCGPathFill);
    
    // ②绘制图片
    CGFloat wide = 2*R*0.7l;
    CGRect frame = CGRectMake(-wide/2.l, -wide/2.l, wide, wide);
    //旋转坐标系
    CGContextRotateCTM(ctx, s * M_PI*1.5);
    if (!image) image = [UIImage imageNamed:@"LPRefresh_pull"];
    [image drawInRect:frame];
    
    //提取绘制图像
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(ctx);
    CGContextRelease(ctx);
    UIGraphicsEndImageContext();
    drawLayer.contents = (__bridge id _Nullable)(img.CGImage);
}


#pragma mark - 重写
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, 0, LPBeganStretchOffset);
        self.clipsToBounds = YES;
        
        //图层
        drawLayer = [CALayer layer];
        CGFloat wide = LPBeganStretchOffset-2*LPRefreshMargin;
        drawLayer.frame = CGRectMake(0, 0, wide, LPBeganRefreshOffset);
        [self.layer addSublayer:drawLayer];
        drawLayer.shadowRadius = 1;
        drawLayer.shadowOffset = CGSizeMake(0, 1);
        drawLayer.shadowOpacity = 0.1;
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if (self.frame.size.width != frame.size.width) {
        [self centerSub:frame.size.width];
    }
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    if (self.bounds.size.width != bounds.size.width) {
        [self centerSub:bounds.size.width];
    }
    [super setBounds:bounds];
}


//drawLayer居中
- (void)centerSub:(CGFloat)width
{
    CGRect frame = drawLayer.frame;
    frame.origin.x = (width - frame.size.width) / 2.l;
    drawLayer.frame = frame;
    
    CGPoint center = self.indicatorView.center;
    center.x = width / 2.l;
    self.indicatorView.center = center;
    
}


#pragma mark - 辅助方法
//滚动
- (void)superviewScrollTo:(CGFloat)offsetY
{

    UIScrollView *scrollView = (UIScrollView *)[self superview];
    if (scrollView) {
        CGPoint offset = scrollView.contentOffset;
        offset.y = 0;
        [scrollView setContentOffset:offset animated:YES];
    }
}

//提示文字
- (NSAttributedString *)endCapion:(BOOL)isSuccess
{
    if (isSuccess) {
        if (!capionSuccess) {
            capionSuccess = [self attributedString:@"刷新成功"
                                           imgName:LPRefreshSrcName(@"LPRefresh_ok")];
        }
        return capionSuccess;
    }else {
        if (!capionFail) {
            capionFail = [self attributedString:@"刷新失败"
                                        imgName:LPRefreshSrcName(@"LPRefresh_fail")];
        }
        return capionFail;
    }
}

- (NSAttributedString *)attributedString:(NSString *)capion imgName:(NSString *)imgName
{
    //提示图标
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.image = [UIImage imageNamed:imgName];
    CGSize size = attachment.image.size;
    attachment.bounds = CGRectMake(0, -2.5l, size.width, size.height);
    NSAttributedString *imgAttrStr = [NSAttributedString attributedStringWithAttachment:attachment];
    //提示文字
    NSString *str = [NSString stringWithFormat:@" %@", capion];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
    [attrString insertAttributedString:imgAttrStr atIndex:0];
    return attrString;
}

@end
