//
//  String+Extension.swift
//  SwiftDemo
//
//  Created by liyan on 2018/1/3.
//  Copyright © 2018年 liyan. All rights reserved.
//

import UIKit

//MARK:- 计算
extension String {
    
    /// 获取size
    @discardableResult
    func boundingRect(with size: CGSize, attributes: [NSAttributedString.Key: AnyObject]) -> CGRect {
        
        let ns_string: NSString = self as NSString
        let rect = ns_string.boundingRect(with: size, options:NSStringDrawingOptions.usesFontLeading  , attributes: attributes, context: nil)
        return snap(rect)
    }
    
    /// 获取size  限制最大行数
    @discardableResult
    func size(fits size: CGSize, font: UIFont, maximumNumberOfLines: Int = 0) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        var size = self.boundingRect(with: size, attributes: attributes).size
        if maximumNumberOfLines > 0 {
            size.height = min(size.height, CGFloat(maximumNumberOfLines) * font.lineHeight)
        }
        return size
    }
    
    /// 获取宽度
    @discardableResult
    func width(with font: UIFont, maximumNumberOfLines: Int = 0) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        return self.size(fits: size, font: font, maximumNumberOfLines: maximumNumberOfLines).width
    }
    
    /// 获取高度
    @discardableResult
    func height(fits width: CGFloat, font: UIFont, maximumNumberOfLines: Int = 0) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return self.size(fits: size, font: font, maximumNumberOfLines: maximumNumberOfLines).height
    }
    
}


//MARK:- 去空格
extension String {
    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace:String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro:String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /*
     *去掉所有空格
     */
    var removeAllSapce:String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    
    /*
     *去掉首尾空格 后 指定开头空格数
     */
    func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.removeHeadAndTailSpacePro
    }
    
    
    
    
}


//MARK:-
extension String {
    ///长度
    var ly_length: Int {
        //        return self.characters.count
        //swift4.0 以后 直接调用count属性即可获取字符串长度
        return self.count
    }
    
    // MARK: - 快速生成缓存路径
    func cachesDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        
        // 生成缓存路径
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)
        
        return filePath
    }
    
    // MARK: - 快速生成文档路径
    func docDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)
        
        return filePath
    }
    
    // MARK: - 快速生成临时路径
    func tmpDir() -> String {
        let path = NSTemporaryDirectory()
        
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)
        
        return filePath
    }
    
    // MARK: - 快速生成富文本
    func getAttributedString(_ fontNum: CGFloat, color: UIColor, loc: Int, len: Int) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: fontNum)
        let attString =  NSMutableAttributedString(string: self)
        
        attString.addAttributes([ NSAttributedString.Key.font : font,
                                  NSAttributedString.Key.foregroundColor : color  ], range: NSMakeRange(loc, len))
        return attString
    }
}




//MARK:-  Range < --- > NSRange
extension String {
    
    //Range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        guard let from = range.lowerBound.samePosition(in: utf16) else { return nil}
        guard let to = range.upperBound.samePosition(in: utf16) else { return nil }
        
        return NSRange.init(location: utf16.distance(from: utf16.startIndex, to: from),
                            length: utf16.distance(from: from, to: to))
    }
    
    
    
    //Range转换为NSRange
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length,
                                   limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}






extension String {
    /// Ceil to snap pixel
    fileprivate func snap(_ x: CGFloat) -> CGFloat {
        let scale = UIScreen.main.scale
        return ceil(x * scale) / scale
    }
    
    fileprivate func snap(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: snap(point.x), y: snap(point.y))
    }
    
    fileprivate func snap(_ size: CGSize) -> CGSize {
        return CGSize(width: snap(size.width), height: snap(size.height))
    }
    
    fileprivate func snap(_ rect: CGRect) -> CGRect {
        return CGRect(origin: snap(rect.origin), size: snap(rect.size))
    }
    
}

