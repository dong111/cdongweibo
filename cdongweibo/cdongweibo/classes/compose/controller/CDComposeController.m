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
#import "CDImagesView.h"
#import "CDWeiBoTopService.h"
#import "MBProgressHUD+CD.h"


static const int textHeight = 200;

@interface CDComposeController ()<UITextViewDelegate,CDComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak) CDComposeToolBar *toolBar;

@property (nonatomic,weak)   CDTextView *textView;

//定义系统相册
@property (nonatomic,strong) UIImagePickerController *imagePc;

//展示图片区域
@property (nonatomic,weak) CDImagesView *imagesView;

//发送微博按钮
@property (nonatomic,weak) UIBarButtonItem *composeBtn;


//发送图片数组
@property (nonatomic,strong) NSMutableArray *statusImages;

@end

@implementation CDComposeController

- (NSMutableArray *)statusImages
{
    if (_statusImages==nil) {
        _statusImages = [NSMutableArray array];
    }
    return _statusImages;
}

//懒加载系统相册
- (UIImagePickerController *)imagePc
{
    if (_imagePc == nil) {
        //弹出系统相册
        UIImagePickerController *imagePc = [[UIImagePickerController alloc] init];
        // 设置相册类型,相册集
        imagePc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //相册处理事件代理
        imagePc.delegate = self;
        
        _imagePc = imagePc;
    }
    return _imagePc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //*** 一定要设置 否知view是透明的
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigation];
    
    //添加textView输入框
    [self setUpTextView];
    //添加工具bar
    [self setUpToolBar];
    //添加图片展示区域
    [self setUpImagesView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


- (void) setUpImagesView
{
    CGFloat imageVW = self.view.width;
    CGFloat imageVH = self.view.height-textHeight;
    CGFloat imageVX = 0;
    CGFloat imageVy = textHeight;
    CDImagesView *imagesView = [[CDImagesView alloc] initWithFrame:CGRectMake(imageVX, imageVy, imageVW, imageVH)];
//    imagesView.backgroundColor = [UIColor redColor];
    _imagesView = imagesView;
    [self.textView addSubview:imagesView];
}


#pragma mark 实现toolBar delegate工具栏方法
- (void)composeToolBar:(CDComposeToolBar *)toolBar DidClickBtn:(int)index
{
   //从相册选择图片
    if (index==0) {
        [self presentViewController:self.imagePc animated:YES completion:nil];
    }
}


#pragma mark 实现相册选择图片代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image =  info[@"UIImagePickerControllerOriginalImage"];
    
    [self.imagesView addImage:image];
    [self.statusImages addObject:image];
     _composeBtn.enabled = YES;
    [self.imagePc dismissViewControllerAnimated:YES completion:nil];
    
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
    _toolBar.delegate = self;
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
    
    textView.placeHolder = @"分享点新鲜事……";
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
         _composeBtn.enabled = NO;
    }else{
        //有内容
        self.textView.hidePlaceHolder = YES;
        _composeBtn.enabled = YES;
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
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(writeWeibo) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *rigthBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];


    rigthBtn.enabled = NO;
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = rigthBtn;
    _composeBtn = rigthBtn;
}

- (void) cancleBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) writeWeibo
{
    self.composeBtn.enabled = NO;
    if (self.statusImages.count>0) {
        //发送图片
        [self sendImages];
    }else{
        //发送文字
        [self sendComposeText];
    }
}

//发送文字
- (void)sendComposeText
{
    NSString *text = self.textView.text;
    if (![NSString isBlankString:text])
    {
        [CDWeiBoTopService weiboSendText:text sucess:^{
            // 提示用户发送成功
            [MBProgressHUD showSuccess:@"发送成功"];
            // 回到首页
            [self dismissViewControllerAnimated:YES completion:nil];
            self.composeBtn.enabled = YES;
        } failure:^(NSError *error) {
             NSLog(@"%@",error);
            self.composeBtn.enabled = YES;
        }];
    }
}

//发送图片
- (void)sendImages
{
    [CDWeiBoTopService weiboSendImages:self.statusImages text:self.textView.text sucess:^{
        self.composeBtn.enabled = YES;
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        self.composeBtn.enabled = YES;
        // 提示用户发哦送失败
        [MBProgressHUD showError:@"发送失败"];
         NSLog(@"%@",error);
    }];
}



@end
