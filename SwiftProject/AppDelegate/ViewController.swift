//
//  ViewController.swift
//  SwiftProject
//
//  Created by YX on 2019/1/14.
//  Copyright © 2019 MT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PromiseKit
import Alamofire
//import Kingfisher
import SwiftyJSON
import MBProgressHUD
import Result

///SwiftyJSON
class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}


///
class Solution {
    
    func generate(n: Int, left: Int, right: Int, value: String, reslut: inout [String]) {
        if left == n && right == n {
            reslut.append(value)
        }
        
        if left < n {
            generate(n: n, left: left + 1, right: right, value: value + "(", reslut: &reslut)
        }
        
        if right < left {
            generate(n: n, left: left, right: right + 1, value: value + ")", reslut: &reslut)
        }
        
    }
    
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        generate(n: n, left: 0, right: 0, value: "", reslut: &result)
        return result
    }
}

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}


class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

//MARK: -
class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        ///Demo
        homeProvider.request(.test) { (result) in
            if case let .success(res) = result {
                if (res.statusCode == 200) {
                    ///解析数据源 绑定
                } else {
                    ///
                }

            } else {
                print("error 也会走 那我就放心了")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    func sessionLoadData() {
        Alamofire.request("https://httpbin.org/get", method: .get, parameters: ["foo": "bar"])
            .validate()
            .responseJSON { (res) in
                
                switch res.result.isSuccess {
                case true:
                    print("成功")
                    print("成功2")
                    print("成功3")
                    print("成功4")

                case false:
                    print("失败")
                }
        }
    }
    
    func makeIncremeter(forIncrement amount: Int) -> () -> Int {
        var runingTotal = 0
        func incrementer() -> Int {
            runingTotal += amount
            return runingTotal
        }
        return incrementer
    }
    override func loadView() {
        super.loadView()
        
    }
}












