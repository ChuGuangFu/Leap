//
//  ListRefresh.swift
//  Leap
//
//  Created by 梁羽 on 2017/6/11.
//  Copyright © 2017年 梁羽. All rights reserved.
//

import Foundation
import MJRefresh

class ListRefresh {
    
    /** 开始下拉刷新*/
    class func beginPullRefreshForScrollView(_ scrollView: UIScrollView) {
        scrollView.mj_header.beginRefreshing()
    }
    
    /**判断头部是否在刷新*/
    class func headerIsRefreshForScrollView(_ scrollView: UIScrollView) -> Bool {
        return scrollView.mj_header.isRefreshing()
    }
    
    /**判断尾部是否在刷新*/
    class func footerIsLoadingForScrollView(_ scrollView: UIScrollView) -> Bool {
        return scrollView.mj_footer.isRefreshing()
    }
    
    /**提示没有更多数据的情况*/
    class func noticeNoMoreDataForScrollView(_ scrollView: UIScrollView) {
        scrollView.mj_footer.endRefreshingWithNoMoreData()
    }
    
    /**重置footer*/
    class func resetNoMoreDataForScrollView(_ scrollView: UIScrollView) {
        scrollView.mj_footer.resetNoMoreData()
    }
    
    /**停止下拉刷新*/
    class func endRefreshForScrollView(_ scrollView: UIScrollView) {
        scrollView.mj_header.endRefreshing()
    }
    
    /**停止上拉加载*/
    class func endLoadMoreForScrollView(_ scrollView: UIScrollView) {
        scrollView.mj_footer.endRefreshing()
    }
    
    /** 隐藏footer*/
    class func hiddenFooterForScrollView(_ scrollView: UIScrollView) {
        scrollView.mj_footer.isHidden = true
    }
    
    /**隐藏header*/
    class func hiddenHeaderForScrollView(_ scrollView: UIScrollView) {
        scrollView.mj_header.isHidden = true
    }
    
    /**上拉*/
    class func addLoadMoreForScrollView(_ scrollView: UIScrollView?, loadMoreCallBackClosure: ((Void) -> Void)?) {
        guard scrollView != nil, loadMoreCallBackClosure != nil else {
            return
        }
        let footer = MJRefreshAutoNormalFooter.init { 
            loadMoreCallBackClosure!()
        }
        footer?.setTitle("", for: .idle)
        footer?.setTitle("正在为您拼命加载数据", for: .refreshing)
        footer?.setTitle("没有更多了~", for: .noMoreData)
        footer?.stateLabel.textColor = UIColor.init(r: 90, g: 90, b: 90)
        footer?.stateLabel.font = UIFont.systemFont(ofSize: 13)
        scrollView?.mj_footer = footer
        footer?.backgroundColor = UIColor.clear
    }
    
    /**下拉*/
    class func addPullRefreshForScrollView(_ scrollView: UIScrollView?, pullRefreshCallBackClosure: ((Void) -> Void)?) {
        guard scrollView != nil, pullRefreshCallBackClosure != nil else {
            return
        }
        let header = MJRefreshNormalHeader.init { [weak scrollView] in
            pullRefreshCallBackClosure!()
            guard let strongScrollView = scrollView else {return}
            if strongScrollView.mj_footer.isHidden == false {
                strongScrollView.mj_footer.resetNoMoreData()
            }
        }
        header?.setTitle("释放更新", for: .pulling)
        header?.setTitle("正在更新", for: .refreshing)
        header?.setTitle("下拉刷新", for: .idle)
        header?.stateLabel.font = UIFont.systemFont(ofSize: 13)
        header?.stateLabel.textColor = UIColor.init(r: 90, g: 90, b: 90)
        header?.lastUpdatedTimeLabel.isHidden = true
        scrollView?.mj_header = header
    }
}
