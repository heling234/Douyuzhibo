//
//  PageTitleView.swift
//  DYZB
//
//  Created by 何凌 on 2020/4/28.
//  Copyright © 2020 heling. All rights reserved.
//

import UIKit
//定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView:PageTitleView,selectIndex index:Int)
}

//定义常量
private let kScrolllineH : CGFloat = 3
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

//定义PageTitleView类

class PageTitleView: UIView {
    //定议属性
    private var currentIndex :Int = 0
    private var titles:[String]
    weak var delegate : PageTitleViewDelegate?
    
    //增加懒属性
    private lazy var titleLabels:[UILabel] = [UILabel]()
    
    //增加懒加载属性
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
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
            let labelH:CGFloat = frame.height - kScrolllineH
            let labelY:CGFloat = 0
            
            for (index,title) in titles.enumerated(){
                //1.创建UILabel
                let label = UILabel()
                
                //2.设置Label属性
                label.text = title
                label.tag = index
                label.font = UIFont.systemFont(ofSize: 16.0)
                label.textColor = UIColor(r:kNormalColor.0,g: kNormalColor.1,b: kNormalColor.2)
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
            firstLabel.textColor = UIColor(r:kSelectColor.0, g:kSelectColor.1,b:kSelectColor.2)
            //2.2设置scrollLine的属性
            scrollView.addSubview(scrollLine)
            scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y:frame.height - kScrolllineH, width: firstLabel.frame.width, height: kScrolllineH)
        }
}

//监听Label的点击
extension PageTitleView{
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){
        //1.获取当前的Lable
        guard let currentLabel = tapGes.view as? UILabel else { return }
        //如果重复点击Title，直接返回
        if currentLabel.tag == currentIndex {return}
        //2.获取之前的Label
        let oldlabel = titleLabels[currentIndex]
        //3.切换文字的颜色
        currentLabel.textColor = UIColor(r:kSelectColor.0, g:kSelectColor.1,b:kSelectColor.2)
        oldlabel.textColor = UIColor(r:kNormalColor.0, g:kNormalColor.1,b:kNormalColor.2)
        
        //4.保存最新的下标值
        currentIndex = currentLabel.tag
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }
}
//对外暴露方法
extension PageTitleView{
    func setTitleWithProgress(progress:CGFloat,souceIndex:Int,targetIndex:Int) {
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[souceIndex]
        let targerLabel = titleLabels[targetIndex]
        //2.处理滚动的逻辑
        let moveTotalX = targerLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色发生变化
        //3.1取出变化的范围
        let colorDelta = (kSelectColor.0-kNormalColor.0,kSelectColor.1-kNormalColor.1,kSelectColor.2-kNormalColor.2)
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor(r:kSelectColor.0-colorDelta.0 * progress,g:kSelectColor.1-colorDelta.1 * progress,b:kSelectColor.2-colorDelta.2 * progress)
        //3.2变化targetLabel
        targerLabel.textColor = UIColor(r:kNormalColor.0+colorDelta.0 * progress,g:kNormalColor.1+colorDelta.1 * progress,b:kNormalColor.2+colorDelta.2 * progress)
        //4.记录最新的index
        currentIndex = targetIndex
    }
}

