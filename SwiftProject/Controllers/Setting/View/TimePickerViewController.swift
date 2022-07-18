//
//  TimePickerViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/8/28.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit

//typealias  timePickerBlock = (_ year: String,_ month: String,_ day: String) -> ()


class TimePickerViewController: BaseViewController {
    
    /// 返回数据回调
    public var timePickerBlock: ((String,String,String)->())?
    
    ///时间选择器
    lazy var pickView: UIPickerView = {
        let pickView = UIPickerView()
        pickView.frame = CGRect.init(x: 0, y: 40, width: kScreenWidth, height: 180)
        pickView.delegate = self
        pickView.dataSource = self
        return pickView
    }()
    
    ///确定
    lazy var doneBtn: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(UIColor.init(r: 255, g: 151, b: 62), for: .normal)
        btn.titleLabel?.font = UIFont.font(size: 15, weight: .regular)
        btn.addTarget(self, action: #selector(doneEvent), for: .touchUpInside)
        return btn
    }()
    
    var unitFlags:Set<Calendar.Component>!
    
    //数据相关
    fileprivate var yearRange = 0//年的范围
    fileprivate var dayRange = 0
    fileprivate var startYear = 0
    fileprivate var selectedYear = 0;
    fileprivate var selectedMonth = 0;
    fileprivate var selectedDay = 0;
    
    var timeString: String? = "2019.04.11"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        loadFrame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareData()
    }
}


extension TimePickerViewController {
    func loadUI() {
        self.contentSizeInPop = CGSize.init(width: kScreenWidth, height: 220)
        self.contentSizeInPopWhenLandscape = CGSize.zero
        
        view.addSubview(pickView)
        view.addSubview(doneBtn)
    }
    
    func loadFrame() {
        doneBtn.frame = CGRect.init(x: kScreenWidth - 60, y: 0, width: 60, height: 40)
    }
    
    @objc func doneEvent() {
        if timePickerBlock != nil{
           timePickerBlock!(String(selectedYear),String(selectedMonth),String(selectedDay))
        }
        self.popController?.dismiss()
    }
    
    func prepareData() {
        let  calendar = Calendar.init(identifier: .gregorian)//公历
        var comps = DateComponents()//一个封装了具体年月日、时秒分、周、季度等的类
        unitFlags = [.year , .month , .day ]
        comps = calendar.dateComponents(unitFlags, from: Date())
        startYear = 1941
        yearRange = 120;
        dayRange = self.isAllDay(year: startYear, month: 1)
        
        if timeString == nil || timeString == "" {
            selectedYear = comps.year!;
            selectedMonth = comps.month!;
            selectedDay = comps.day!;
        } else {
            let array = timeString!.components(separatedBy: ".")
            selectedYear = Int(array[0])!
            selectedMonth = Int(array[1])!
            selectedDay = Int(array[2])!
        }
        
    
        pickView.selectRow(selectedYear - startYear, inComponent: 0, animated: true)
        pickView.selectRow(selectedMonth - 1, inComponent: 1, animated: true)
        pickView.selectRow(selectedDay - 1, inComponent: 2, animated: true)
        
        pickView.reloadAllComponents()
    }
    
    //MARK:计算每个月有多少天
    fileprivate func isAllDay(year:Int, month:Int) -> Int {
        var day:Int = 0
        switch(month) {
        case 1,3,5,7,8,10,12:
            day = 31
        case 4,6,9,11:
            day = 30
        case 2:
            if(((year % 4 == 0) && ( year % 100 == 0))||( year % 400 == 0)) {
                day = 29
            } else {
                day = 28;
            }
        default:
            break;
        }
        return day;
    }
}


extension TimePickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //返回UIPickerView当前的列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    //设置行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    //确定每一列返回的东西
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0:
                return yearRange
            case 1:
                return 12
            case 2:
                return dayRange
            default:
                return 0
        }
    }
    
    //返回一个视图，用来设置pickerView的每行显示的内容。
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label  = UILabel(frame: CGRect(x: kScreenWidth * CGFloat(component) / 3 , y: 0, width: kScreenWidth / 3, height: 30))
        label.font = UIFont.font(size: 20, weight: .regular)
        label.textColor = UIColor.init(r: 153, g: 153, b: 153)
        label.textAlignment = .center
        
        switch component {
            case 0:
                label.text = "\(self.startYear + row)年"
            
            case 1:
                label.text = "\(row + 1)月"
            
            case 2:
                label.text = "\(row + 1)日"
            default:
                label.text = ""
        }
        return label
    }
      
    
    //当点击UIPickerView的某一列中某一行的时候，就会调用这个方法
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            self.selectedYear = self.startYear + row
            self.dayRange = self.isAllDay(year: self.startYear, month: self.selectedMonth)
            self.pickView.reloadComponent(2)
            
        case 1:
            self.selectedMonth =  row + 1
            self.dayRange = self.isAllDay(year: self.startYear, month: self.selectedMonth)
            self.pickView.reloadComponent(2)
            
        case 2:
            selectedDay = row + 1
            
        default: break
            
        }
    }
        
}
