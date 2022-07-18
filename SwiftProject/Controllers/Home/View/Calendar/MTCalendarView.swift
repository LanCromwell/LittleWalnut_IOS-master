//
//  MTCalendarView.swift
//  SwiftProject
//
//  Created by YX on 2019/7/26.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import JKCategories

class MTCalendarView: UIView {
    
    let titleHeight = 30.0, weekTitleHeight = 40.0, mariginLeft: CGFloat = 12.0, padding: CGFloat = 5.0
    let itemW = (kScreenWidth - 2 * 12.0 - 5.0 * 2) / 7.0
    ///当前日期
    var currentDate: Date = Date()
    ///今天
    let todayDate: Date = Date()
    ///数据源
    var dateArray = [MTCalandarModel]()
    
    ///点击回调
    var dateClickCallBack: ((MTCalandarModel, Bool) -> ())?
    
    ///title
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = ""
        lab.textAlignment = .center
        lab.textColor = UIColor.white
        lab.font = UIFont.font(size: 18, weight: .semibold)
        return lab
    }()
    
    ///周 标题
    let weekTitles = ["日", "一", "二", "三", "四", "五", "六"]
    
    ///下划线
    lazy var lineV: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(gray: 216)
        line.isHidden = true
        return line
    }()
    
    ///日历背景
    lazy var calendarBgView: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "calendar_bg")
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    
    ///layout
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    /// calendar collectionview
    lazy var calenderCollectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.alwaysBounceVertical = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.mt_register(cellWithClass: MTCalandarCell.self)
        
        return collectionView
    }()
    
    ///tags
    lazy var tagsV: TagsView = {
        let tagsV = TagsView()
        return tagsV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initData()
        loadUI()
        loadFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

///MARK:- 事件处理
extension MTCalendarView {
    ///向左滑动手势回调事件
    @objc fileprivate func swipeLeft() {
        print("向左滑动")
        ///月份+ 1
        currentDate = (currentDate as NSDate).jk_nextMonth()!
        print("+1 ==",currentDate)
        updateHeaderTitle()
        computeTotalDays(currentDate)
        self.performSwipeAnimation(subType: CATransitionSubtype.fromRight as CATransitionSubtype)
    }
    
    ///向右滑动手势回调事件
    @objc fileprivate func swipeRight() {
        print("向右滑动")
        ///月份-1
        currentDate = (currentDate as NSDate).jk_previousMonth()
        print("-1 ==",currentDate)
        updateHeaderTitle()
        computeTotalDays(currentDate)
        self.performSwipeAnimation(subType: CATransitionSubtype.fromLeft as CATransitionSubtype)
      
    }
    
    ///初始化数据
    @objc fileprivate func initData() {
        currentDate = Date()
        print("0 ==",currentDate)
        updateHeaderTitle()
        computeTotalDays(currentDate)
        self.performSwipeAnimation(subType: CATransitionSubtype.fromLeft as CATransitionSubtype)
    }
    
    ///动画
    func performSwipeAnimation(subType: CATransitionSubtype) {
        let transition = CATransition.init()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
        transition.type = CATransitionType.reveal
        transition.subtype = subType
        self.calenderCollectionView.layer.add(transition, forKey: nil)
    }
    
    ///计算当前月需要展示的天数 （本月天数 + 上月结尾 + 下月开始）
    func computeTotalDays(_ date: Date) {
        dateArray.removeAll()
        ///当月天数
        let daysInMonth = (date as NSDate).jk_daysInMonth()
        ///获取该月的第一天日期
        let begindayOfMonth = (date as NSDate).jk_begindayOfMonth()!
        ///获取该月的最后一天日期
        let lastdayOfMonth = (date as NSDate).jk_lastdayOfMonth()!
        ///当月第一天周几 (周日 1 )
        let beginWeekday = mt_week(begindayOfMonth)
        ///当月最后一天周几
        let lastWeekday = mt_week(lastdayOfMonth)
        ///需要在第一行插入的日期数
        let firstInsertDays = beginWeekday - 1
        ///需要在最后一行补加的日期数
        let lastInsertDays = 7 - lastWeekday
        ///总共数据
        let nums = daysInMonth + firstInsertDays + lastInsertDays
        ///第一行 第一列 数据
        let firstDate = (begindayOfMonth as NSDate).jk_date(bySubtractingDays: firstInsertDays)
//        print(firstDate!)
        for index in 0..<nums {
            let date = (firstDate! as NSDate).jk_date(byAddingDays: UInt(index))
//            print(date!)
            var type: MTDayType = .currentMonth
            if index < firstInsertDays {
              type = .perviousMonth
            } else if index >= (daysInMonth + firstInsertDays) {
                type = .nextMonth
            } else {
                type = .currentMonth
            }
            let model = MTCalandarModel.init(date!, type: type)
            let lunar = solarToLunar(date!)
            let lunarStr = (lunar as NSString).components(separatedBy: "月").last ?? ""
            model.lunarStr = lunarStr
            dateArray.append(model)
        }
        
        self.calenderCollectionView.reloadData()
        
        
    }
    
    ///获取周几
    func mt_week(_ date: Date) -> Int {
        let calendar = Calendar.current
        if let weekday = calendar.dateComponents([.weekday], from: date).weekday {
            //第一天是从星期天算起，weekday在 1~7之间
            return weekday
        }
        return 1;
    }
    
    //MARK:- 判断是否是同一个月
    func isSameMouth(_ date: Date) -> Bool {
        let currentYear = (Int)((date as NSDate).jk_year())
        let currentMonth = (Int)((date as NSDate).jk_month())
        let todayYear = (Int)((Date() as NSDate).jk_year())
        let todayMonth = (Int)((Date() as NSDate).jk_month())
        return (currentYear == todayYear && currentMonth == todayMonth) ? true : false
    }
    
    //MARK:- 公历转农历
    func solarToLunar(_ date: Date) -> String {
        let year = (Int)((date as NSDate).jk_year())
        let month = (Int)((date as NSDate).jk_month())
        let day = (Int)((date as NSDate).jk_day())
        //初始化公历日历
        let solarCalendar = Calendar.init(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        components.minute = 0
        components.second = 0
        components.timeZone = TimeZone.init(secondsFromGMT: 60 * 60 * 8)
        let solarDate = solarCalendar.date(from: components)
        
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        //日期格式和输出
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .medium
        formatter.calendar = lunarCalendar
        return formatter.string(from: solarDate!)
    }
    
    ///获取初几
    func lunarDay(_ date: Date) -> String {
        let lunar_y_m_d = solarToLunar(date)
        let array = (lunar_y_m_d as NSString).components(separatedBy: "月")
        return array.last ?? ""
    }
    
    ///更新头部数据
    func updateHeaderTitle() {
        let solar = (currentDate as NSDate).jk_date(withFormat: "YYYY年MM月dd日") ?? ""
        let lunar = lunarDay(currentDate)
        titleLab.text = solar + " " + "农历" + lunar
        
    }
    
    ///网络请求完成后 更新数据
    func updateView(_ array: [HomeListModel]) {
        
        dateArray = dateArray.map { model in
            if model.type == .currentMonth  {
                let index = Int(model.solarStr)! - 1
                if index < array.count {
                    model.data = array[index]
                }
            }
            return model
        }
        
        let todayArray = dateArray.filter { (model) -> Bool in
            return model.isToday
        }
        
        if todayArray.count == 1 {
            dateClickCallBack?(todayArray.first!, false)
        }
        calenderCollectionView.reloadData()
    
    }

    
    
}


///UI & Frame
extension MTCalendarView {
    ///添加周 标签
    private func addWeeks() {
        let week_w = (self.mj_w - mariginLeft * 2 - 5.0 * 2 )/7.0
        var week_x: CGFloat = mariginLeft + padding
        for item in weekTitles {
            let lab = UILabel.init()
            lab.text = item
            lab.textAlignment = .center
            lab.textColor = UIColor.white
            lab.font = UIFont.font(size: 11, weight: .medium)
            lab.frame = CGRect.init(x: week_x, y: 30, width: week_w, height: 40)
            week_x += week_w
            addSubview(lab)
        }
    }
    
    ///添加子控件
    fileprivate func loadUI() {
        addSubview(titleLab)
        addWeeks()
        addSubview(calendarBgView)
        calendarBgView.addSubview(calenderCollectionView)
        calendarBgView.addSubviews(tagsV)
        
        ///添加左右滑动手势
//        let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeLeft))
//        leftSwipe.direction = .left
//        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeRight))
//        rightSwipe.direction = .right
//
//        self.calenderCollectionView.addGestureRecognizer(leftSwipe)
//        self.calenderCollectionView.addGestureRecognizer(rightSwipe)
    }
    
    ///布局
    fileprivate func loadFrame() {
        let rows = dateArray.count / 7
        titleLab.frame = CGRect.init(x: 0.0, y: 0.0, width: Double(self.mj_w), height: titleHeight)
        calendarBgView.frame = CGRect.init(x: padding, y: 65.0, width: self.mj_w - 2 * padding, height: rows * itemW + 80)
        calenderCollectionView.frame = CGRect.init(x: mariginLeft , y: mariginLeft + padding, width: itemW * 7, height: rows * itemW)
        tagsV.frame = CGRect.init(x: mariginLeft * 3, y: calenderCollectionView.mj_h + mariginLeft * 2 , width: calenderCollectionView.mj_w - mariginLeft * 4, height: 30)
        self.frame = CGRect.init(x: 0, y: kStatusHeight, width: kScreenWidth, height: 145 + rows * itemW)
    }
    
    ///更新
    open func updateDate() {
        currentDate = Date()
        updateHeaderTitle()
        computeTotalDays(currentDate)
        loadFrame()
    }
    
}


extension MTCalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: itemW, height: itemW)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MTCalandarCell = collectionView.mt_dequeueReusableCell(withClass: MTCalandarCell.self, for: indexPath)
//        cell.contentView.backgroundColor = UIColor.randomColor()
        let model  = dateArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dateArray = dateArray.map { (item) -> MTCalandarModel in
            item.isSelected = false
            return item
        }
        let model  = dateArray[indexPath.row]
        model.isSelected = true
        collectionView.reloadData()
        
        if model.type == .currentMonth {
            currentDate = model.date
            updateHeaderTitle()
            dateClickCallBack?(model, true)
        }
    }
    
    
}
