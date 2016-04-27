//
//  MYViewController.h
//  头像选取
//
//  Created by 李志鹏 on 16/4/27.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    //输入框
    UITextView * _textEditor;
    //下拉菜单
    UIActionSheet *myActionSheet;
    UIAlertController *MYActionSheet;
    //图片二进制路径
    NSString * filePath;
    
    
}

@end
