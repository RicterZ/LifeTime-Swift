//
//  MainViewController.swift
//  LifeTime
//
//  Created by Madimo on 14-6-11.
//  Copyright (c) 2014年 Madimo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, BirthdayPickerViewDelegate {

    var birthdayPickerView: BirthdayPickerView?
    var birthdayLabel: UILabel?
    var titleLabel: UILabel?
    var yearLabel: UILabel?
    var monthLabel: UILabel?
    var weekLabel: UILabel?
    var dayLabel: UILabel?
    var hourLabel: UILabel?
    var minuteLabel: UILabel?
    var secondLabel: UILabel?
    var timer: NSTimer?
    
    var _birthday: NSDate?
    var birthday: NSDate? {
        get {
            if (_birthday != nil) {
                _birthday = NSUserDefaults.standardUserDefaults().objectForKey("Birthday")? as NSDate?
            }
            return _birthday
        }
    
        set {
            _birthday = newValue
            
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setObject(_birthday, forKey: "Birthday")
            ud.synchronize()
            
            self.initTimer()
        }
    }
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.birthdayPickerView = BirthdayPickerView(height: 200)
        self.birthdayPickerView!.delegate = self
        
        let width = self.view.frame.size.width
        
        self.birthdayLabel = UILabel(frame: CGRectMake(0, 50, width, 20))
        self.birthdayLabel!.textAlignment = .Center
        self.birthdayLabel!.textColor = UIColor.blueColor()
        self.birthdayLabel!.text = "Tap to Select Birthday"
        self.birthdayLabel!.userInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
        self.birthdayLabel!.addGestureRecognizer(recognizer)
        self.view.addSubview(self.birthdayLabel!)
        
        self.titleLabel = UILabel()
        self.yearLabel = UILabel()
        self.monthLabel = UILabel()
        self.weekLabel = UILabel()
        self.dayLabel = UILabel()
        self.hourLabel = UILabel()
        self.minuteLabel = UILabel()
        self.secondLabel = UILabel()
        
        var array = [self.titleLabel, self.yearLabel, self.monthLabel, self.weekLabel, self.dayLabel, self.hourLabel, self.minuteLabel, self.secondLabel]
        var count = 0
        for label: UILabel? in array {
            count++
            label!.frame = CGRectMake(0, 50.0 * CGFloat(count + 1), width, 20)
            label!.textAlignment = .Center
            self.view.addSubview(label!)
        }
        
        if self.birthday != nil {
            self.initTimer()
        }
    }
    
    func initTimer() {
        self.updateUI(nil)
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
        target: self,
        selector: Selector("updateUI:"),
        userInfo: nil,
        repeats: true)
    }
    
    func updateUI(timer: NSTimer?) {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var date = formatter.stringFromDate(birthday!)
        self.birthdayLabel!.text = "Born on \(date)"
        
        var seconds = -Int(self.birthday!.timeIntervalSinceNow)
        self.titleLabel!.text = "You are living on this planet about"
        self.yearLabel!.text = "\(seconds / 3600 / 24 / 365) years"
        self.monthLabel!.text = "\(seconds / 3600 / 24 / 30) months"
        self.weekLabel!.text = "\(seconds / 3600 / 24 / 7) weeks"
        self.dayLabel!.text = "\(seconds / 3600 / 24) days"
        self.hourLabel!.text = "\(seconds / 3600) hours"
        self.minuteLabel!.text = "\(seconds / 60) minutes"
        self.secondLabel!.text = "\(Int(seconds)) seconds"
    }
    
    func handleTapGesture(sender: UITapGestureRecognizer) {
        self.birthdayPickerView!.show()
    }
    
    func finishPick(date: NSDate) {
        self.birthday = date
    }
    
}
