//
//  RequestsViewController.swift
//  Inaldo&Tony
//
//  Created by Antonio Sirica on 11/12/2017.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class RequestCell: UITableViewCell {
    
    @IBOutlet weak var nameSurname: UILabel!
    @IBOutlet weak var skillRequested: UILabel!
    @IBOutlet weak var timeRequested: UILabel!
}



class RequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
  
    @IBOutlet weak var requestTableView: UITableView! 
    @IBOutlet weak var requestTabBarItem: UITabBarItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.requestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell" , for: indexPath) as? RequestCell
        
        cell!.nameSurname.text = FriendSystem.system.requestList[indexPath.row].name + " " + FriendSystem.system.requestList[indexPath.row].surname
        let credits = FriendSystem.system.requestList[indexPath.row].requestTime
        let hoursCoins = (credits!/60) % 24
        let minutesCoins = credits! % 60
        //cell!.timeRequested.text = String(FriendSystem.system.requestList[indexPath.row].requestTime) + " TimeCoins"
//        cell!.dateLabel.text = FriendSystem.system.requestList[indexPath.row].requestDate
        cell!.timeRequested.text = String(format: "%02d:%02d", hoursCoins, minutesCoins)
        cell!.skillRequested.text = FriendSystem.system.requestList[indexPath.row].requestDescription

        
        addBadgeToRequest()
        
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        requestTableView.dataSource = self
        requestTableView.delegate = self
        requestTableView.allowsSelection = true

        
        self.navigationController?.isNavigationBarHidden = true
        
        // Do any additional setup after loading the view.
        
        addBadgeToRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FriendSystem.system.showRequests {
            self.requestTableView.reloadData()
        }
        addBadgeToRequest()
    }

    override func viewDidDisappear(_ animated: Bool) {
        addBadgeToRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addBadgeToRequest()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addBadgeToRequest()
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //tablerow actions on swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let refuseAction = UIContextualAction(style: .normal, title:  "Refuse", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let id = FriendSystem.system.requestList[indexPath.row].id
            let date = FriendSystem.system.requestDates[indexPath.row]
            let timeRequests = FriendSystem.system.requestList[indexPath.row].requestTime
            FriendSystem.system.declineFriendRequest(date, id!)
            FriendSystem.system.getTimeCoinsCurrentUser(id!, { (timeCoins) in
                let idRef = Database.database().reference().child("users").child(id!)
                idRef.child("timeCoins").setValue(timeCoins+timeRequests!)
            })
            
            FriendSystem.system.requestList.remove(at: indexPath.row)
            FriendSystem.system.requestDates.remove(at: indexPath.row)
            
            self.addBadgeToRequest()
            
            self.requestTableView.deleteRows(at: [indexPath], with: .fade)
            success(true)
        })
        refuseAction.backgroundColor = UIColor(red:1.00, green:0.36, blue:0.32, alpha:1.0)
        
        
        let acceptAction = UIContextualAction(style: .normal, title:  "Accept", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let id = FriendSystem.system.requestList[indexPath.row].id
            let date = FriendSystem.system.requestDates[indexPath.row]
            let timeRequests = FriendSystem.system.requestList[indexPath.row].requestTime
            FriendSystem.system.acceptFriendRequest(date, id!)
            FriendSystem.system.getTimeCoinsCurrentUser(self.uid!, { (timeCoins) in
                let uidRef = Database.database().reference().child("users").child(self.uid!)
                uidRef.child("timeCoins").setValue(timeCoins+timeRequests!)
            })
            
            FriendSystem.system.requestList.remove(at: indexPath.row)
            FriendSystem.system.requestDates.remove(at: indexPath.row)
            
            self.addBadgeToRequest()
            
            self.requestTableView.deleteRows(at: [indexPath], with: .fade)
            
            success(true)
        })
      acceptAction.backgroundColor = UIColor(red:0.31, green:0.82, blue:0.30, alpha:1.0)
        
        let chatAction = UIContextualAction(style: .normal, title:  "Chat", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //
            
            
            success(true)
        })
       
        chatAction.backgroundColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
        
        
        return UISwipeActionsConfiguration(actions: [acceptAction, refuseAction])
    }
    
    
    func addBadgeToRequest() {
        
       
        if let tabItems = self.tabBarController?.tabBar.items as NSArray!
        {
            let tabItem = tabItems[1] as! UITabBarItem
            if FriendSystem.system.requestList.count != 0 {
                tabItem.badgeValue = "\(FriendSystem.system.requestList.count)"
            } else {
                tabItem.badgeValue = nil
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedIndexPath = tableView.indexPathForSelectedRow
        let selectedCell = tableView.cellForRow(at: selectedIndexPath!) as! RequestCell
        RequestDescription.shared.description = selectedCell.skillRequested.text!
       
        print(selectedCell.skillRequested.text!)
        print(RequestDescription.shared.description)
        
       
        
        //popup
        let popUpViewController = UIStoryboard(name: "Requests", bundle: nil).instantiateViewController(withIdentifier: "descriptionPopUp") as! PopUpViewController
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.addChildViewController(popUpViewController)
        popUpViewController.view.frame = self.view.frame
        self.view.addSubview(popUpViewController.view)
        popUpViewController.didMove(toParentViewController: self)
        
       
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
