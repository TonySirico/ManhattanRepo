//
//  TasksViewController.swift
//  Inaldo&Tony
//
//  Created by Antonio Sirica on 11/12/2017.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit


class OnGoingTaskCell: UITableViewCell {
    
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var skillRequestedLabel: UILabel!
    @IBOutlet weak var timeRequestedLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
        @IBOutlet weak var progressViewOutlet: UIProgressView!
    
}

class oldTaskCell: UITableViewCell {
    
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var timeRequestedLabel: UILabel!
    @IBOutlet weak var skillRequestedLabel: UILabel!
    
}


class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // TIMER CODE
    
    var countdownTimer: Timer!
    var refreshTimer: Timer!
    var totalTime: Double = 0
    
    //TIMER CODE END
    
    
    var namesA = ["Cecilia", "Pasquale", "Astrogildo", "Natalia", "Lis", "Perna"]
    var surnamesA = ["Silva Ribeiro", "Antonio Ramos Ribeiro", "Toschi Magalhes", "Salti", "Pereira Rios", "Oliveira da Silva Sauro"]
    var skillsA = ["Coding", "Desing", "Business", "Languages", "Other", "Other"]
    var timeRequestedA = ["50", "90", "130", "100", "11", "30"]
    var timeLeftA = ["12", "7", "100", "800", "47", "99"]
    
    var namesB = ["Lucia Vania", "Isabel Pereira", "Sol", "Danilo", "Kameni", "Taita"]
    var surnamesB = ["Silvao", "Perkiasi Silva Saurao", "Lete de Vinci", "Robatini Perske", "Olsen", "Ramos"]
    var skillsB = ["Coding", "Coding", "Design", "Other", "Other", "Other"]
    var timeRequestedB = ["20", "90", "90", "30", "30", "10"]
    var timeLeftB = ["288", "500", "100", "39", "0", "10"]
    
    let tableSections = ["Tasks in progress", "Ended Tasks" ]


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
        taskTableView.sectionIndexColor = UIColor.white
        
        // TIMER CODE
        
        startTimer()
        
        //deadilne
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 12
        dateComponents.day = 21
        dateComponents.timeZone = TimeZone(abbreviation: "UTC+1")
        dateComponents.hour = 8
        dateComponents.minute = 0
        dateComponents.second = 0
        
        let userCalendar = Calendar.current // user calendar
        let deadline = userCalendar.date(from: dateComponents)
        
        let todayDate = Date()
        
        totalTime = Double(CFDateGetTimeIntervalSinceDate(deadline! as CFDate, todayDate as CFDate))
        
    }
    
    //return the number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableSections.count
    }
    
    //return the title of sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.tableSections[section]
    }
    
    
    //return the rows number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch(segmentedControl.selectedSegmentIndex)
        {
        case 0:
           return namesA.count
           
        case 1:
            return namesB.count
            
        default:
            return 1
        }
        
    }
    
    //return the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch(segmentedControl.selectedSegmentIndex) //SWITCH SEGMENTED
        {
        case 0:
            switch (indexPath.section) {  //SWITCH SECTION
            case 0: //ON GOING
                let cell = tableView.dequeueReusableCell(withIdentifier: "onGoingCell") as! OnGoingTaskCell
                cell.nameSurnameLabel?.text = namesA[indexPath.row] + " " + surnamesA[indexPath.row]
                cell.skillRequestedLabel?.text = skillsA[indexPath.row]
                cell.timeRequestedLabel?.text = "(" + timeRequestedA[indexPath.row] + " TimeCoins)"
               //TIMER
                cell.timeLeftLabel?.text = "\(timeFormatted(Int(totalTime)))"
                cell.accessoryType = UITableViewCellAccessoryType.none
                //cell.nameSurnameLabel?.sizeToFit()
                cell.nameSurnameLabel?.adjustsFontSizeToFitWidth = true
                cell.skillRequestedLabel?.sizeToFit()
                cell.timeRequestedLabel?.sizeToFit()
                cell.timeLeftLabel?.adjustsFontSizeToFitWidth = true
               
              
               cell.progressViewOutlet.progress = Float((totalTime/259200))
                
                
                return cell
                
            case 1: //OLD
                let cell = tableView.dequeueReusableCell(withIdentifier: "oldCell") as! oldTaskCell
                cell.nameSurnameLabel?.text = namesB[indexPath.row] + " " + surnamesB[indexPath.row]
                cell.skillRequestedLabel?.text = skillsB[indexPath.row]
                cell.timeRequestedLabel?.text = timeRequestedB[indexPath.row]
                
                cell.nameSurnameLabel.adjustsFontSizeToFitWidth = true
                cell.skillRequestedLabel.sizeToFit()
                cell.timeRequestedLabel.sizeToFit()
                
                
                return cell
                
            default:
                break
            }
            
        case 1:
            switch (indexPath.section) {  //SWITCH SECTION
            case 0: //ON GOING
                let cell = tableView.dequeueReusableCell(withIdentifier: "onGoingCell") as! OnGoingTaskCell
                cell.nameSurnameLabel?.text = namesB[indexPath.row] + " " + surnamesB[indexPath.row]
                cell.skillRequestedLabel?.text = skillsB[indexPath.row]
                cell.timeRequestedLabel?.text = "(" + timeRequestedB[indexPath.row] + " TimeCoins)"
              //TIMER
                cell.timeLeftLabel?.text = "\(timeFormatted(Int(totalTime)))"
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                
                //cell.nameSurnameLabel?.sizeToFit()
                cell.nameSurnameLabel?.adjustsFontSizeToFitWidth = true
                cell.skillRequestedLabel?.sizeToFit()
                cell.timeRequestedLabel?.sizeToFit()
                cell.timeLeftLabel?.adjustsFontSizeToFitWidth = true
                
               cell.progressViewOutlet.progress = Float(totalTime/259200)
         

                
                return cell
                
            case 1: //OLD
                let cell = tableView.dequeueReusableCell(withIdentifier: "oldCell") as! oldTaskCell
                cell.nameSurnameLabel?.text = namesA[indexPath.row] + " " + surnamesB[indexPath.row]
                cell.skillRequestedLabel?.text = skillsA[indexPath.row]
                cell.timeRequestedLabel?.text = timeRequestedA[indexPath.row]
                
                cell.nameSurnameLabel.adjustsFontSizeToFitWidth = true
                cell.skillRequestedLabel.sizeToFit()
                cell.timeRequestedLabel.sizeToFit()
                
                
                return cell
                
            default:
                break
                
            }
            
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "oldCell")
                return cell!
              
            }
        let cell = tableView.dequeueReusableCell(withIdentifier: "oldCell")
        return cell!
    }
    
    
    @IBAction func Controller(_ sender: UISegmentedControl)
    {
        taskTableView.reloadData()
    }
    
    
    //tablerow actions on swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.section == 0 && segmentedControl.selectedSegmentIndex == 1 {
            
            
            
            
            let endTaskAction = UIContextualAction(style: .normal, title:  "End Task", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //
                success(true)
            })
           
            endTaskAction.backgroundColor = UIColor(red:0.31, green:0.82, blue:0.30, alpha:1.0)
            
            let chatAction = UIContextualAction(style: .normal, title:  "Chat", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //
                
                success(true)
            })
        
            chatAction.backgroundColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
            
            
            return UISwipeActionsConfiguration(actions: [endTaskAction, chatAction])
            
        }
        
         return UISwipeActionsConfiguration(actions: [])
        
    }
    
    
    //Custom Animation Function on UIImageView
    
    
    //TableView Custom Header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let view = view as? UITableViewHeaderFooterView {
            view.backgroundView?.backgroundColor = UIColor.black
            view.textLabel?.textColor = UIColor.white
            view.textLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        }
        
    }
    
    // TIMER CODE
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        refreshTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    @objc func updateLabel() {
        taskTableView.reloadData()
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours: Int = (totalSeconds / 3600)
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "\(hours)h \(minutes)\'")
    }

}
