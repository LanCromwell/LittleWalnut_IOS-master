//
//  GSCaptchaButton.swift
//  GSCaptchaButton
//
//  Created by Gesen on 15/6/4.
//  Copyright (c) 2015年 Gesen. All rights reserved.
//

import UIKit

public class GSCaptchaButton: UIButton {

    // MARK: Properties
    public var maxSecond = 60
    public var countdown = false {
        didSet {
            if oldValue != countdown {
                countdown ? startCountdown() : stopCountdown()
            }
        }
    }
    
    private var second = 0
    private var timer: Timer?
    
    private var timeLabel: UILabel!
    private var normalText: String!
    private var normalTextColor: UIColor!
    private var disabledText: String!
    private var disabledTextColor: UIColor!
    
    // MARK: Life Cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        countdown = false
    }
    
    // MARK: Setups
    
    private func setupLabel() {
        normalText = title(for: .normal) ?? ""
        disabledText = title(for: .disabled) ?? ""
        normalTextColor = titleColor(for: .normal) ?? .white
        disabledTextColor = titleColor(for: .disabled) ?? .white
        setTitle("", for: .normal)
        setTitle("", for: .disabled)
        timeLabel = UILabel(frame: bounds)
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.font(size: 12, weight: .medium)
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
        addSubview(timeLabel)
    }
    
    // MARK: Private
    
    private func startCountdown() {
        second = maxSecond
        updateDisabled()
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
        updateNormal()
    }
    
    private func updateNormal() {
        isEnabled = true
        timeLabel.textColor = normalTextColor
        setTitle("", for: .normal)
        timeLabel.text = "重新获取"
    }
    
    private func updateDisabled() {
        isEnabled = false
        timeLabel.textColor = disabledTextColor
        setTitle("", for: .normal)
        timeLabel.text = "\(second)秒"
    }
    
    @objc private func updateCountdown() {
        second -= 1
        if second <= 0 {
            countdown = false
        } else {
            updateDisabled()
        }
    }

}
