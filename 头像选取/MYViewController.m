//
//  MYViewController.m
//  头像选取
//
//  Created by 李志鹏 on 16/4/27.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "MYViewController.h"

@interface MYViewController ()

@end

@implementation MYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏标题
    self.navigationItem.title = @"雨松MOMO输入框";
    
    //导航栏按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                               initWithTitle: @"发送"
                                               style: UIBarButtonItemStyleDone
                                               target: self
                                               action: @selector(sendInfo)];
    
    //输入框显示区域
    _textEditor = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    //设置它的代理
    _textEditor.delegate = self;
    _textEditor.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textEditor.keyboardType = UIKeyboardTypeDefault;
    _textEditor.font = [UIFont systemFontOfSize:20];
    _textEditor.text = @"请输入内容";
    
    //默认软键盘是在触摸区域后才会打开
    //这里表示进入当前ViewController直接打开软键盘
    [_textEditor becomeFirstResponder];
    
    //把输入框加在视图中
    [self.view addSubview:_textEditor];
    
    //下方的图片按钮 点击后呼出菜单 打开摄像机 查找本地相册
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 120, image.size.width, image.size.height);
    
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    
    //把它也加在视图当中
    [self.view addSubview:button];
}

-(void)openMenu
{
    //在这里呼出下方菜单按钮项
    MYActionSheet = [UIAlertController alertControllerWithTitle:@"拍照" message:@"从相册选取" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *cancelAction2 = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyle handler:nil];
//    UIAlertAction *cancelAction3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyle:c handler:nil];
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        NSLog(@"取消了");
    }];
    UIAlertAction *cancelAction2 = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self LocalPhoto];
    }];
    UIAlertAction *cancelAction3 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
   
    [MYActionSheet addAction:cancelAction1];
    [MYActionSheet addAction:cancelAction2];
    [MYActionSheet addAction:cancelAction3];
    //[myActionSheet showInView:self.view];
    [self presentViewController:MYActionSheet animated:YES completion:nil];
    //[myActionSheet release];
    

}
//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        //页面跳转（跳转到指定的页面）
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}
//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    //页面跳转（跳转到指定的页面）
    [self presentViewController:picker animated:YES completion:nil];
}
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面（隐藏页面）
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        UIImageView *smallimage = [[UIImageView alloc] initWithFrame:
                                    CGRectMake(50, 120, 100, 100)];
        
        smallimage.image = image;
        //加在视图中
        [self.view addSubview:smallimage];
        
    } 
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    //关闭相册界面（隐藏页面）
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendInfo
{
    NSLog(@"图片的路径是：%@", filePath);
    
    NSLog(@"您输入框中的内容是：%@", _textEditor.text);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
