//
//  FuncOperationViewController.h
//  Leap
//
//  Created by 梁羽 on 2018/4/8.
//  Copyright © 2018年 梁羽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuncOperationViewController : UIViewController

-(NSInteger)foo:(NSString *)str,...;
-(NSInteger)fooList:(va_list)list;

@end
