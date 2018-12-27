//
//  LYBaseTableView.swift
//  Leap
//
//  Created by 梁羽 on 2017/6/11.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import UIKit

class LYBaseTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.tableFooterView = UIView.init()
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func ly_cellAtIndexPath(_ indexPath: IndexPath?) -> UITableViewCell? {
        guard let indexP = indexPath else {
            return nil
        }
        let sectionNumber = self.numberOfSections
        let section = indexP.section
        let rowNumber = self.numberOfRows(inSection: section)
        guard indexP.section + 1 <= sectionNumber, indexP.section >= 0 else {
            print("刷新section: \(indexP.section) 已经越界，总组数: \(sectionNumber)")
            return nil
        }
        guard indexP.row + 1 <= rowNumber, indexP.row >= 0 else {
            print("刷新row: \(indexP.row) 已经越界，总行数: \(rowNumber)所在section： \(section)")
            return nil
        }
        return self.cellForRow(at: indexP)
    }

    /** 刷新单行、动画默认*/
    final func ly_reloadSingleRowAtIndexPath(_ indexPath: IndexPath?, animated: UITableViewRowAnimation = .none) {
        guard let indexP = indexPath else {
            return
        }
        let sectionNumber = self.numberOfSections
        let section = indexP.section
        let rowNumber = self.numberOfRows(inSection: section)
        guard indexP.section + 1 <= sectionNumber, indexP.section >= 0 else {
            print("刷新section: \(indexP.section) 已经越界, 总组数: \(sectionNumber)")
            return
        }
        guard indexP.row + 1 <= rowNumber, indexP.row >= 0 else {
            print("刷新row: \(indexP.row) 已经越界, 总行数: \(rowNumber) 所在section: \(section)")
            return
        }
        self.beginUpdates()
        self.reloadRows(at: [indexP], with: animated)
        self.endUpdates()
    }
    
    /** 刷新多行、动画默认*/
    final func ly_reloadRowsAtIndexPath(_ indexPaths: Array<IndexPath>, animated: UITableViewRowAnimation = .none) {
        guard indexPaths.count > 0 else {
            return
        }
        for e in indexPaths.enumerated() {
            self.ly_reloadSingleRowAtIndexPath(e.element, animated: animated)
        }
    }
    
    /** 刷新某个section、动画默认*/
    final func ly_reloadSingleSection(_ section: Int, animated: UITableViewRowAnimation = .none) {
        let sectionNumber = self.numberOfSections
        guard section + 1 <= sectionNumber, section >= 0 else {
            print("刷新section: \(section) 已经越界, 总组数: \(sectionNumber)")
            return
        }
        self.beginUpdates()
        self.reloadSections(IndexSet.init(integer: section), with: animated)
        self.endUpdates()
    }
    
    /** 刷新多个section、动画默认*/
    final func ly_reloadSections(_ sections: Array<Int>, animated: UITableViewRowAnimation = .none) {
        guard sections.count > 0 else {
            return
        }
        for e in sections {
            self.ly_reloadSingleSection(e, animated: animated)
        }
    }
    
    /** 删除单行、动画默认*/
    final func ly_deleteSingleRowAtIndexPath(_ indexPath: IndexPath?, animated: UITableViewRowAnimation = .none) {
        guard let indexP = indexPath else {
            return
        }
        let sectionNumber = self.numberOfSections
        let section = indexP.section
        let rowNumber = self.numberOfRows(inSection: section)
        guard indexP.section + 1 <= sectionNumber, indexP.section >= 0 else {
            print("删除section: \(indexP.section) 已经越界, 总组数: \(sectionNumber)")
            return
        }
        guard indexP.row + 1 <= rowNumber, indexP.row >= 0 else {
            print("删除row: \(indexP.row) 已经越界, 总行数: \(rowNumber) 所在section: \(section)")
            return
        }
        self.beginUpdates()
        self.deleteRows(at: [indexP], with: .none)
        self.endUpdates()
    }
    
    /** 删除多行、动画默认*/
    final func ly_deleteRowsAtIndexPaths(_ indexPaths: Array<IndexPath>, animated: UITableViewRowAnimation = .none) {
        guard indexPaths.count > 0 else {
            return
        }
        for e in indexPaths {
            self.ly_deleteSingleRowAtIndexPath(e)
        }
    }
    
    /** 删除某个section、动画默认*/
    final func ly_deleteSingleSection(_ section: Int, animated: UITableViewRowAnimation = .none) {
        let sectionNumber = self.numberOfSections
        guard section + 1 <= sectionNumber, section >= 0 else {
            print("刷新section: \(section) 已经越界, 总组数: \(sectionNumber)")
            return
        }
        self.beginUpdates()
        self.deleteSections(IndexSet.init(integer: section), with: animated)
        self.endUpdates()
    }
    
    /** 删除多个section*/
    final func ly_deleteSections(_ sections: Array<Int>, animated: UITableViewRowAnimation = .none) {
        guard sections.count > 0 else {
            return
        }
        for e in sections {
            self.ly_deleteSingleSection(e, animated: animated)
        }
    }
    
    /** 增加单行，动画自定义*/
    final func ly_insertSingleRowAtIndexPath(_ indexPath: IndexPath?, animated: UITableViewRowAnimation = .none) {
        guard let indexP = indexPath else {
            return
        }
        let sectionNumber = self.numberOfSections
        let section = indexP.section
        let row = indexP.row
        let rowNumber = self.numberOfRows(inSection: section)
        guard section <= sectionNumber, section >= 0 else {
            print("section 越界: \(section)")
            return
        }
        guard row <= rowNumber, row >= 0 else {
            print("row 越界 : \(row)")
            return
        }
        self.beginUpdates()
        self.insertRows(at: [indexP], with: animated)
        self.endUpdates()
    }
    
    /** 增加单section，动画自定义*/
    final func ly_insertSingleSection(_ section: Int, animated: UITableViewRowAnimation = .none) {
        let sectionNumber = self.numberOfSections
        guard section + 1 <= sectionNumber, section >= 0 else {
            print("section 越界: \(section)")
            return
        }
        self.beginUpdates()
        self.insertSections(IndexSet.init(integer: section), with: animated)
        self.endUpdates()
    }
    
    /** 增加多行，动画自定义*/
    final func ly_insertRowsAtIndexPath(_ indexPaths: Array<IndexPath>, animated: UITableViewRowAnimation = .none) {
        guard indexPaths.count > 0 else {
            return
        }
        for e in indexPaths {
            self.ly_insertSingleRowAtIndexPath(e, animated: animated)
        }
    }
    
    /** 增加多section，动画默认*/
    final func ly_insertSections(_ sections: Array<Int>, animated: UITableViewRowAnimation = .none) {
        guard sections.count > 0 else {
            return
        }
        for e in sections {
            self.ly_insertSingleSection(e, animated: animated)
        }
    }
    
    /** 当有输入框的时候 点击tableview空白处，隐藏键盘*/
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if !((view?.isKind(of: UITextField.self))!) {
            self.endEditing(true)
        }
        return view
    }
}
