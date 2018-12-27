//
//  FuncOperationViewController.m
//  Leap
//
//  Created by 梁羽 on 2018/4/8.
//  Copyright © 2018年 梁羽. All rights reserved.
//

#import "FuncOperationViewController.h"
#import "Leap-Swift.h"

@interface FuncOperationViewController ()

@end

@implementation FuncOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"function calling";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatView];
    //[self foo:@"11",@"22",@"33",@"44",nil];
    
//    NSArray *strArr = @[@"11",@"22",@"33",@"44"];
//    va_list list = malloc(sizeof(strArr));
//    [self fooList:list];
//    free(list);
}

-(NSInteger)foo:(NSString *)str,... {
    va_list list; //定义一个VA_LIST型的变量，这个变量是指向参数的指针
    va_start(list, str); //用VA_START宏初始化刚定义的VA_LIST变量
    NSInteger count = 0;
    while (YES) {
        NSString *string = va_arg(list, NSString *); //VA_ARG返回可变的参数，VA_ARG的第二个参数是你要返回的参数的类型,如果函数有多个可变参数的，依次调用VA_ARG获取各个参数
        if (!string) {
            break;
        }
        NSLog(@"string:%@",string); //打印出的是除第一个参数之外的参数
        count++;
    }
    va_end(list); //用VA_END宏结束可变参数的获取
    return count;
}

-(NSInteger)fooList:(va_list)list {
    NSInteger count = 0;
    while (YES) {
        NSString *string = va_arg(list, NSString *);
        if (!string) {
            break;
        }
        NSLog(@"%@",string);
        count++;
    }
    va_end(list);
    return count;
}

-(void)creatView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 0, self.view.width - 40, self.view.height - 84)];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.width, scrollView.height)];
    tipLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    tipLabel.numberOfLines = 0;
    [scrollView addSubview:tipLabel];
    
    tipLabel.text = [self va_list_desc];
    [tipLabel sizeToFit];
    
    scrollView.contentSize = CGSizeMake(tipLabel.width, tipLabel.height);
}

-(NSString *)va_list_desc {
    return @"  函数参数的传递原理:\n\
    函数参数是以数据结构:栈的形式存取,从右至左入栈\n\
    首先是参数的内存存放格式：参数存放在内存的堆栈段中，在执行函数的时候，从最后一个开始入栈。因此栈底高地址，栈顶低地址，举个例子如下：\n\
    void func(int x, float y, char z);\n\
    那么，调用函数的时候，实参 char z 先进栈，然后是 float y，最后是 int x，因此在内存中变量的存放次序是 x->y->z，因此，从理论上说，我们只要探测到任意一个变量的地址，并且知道其他变量的类型，通过指针移位运算，则总可以顺藤摸瓜找到其他的输入变量。\n\
    下面是 <stdarg.h> 里面重要的几个宏定义如下：\n\
    typedef char* va_list;\n\
    void va_start ( va_list ap, prev_param ); /* ANSI version */\n\
    type va_arg ( va_list ap, type ); \n\
    void va_end ( va_list ap ); \n\
    va_list 是一个字符指针，可以理解为指向当前参数的一个指针，取参必须通过这个指针进行。\n\
    <Step 1> 在调用参数表之前，定义一个 va_list 类型的变量，(假设va_list 类型变量被定义为ap)；\n\
    <Step 2> 然后应该对ap 进行初始化，让它指向可变参数表里面的第一个参数，这是通过 va_start 来实现的，第一个参数是 ap 本身，第二个参数是在变参表前面紧挨着的一个变量,即“...”之前的那个参数；\n\
    <Step 3> 然后是获取参数，调用va_arg，它的第一个参数是ap，第二个参数是要获取的参数的指定类型，然后返回这个指定类型的值，并且把 ap 的位置指向变参表的下一个变量位置；\n\
    <Step 4> 获取所有的参数之后，我们有必要将这个 ap 指针关掉，以免发生危险，方法是调用 va_end，他使输入的参数 ap 置为 NULL，应该养成获取完参数表之后关闭指针的习惯。说白了，就是让我们的程序具有健壮性。通常va_start和va_end是成对出现。\n\
    \n\
    \n\
    调用方法时最后一个参数必须写 nil必不可少，遍历终止的条件\n\
    [self foo:@"",@"",@"",@"",nil];";
}

@end
