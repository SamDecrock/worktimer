//
//  ViewController.swift
//  Timesheet
//
//  Created by Sam on 07/03/17.
//  Copyright © 2017 Sam Decrock. All rights reserved.
//

import UIKit


extension Date {
    func hoursAndMinutesToSeconds() -> Int {
        var components = NSCalendar.current.dateComponents([.hour, .minute] , from: self)
        return components.hour!*3600 + components.minute!*60
    }
}

class ViewController: UIViewController {

    
    @IBOutlet weak var pickerStart: UIDatePicker!
    @IBOutlet weak var pickerStartPauze: UIDatePicker!
    @IBOutlet weak var picerkEndPauze: UIDatePicker!
    @IBOutlet weak var pickerDeparture: UIDatePicker!
    
    @IBOutlet weak var lblTotalHours: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([.hour, .minute, .second] , from: Date())
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        self.pickerStart.setDate(calendar.date(from: components)!, animated: false)
        self.pickerStartPauze.setDate(calendar.date(from: components)!, animated: false)
        self.picerkEndPauze.setDate(calendar.date(from: components)!, animated: false)
        self.pickerDeparture.setDate(calendar.date(from: components)!, animated: false)
        
        self.loadTimes()
        self.updateTotalTime()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnArriving_touchUp(_ sender: Any) {
        self.pickerStart.setDate(Date(), animated: true)
        self.updateTotalTime()
        self.saveTimes()
    }

    @IBAction func btnStartPauze_touchUp(_ sender: Any) {
        self.pickerStartPauze.setDate(Date(), animated: true)
        self.updateTotalTime()
        self.saveTimes()
    }

    @IBAction func btnEndPauze_touchUp(_ sender: Any) {
        self.picerkEndPauze.setDate(Date(), animated: true)
        self.updateTotalTime()
        self.saveTimes()
    }
    
    @IBAction func btnDeparture_touchUp(_ sender: Any) {
        self.pickerDeparture.setDate(Date(), animated: true)
        self.updateTotalTime()
        self.saveTimes()
    }
    

    
    @IBAction func pickerStart_changed(_ sender: Any) {
        self.updateTotalTime()
        self.saveTimes()
    }
    
    @IBAction func pickerStartPauze_changed(_ sender: Any) {
        self.updateTotalTime()
        self.saveTimes()
    }
    
    @IBAction func pickerEndPauze_changed(_ sender: Any) {
        self.updateTotalTime()
        self.saveTimes()
    }

    @IBAction func pickerDeparture_changed(_ sender: Any) {
        self.updateTotalTime()
        self.saveTimes()
    }
    
    func updateTotalTime()  {
        let totalSeconds = self.pickerDeparture.date.hoursAndMinutesToSeconds() - self.pickerStart.date.hoursAndMinutesToSeconds()
                        - (self.picerkEndPauze.date.hoursAndMinutesToSeconds() - self.pickerStartPauze.date.hoursAndMinutesToSeconds())
        
        let totalHours = Double(totalSeconds) / 3600.0
        
        self.lblTotalHours.text = "\(round(totalHours*100)/100) uur."
    }
    
    func saveTimes() {
        let defaults = UserDefaults.standard
        defaults.setValue(self.pickerStart.date.timeIntervalSince1970, forKey: "start")
        defaults.setValue(self.pickerStartPauze.date.timeIntervalSince1970, forKey: "startpauze")
        defaults.setValue(self.picerkEndPauze.date.timeIntervalSince1970, forKey: "endpauze")
        defaults.setValue(self.pickerDeparture.date.timeIntervalSince1970, forKey: "departure")
        defaults.synchronize()
    }
    
    func loadTimes() {
        let defaults = UserDefaults.standard
        let start = defaults.double(forKey: "start")
        let startpauze = defaults.double(forKey: "startpauze")
        let endpauze = defaults.double(forKey: "endpauze")
        let departure = defaults.double(forKey: "departure")
        
        if start != 0 { self.pickerStart.setDate(Date(timeIntervalSince1970: start), animated: false) }
        if startpauze != 0 { self.pickerStartPauze.setDate(Date(timeIntervalSince1970: startpauze), animated: false) }
        if endpauze != 0 { self.picerkEndPauze.setDate(Date(timeIntervalSince1970: endpauze), animated: false) }
        if departure != 0 { self.pickerDeparture.setDate(Date(timeIntervalSince1970: departure), animated: false) }
    }
    
    
    
}

