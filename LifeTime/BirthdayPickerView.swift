//
//  BirthdayPickerView.swift
//  LifeTime
//
//  Created by Madimo on 14-6-11.
//  Copyright (c) 2014年 Madimo. All rights reserved.
//

import UIKit

protocol BirthdayPickerViewDelegate {
    
    func finishPick(date: NSDate)
}

class BirthdayPickerView: NSObject {
    
    var delegate: BirthdayPickerViewDelegate?

    let _window: UIWindow!
    let _datePicker: UIDatePicker!
    let _toolbar: UIToolbar!
    
    init(height: CGFloat) {
        
        super.init()
        
        self._window = UIWindow()
        self._datePicker = UIDatePicker()
        self._toolbar = UIToolbar()
        
        self._window.frame = UIScreen.mainScreen().bounds
        
        var frame = UIScreen.mainScreen().bounds
        
        frame.size.height = height
        frame.origin.y = CGRectGetHeight(self._window.frame)
        self._toolbar.frame = frame
        
        frame.origin = CGPointMake(0, 0)
        self._datePicker.frame = frame
        self._datePicker.datePickerMode = .Date
        self._datePicker.date = NSDate()
        self._datePicker.calendar = NSCalendar.currentCalendar()
        self._datePicker.timeZone = NSTimeZone.localTimeZone()
        self._datePicker.minimumDate = NSDate(timeIntervalSinceNow: -3600 * 24 * 365 * 100)
        self._datePicker.maximumDate = NSDate()
        
        self._toolbar.addSubview(self._datePicker)
        
        self._window.addSubview(self._toolbar)
        
        let recognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
        self._window.addGestureRecognizer(recognizer)
    }
    
    func show() {
        
        if !self._window.hidden {
            return
        }
        
        self._window.makeKeyAndVisible()
        
        UIView.animateWithDuration(0.2,
            animations: {
                self._window.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
                var frame = self._toolbar.frame
                frame.origin.y = self._window.bounds.height - CGRectGetHeight(frame)
                self._toolbar.frame = frame
            },
            completion: nil)
    }
    
    func hide() {
        
        if self._window.hidden {
            return
        }
        
        UIView.animateWithDuration(0.2,
            animations: {
                self._window.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
                var frame = self._toolbar.frame
                frame.origin.y = CGRectGetHeight(self._window.frame)
                self._toolbar.frame = frame
            },
            completion: { (finished: Bool) in
                self._window.hidden = true
            })
        
        self.delegate?.finishPick(self._datePicker.date)
    }
    
    func handleTapGesture(sender: UITapGestureRecognizer) {
        self.hide()
    }
}
