//
//  PageTitleView.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/28.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit

private let kScrolllineH : CGFloat = 2

class PageTitleView: UIView {
    //定议属性
    private var currentIndex :Int = 0
    private var titles:[String]
    //增加懒属性
    private lazy var titleLabels:[UILabel] = [UILabel]()
    
    //增加懒加载属性
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        //scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
      //  scrollView.bounds = false
        return scrollView
    }()
    
    private lazy var scrollLine :UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //Mark:自定义构造函数
    init(frame:CGRect,titles:[String]) {
       
        self.titles = titles
        super.init(frame:frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//设置UI界面
    extension PageTitleView{
        private func setupUI(){
            //1.增加UISCrollView
            addSubview(scrollView)
            scrollView.frame = bounds
            
            //2.增加titles对应的lable
            setupTitleLabels()
            
            //3.设置底线和滚动的滑块
            setupBottomLineAndScrollLine()
    }
        
        
        private func setupTitleLabels(){
            
            let labelW:CGFloat = frame.width / CGFloat(titles.count)
            let labelH:CGFloat = frame.height - kScrolllineH + 25
            let labelY:CGFloat = 0
            
            for (index,title) in titles.enumerated(){
                //1.创建UILabel
                let label = UILabel()
                
                //2.设置Label属性
                label.text = title
                label.tag = index
                label.font = UIFont.systemFont(ofSize: 16.0)
                label.textColor = UIColor.darkGray
                label.textAlignment = .center
             
                
            
                // 3.设置Label的Frame
                let labelX:CGFloat = labelW * CGFloat(index)
                
                //4.将Lable加到scrollView中
                label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
                //4.将lable加到scrollView中
                scrollView.addSubview(label)
                titleLabels.append(label)
                
                //5.给Label添加手势
                label.isUserInteractionEnabled = true
                let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
                label.addGestureRecognizer(tapGes)
            }
        }
        
        private func setupBottomLineAndScrollLine(){
            //1.添加底线
            let bottomLine = UIView()
            bottomLine.backgroundColor = UIColor.lightGray
            let lineH : CGFloat = 1
            bottomLine.frame = CGRect(x: 0, y:frame.height - lineH, width: frame.width, height: lineH)
            addSubview(bottomLine)
            //2.添加scrollLine
            //2.1获取第一个lable
           guard let firstLabel = titleLabels.first else {return}
            
            scrollView.addSubview(scrollLine)
            
       
            scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y:frame.height - kScrolllineH, width: firstLabel.frame.width, height: kScrolllineH)
        }
}

//监听Label的点击
extension PageTitleView{
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){
        //1.获取当前的Lable
        guard let currentLabel = tapGes.view as? UILabel else { return }
        //2.获取之前的Label
        let oldlabel = titleLabels[currentIndex]
        //3.切换之前的颜色
        currentLabel.textColor = UIColor.orange
        oldlabel.textColor = UIColor.darkGray
        //4.保存最新的下标值
        currentIndex = currentLabel.tag
        //5.
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
    }
}
