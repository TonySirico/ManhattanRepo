//
//  HomeTableViewController.swift
//  Inaldo&Tony
//
//  Created by Antonio Sirica on 19/12/2017.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    //    var allNames = listOfPeople.shared.allNames
    var filteredPeople = [User]()
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        self.searchController.searchBar.barStyle = .blackTranslucent
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.searchBar.placeholder = "\"Name\" or \"#skill\""
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchController.searchBar.becomeFirstResponder()
        FriendSystem.system.showUser { () in
            self.tableView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredPeople.count
        }
        return FriendSystem.system.userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        var user = FriendSystem.system.userList[indexPath.row]
        
        if searchController.isActive && searchController.searchBar.text != "" {
            
            user = filteredPeople[indexPath.row]
        }
        else
        {
            user = FriendSystem.system.userList[indexPath.row]
        }
        cell.textLabel?.text = user.name + " " + user.surname
        
        return cell
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "unwindSegueToHome", sender: tableView)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToUserProfile", sender: tableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToUserProfile" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinazione = segue.destination as? ProfileSellerViewController
                if searchController.isActive && searchController.searchBar.text != "" {
                    let uid = filteredPeople[indexPath.row].id
                    destinazione?.userID = uid!
                } else {
                    let uid = FriendSystem.system.userList[indexPath.row].id
                    destinazione?.userID = uid!
                }
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchText: self.searchController.searchBar.text!)
    }
    
    func filterContent(searchText:String) {
        self.filteredPeople = FriendSystem.system.userList.filter { user in
            let username = user.name + " " + user.surname
            return(username.contains(searchText))
            
        }
        tableView.reloadData()
    }
    
}
