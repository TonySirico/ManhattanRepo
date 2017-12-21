//
//  TasksViewController.swift
//  Inaldo&Tony
//
//  Created by Antonio Sirica on 11/12/2017.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


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
    let uid = Auth.auth().currentUser!.uid
    let ref = Database.database().reference()
    
    let tableSections = ["Tasks in progress", "Ended Tasks" ]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        FriendSystem.system.showUserOnGoing {
            print(FriendSystem.system.onGoingList)
            self.taskTableView.reloadData()
        }
        FriendSystem.system.showUserCompleted{
            print(FriendSystem.system.completedList)
            self.taskTableView.reloadData()
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        _ = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { (Timer) in
            self.taskTableView.reloadData()
        })
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
        taskTableView.sectionIndexColor = UIColor.white
        
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
        
        switch(section) {
        case 0:
            return FriendSystem.system.onGoingList.count
        default:
            return FriendSystem.system.completedList.count
        }
        
    }
    
    //return the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
            switch (indexPath.section) {  //SWITCH SECTION
            case 0: //ON GOING
                
                let stringDate = FriendSystem.system.onGoingList[indexPath.row].requestDate
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:MM:SS +0000"
                let dayOfRequest = formatter.date(from: stringDate!)
                let deadline = Date(timeInterval: 262800, since: dayOfRequest!)
                
                let totalTime = Int(CFDateGetTimeIntervalSinceDate(deadline as CFDate, Date() as CFDate))
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "onGoingCell") as! OnGoingTaskCell
                
                cell.progressViewOutlet.progress = Float((259200 - totalTime)/259200)
                cell.nameSurnameLabel?.text = FriendSystem.system.onGoingList[indexPath.row].name + " " + FriendSystem.system.onGoingList[indexPath.row].surname
                cell.skillRequestedLabel?.text = FriendSystem.system.onGoingList[indexPath.row].requestDescription
//                cell.timeRequestedLabel?.text = "(" + timeRequestedA[indexPath.row] + " TimeCoins)"
               //TIMER
                cell.timeLeftLabel?.text = "\(timeFormatted(Int(totalTime)))"
                cell.accessoryType = UITableViewCellAccessoryType.none
                //cell.nameSurnameLabel?.sizeToFit()
                cell.nameSurnameLabel?.adjustsFontSizeToFitWidth = true
                cell.skillRequestedLabel?.sizeToFit()
                cell.timeRequestedLabel?.sizeToFit()
                cell.timeLeftLabel?.adjustsFontSizeToFitWidth = true
                
                return cell
                
            case 1: //OLD
                let cell = tableView.dequeueReusableCell(withIdentifier: "oldCell") as! oldTaskCell
                cell.nameSurnameLabel?.text = FriendSystem.system.completedList[indexPath.row].name + " " + FriendSystem.system.completedList[indexPath.row].surname
//                cell.skillRequestedLabel?.text = skillsB[indexPath.row]
//                cell.timeRequestedLabel?.text = timeRequestedB[indexPath.row]

                cell.nameSurnameLabel.adjustsFontSizeToFitWidth = true
                cell.skillRequestedLabel.sizeToFit()
                cell.timeRequestedLabel.sizeToFit()

                return cell
                
            default:
                break
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
        
        if indexPath.section == 0 {
            
            let endTaskAction = UIContextualAction(style: .normal, title:  "End Task", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                var time = 0
                var description = ""
                var date = ""
                
                let currentUserRef = self.ref.child("users").child(self.uid)
                let id = FriendSystem.system.onGoingList[indexPath.row].id
                
                currentUserRef.child("requests").child("onGoingRequests").child(id!).observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    if let dictionary = DataSnapshot.value as? [String: AnyObject] {
                        time = dictionary["time"] as! Int
                        description = dictionary["description"] as! String
                        date = dictionary["date"] as! String
                        currentUserRef.child("requests").child("completedRequests").child(id!).setValue(["time": time, "bool": true, "description": description, "date": date])
                    }
                }, withCancel: nil)
                
                currentUserRef.child("requests").child("onGoingRequests").child(id!).removeValue()
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

    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours: Int = (totalSeconds / 3600)
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "\(hours)h \(minutes)\'")
    }
}
