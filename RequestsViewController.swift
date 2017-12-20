//
//  RequestsViewController.swift
//  Inaldo&Tony
//
//  Created by Antonio Sirica on 11/12/2017.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit


class requestCell: UITableViewCell {
    
    @IBOutlet weak var nameSurname: UILabel!
    @IBOutlet weak var skillRequested: UILabel!
    @IBOutlet weak var timeRequested: UILabel!
    
}



class RequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var requestTableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell") as! requestCell
        cell.nameSurname?.text = "Name Surname"
        cell.skillRequested?.text = "Coding"
        cell.timeRequested?.text = "45"
        
        cell.nameSurname?.adjustsFontSizeToFitWidth = true
        
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTableView.dataSource = self
        requestTableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //tablerow actions on swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let refuseAction = UIContextualAction(style: .normal, title:  "Refuse", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            success(true)
        })
        refuseAction.backgroundColor = UIColor(red:1.00, green:0.36, blue:0.32, alpha:1.0)
        
        
        let acceptAction = UIContextualAction(style: .normal, title:  "Accept", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //
            success(true)
        })
      acceptAction.backgroundColor = UIColor(red:0.31, green:0.82, blue:0.30, alpha:1.0)
        
        let chatAction = UIContextualAction(style: .normal, title:  "Chat", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //
            
            success(true)
        })
       
        chatAction.backgroundColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.0)
        
        
        return UISwipeActionsConfiguration(actions: [acceptAction, refuseAction, chatAction])
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
