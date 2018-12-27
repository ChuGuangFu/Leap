//
//  ClosuresViewController.swift
//  Leap
//
//  Created by 梁羽 on 2018/2/9.
//  Copyright © 2018年 梁羽. All rights reserved.
//

import UIKit

class ClosuresViewController: LYBaseViewController {

    let names = ["Chris","Alex","Ewa","Barry","Daniella"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Closures"
        testClosures14()
        creatUI()
    }

    /*
     1.闭包通用表达式：
     {(parameters) -> return type in
         statement
     }
     闭包参数可以是常量、变量、inout、可变参数列表、元组，但是不能提供默认值。返回值可以是通用类型，也可以是元组。闭包实现体位于in关键字后面，该关键字是闭包参数和返回值的声明和实现体的分界。
     */
    
    //MARK:尾随闭包形式
    //使用闭包通用表达式来提供排序功能
    func testClosures1() {
        let reversed = names.sorted() {(s1:String, s2:String) -> Bool in
            return s1 > s2
            }
        print(reversed)
    }
    
    //类型推断，省略闭包表达式的参数类型及返回值类型
    func testClosures2() {
        let reversed = names.sorted() { (s1,s2) in
            return s1 > s2
        }
        print(reversed)
    }
    
    //单一表达式，省略return关键字
    func testClosures3() {
        let reversed = names.sorted() { (s1, s2) in
            s1 > s2
        }
        print(reversed)
    }
    
    //速记参数名
    func testClosures4() {
        let reversed = names.sorted {
            $0 > $1
        }
        print(reversed)
    }
    
    //MARK:闭包表达式作为参数形式
    func testClosures11() {
        let reversed = names.sorted(by: { (s1 : String, s2 : String) -> Bool in
            return s1 > s2
        })
        print(reversed)
    }
    
    func testClosures12() {
        let reversed = names.sorted(by: { (s1, s2) in
            return s1 > s2
        })
        print(reversed)
    }
    
    func testClosures13() {
        let reversed = names.sorted(by: { (s1, s2) in
            s1 > s2
        })
        print(reversed)
    }
    
    func testClosures14() {
        let reversed = names.sorted(by: {
            $0 > $1
        })
        print(reversed)
    }
    
    func creatUI() {
        let descLabel = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: Screen_width - 20 * 2, height: 1))
        descLabel.textColor = UIColor.colorWithHexString("#999999")
        descLabel.numberOfLines = 0
        self.view.addSubview(descLabel)
        descLabel.text = "1.内联闭包表达式，参数和返回值都位于表达式内部，而不是外部\n\n2.借助于swift的类型推断功能，我们可以省略参数和返回值的类型\n\n3.如果闭包体只有一行代码，我们可以省略return关键字\n\n4.swift为内联闭包提供了速记参数名，可以通过$0,$1,$2等参数名来索引闭包的参数。如果使用这种参数名，则可以直接省略参数列表，，而参数的个数和类型可以直接推断出来。in关键字也可以省略\n\n5.如果将闭包作为函数的最后一个参数，且闭包的实现体很长，则调用函数时可以使用尾随闭包。尾随闭包位于参数列表括号的后面\n\n6.如果函数只有一个闭包参数，同时将闭包参数实现为尾随闭包，则在调用函数时可以省略参数列表的()"
        descLabel.sizeToFit()
    }
}
