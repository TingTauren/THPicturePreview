//
//  ProgressView.m
//  THScrollerPickDemo
//
//  Created by mac on 16/6/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ProgressView.h"

#define   DEGREES_TO_RADIANS(degrees) (M_PI*2 * degrees)

@implementation ProgressView {
    //创建全局属性的ShapeLayer
    CAShapeLayer *_shapeLayer;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _percent = 0;
        _width = 0;
    }
    
    return self;
}

- (void)setPercent:(float)percent{
    _percent = percent;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [self addArcBackColor];
    [self drawArc];
    [self addCenterBack];
    [self addCenterLabel];
}

- (void)addArcBackColor{//!< 添加背景环
    UIColor *color = (_arcBackColor == nil) ? [UIColor lightGrayColor] : _arcBackColor;
    [color set];  //设置线条颜色
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetWidth(self.bounds)/2)
                                                         radius:CGRectGetWidth(self.bounds)/2- (_width > 0 ? _width/2 : 5.0/2)
                                                     startAngle:0
                                                       endAngle:DEGREES_TO_RADIANS(1)
                                                      clockwise:YES];
    
    aPath.lineWidth = _width > 0 ? _width : 5.0;
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    
    [aPath stroke];
}

- (void)drawArc{
    if (_percent == 0 || (int)_percent > 1) {
        return;
    }
    
    UIColor *color = _arcFinishColor;
    [color set];  //设置线条颜色
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetWidth(self.bounds)/2)
                                                         radius:CGRectGetWidth(self.bounds)/2- (_width > 0 ? _width/2 : 5.0/2)
                                                     startAngle:0
                                                       endAngle:DEGREES_TO_RADIANS(_percent)
                                                      clockwise:YES];
    
    aPath.lineWidth = _width > 0 ? _width : 5.0;
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    
    [aPath stroke];
    
}

-(void)addCenterBack{
    float width = (_width == 0) ? 5 : _width;
    
    CGColorRef color = (_centerColor == nil) ? [UIColor whiteColor].CGColor : _centerColor.CGColor;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    // Draw the slices.
    CGFloat radius = viewSize.width / 2 - width;
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius,0,2*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, color);
    CGContextFillPath(contextRef);
}

- (void)addCenterLabel{
    NSString *percent = @"";
    
    float fontSize = 14;
    UIColor *arcColor = [UIColor blueColor];
    if ((int)_percent == 1) {
        percent = @"100%";
        fontSize = 14;
        arcColor = (_arcFinishColor == nil) ? [UIColor blueColor] : _arcFinishColor;
        
    } else if(_percent < 1 && _percent >= 0){
        
        fontSize = 13;
        arcColor = (_arcUnfinishColor == nil) ? [UIColor blueColor] : _arcUnfinishColor;
        percent = [NSString stringWithFormat:@"%0.2f%%",_percent*100];
    }

    CGSize viewSize = self.bounds.size;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize],NSFontAttributeName,arcColor,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    
    [percent drawInRect:CGRectMake(5, (viewSize.height-fontSize)/2, viewSize.width-10, fontSize)withAttributes:attributes];
}

@end
