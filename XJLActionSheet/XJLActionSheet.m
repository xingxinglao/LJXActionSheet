//
//  XJLActionSheet.m
//  mayc
//
//  Created by 劳景醒 on 16/3/18.
//  Copyright © 2016年 laojingxing. All rights reserved.
//

#import "XJLActionSheet.h"
#import "UIViewExt.h"
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define labelFont  [UIFont systemFontOfSize:18]
#define labelTextColor [UIColor blackColor]
#define labelHeight 50

#define titleFont [UIFont boldSystemFontOfSize:18]
#define titleTextColor [UIColor redColor]


@implementation XJLActionSheet

- (instancetype)initWithDelegate:(id)delegate title:(NSString *)title cancelButton:(NSString *)cancelButton otherTitle:(NSString *)otherTitle, ...
{
    
    self = [super init];
    if (self) {
        self.delgate = delegate;
        
        // 装其他参数的数组
        NSMutableArray *args = [NSMutableArray array];
        // 定义一个指向参数的列表指针
        va_list params;
        va_start(params, otherTitle);
        if (otherTitle) {
            // 把第一个参数添加到数组里面
            [args addObject:otherTitle];
            
            id arg;
            // va_list 指向下一个地址
            while ((arg = va_arg(params, id)))
            {
                if (arg) {
                    [args addObject:arg];
                }
            }
            // 置空
            va_end(params);
        }
        
        self.titleNameArr = [NSMutableArray arrayWithObject:title];
        
        [self.titleNameArr addObjectsFromArray:args];
        
        [self.titleNameArr addObject:cancelButton];
        
        if (title.length != 0) {
            _titleName = title;
        }
        [self _initSubViews];
    }
    
    return self;
}

- (void)_initSubViews
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [UIColor blackColor];
    self.alpha = .3;
    
    // 父视图高
    CGFloat parentViewHeight = self.titleNameArr.count * labelHeight + self.titleNameArr.count + 10;
    
    // 创建装Label的父视图
    _parentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, parentViewHeight)];
    _parentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // 创建Label
    for (NSInteger i = 0; i < self.titleNameArr.count; i++) {
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, i * (labelHeight+1), SCREEN_WIDTH, labelHeight)];
        
        myLabel.userInteractionEnabled = YES;
        myLabel.tag = i;
        myLabel.text = self.titleNameArr[i];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.font = labelFont;
        myLabel.textColor = labelTextColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        myLabel.backgroundColor = [UIColor whiteColor];
        [myLabel addGestureRecognizer:tap];
        [_parentView addSubview:myLabel];
        
        // 如果有标题的话
        if (self.titleName.length > 0) {
            if (i == 0) {
                myLabel.font = titleFont;
                myLabel.textColor = titleTextColor;
                
            }
        }
        
        if (i == self.titleNameArr.count - 1) {
            myLabel.top += 10;
        }
    }
}


#pragma mark - MyActionSheet Delegate
- (void)myActionSheet:(XJLActionSheet *)actionSheet parentView:(UIView *)parentView subLabel:(UILabel *)subLabel index:(NSInteger)index
{
    
}


#pragma mark - tapAction
- (void)tapAction:(UIGestureRecognizer *)gesture
{
    UILabel *label = (UILabel *)gesture.view;
    if (self.delgate && [_delgate respondsToSelector:@selector(myActionSheet:parentView:subLabel:index:)]) {
        [self.delgate myActionSheet:self parentView:_parentView subLabel:label index:label.tag];
    }
    
    [self hiddenAnimation];
}


// 显示
- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:.35 animations:^{
        
        _parentView.top = SCREEN_HEIGHT - _parentView.height;
    }];
    [window addSubview:_parentView];
}

// 隐藏
- (void)hiddenAnimation
{
    [UIView animateWithDuration:.35 animations:^{
        _parentView.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenAnimation];
}



@end
