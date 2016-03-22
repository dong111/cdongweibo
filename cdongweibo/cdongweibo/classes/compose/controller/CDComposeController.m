//
//  CDComposeController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/22.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDComposeController.h"
#import "CDTextView.h"
#import "CDUitiity.h"
#import "CDComposeToolBar.h"

@interface CDComposeController ()<UITextViewDelegate>

@property (nonatomic,weak) CDComposeToolBar *toolBar;

@property (nonatomic,weak)   CDTextView *textView;
@end

@implementation CDComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //*** 一定要设置 否知view是透明的
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigation];
    
    //添加textView输入框
    [self setUpTextView];
    //添加工具bar
    [self setUpToolBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


#pragma mark - 键盘的Frame改变的时候调用
- (void) keyBoardChange:(NSNotification *)notif
{
    //    NSLog(@"%@",notifi.userInfo);
    
    //获取弹出键盘时间
    CGFloat duraTime = [notif.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    // 获取键盘的frame
    CGRect frame = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y==self.view.height) {//隐藏键盘
        [UIView animateWithDuration:duraTime animations:^{
            _toolBar.transform = CGAffineTransformIdentity;
        }];
    }else{
        [UIView animateWithDuration:duraTime animations:^{
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
    
}

- (void) setUpToolBar
{
    CGFloat barW = self.view.width;
    CGFloat barH = 35;
    CGFloat barX = 0;
    CGFloat bary = self.view.height-barH;
    CDComposeToolBar *toolBar = [[CDComposeToolBar alloc] initWithFrame:CGRectMake(barX, bary, barW, barH)];
    _toolBar = toolBar;
    [self.view addSubview:toolBar];
}

//添加输入框
- (void) setUpTextView
{
    CDTextView *textView = [[CDTextView alloc] initWithFrame:self.view.bounds];
//    textView.backgroundColor = [UIColor redColor];
    //由于textView没有placeHolder所以需要自定义一个带有placeHoler的textView
    //注册通知一定要记得移除通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewContextChange) name:UITextViewTextDidChangeNotification object:textView];
    
    textView.delegate = self;
    // 默认允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    
    textView.placeHolder = @"abc";
    [textView setFont:CD_UI_FONT_15];
    
    self.textView = textView;
    [self.view addSubview:textView];
    
}
#pragma mark 实现textView代理  拖拽textView隐藏键盘
//注册通知  监听文本内容改变事件
- (void) textViewContextChange
{
    if ([NSString isBlankString:self.textView.text]) {
        self.textView.hidePlaceHolder = NO;
    }else{
        //有内容
        self.textView.hidePlaceHolder = YES;
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
}

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//视图将要显示
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    becomeFirstResponder //变成第一响应，
//    resineFirstResponder  //放弃第一响应，
    [_textView becomeFirstResponder];
}


- (void) setUpNavigation
{
    //设置title 返回按钮
    self.navigationItem.title = @"发微博";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleBtn)];
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(writeWeibo) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *rigthBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];

    
    rigthBtn.enabled = NO;
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = rigthBtn;
}

- (void) cancleBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) writeWeibo
{
    
}


@end
