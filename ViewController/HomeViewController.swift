
//
//  HomeViewController.swift
//  Inaldo&Tony
//
//  Created by Inaldo Ramos Ribeiro on 11/12/2017.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit
import Firebase

class HomeCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBOutlet weak var nameOutlet: UILabel!
    
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    let mainColor = UIColor(red:0.48, green:0.73, blue:0.84, alpha:1.0)
    
    var filteredPeople = [User]()
    var searchController = UISearchController(searchResultsController: nil)
    var user = [User]()
    var ref = Database.database().reference()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredPeople.count
        }
        return FriendSystem.system.userList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! HomeCell
        var user = FriendSystem.system.userList[indexPath.row]
        if searchController.isActive && searchController.searchBar.text != "" {
            user = filteredPeople[indexPath.row]
        }
        else
        {
            user = FriendSystem.system.userList[indexPath.row]
        }
        cell.nameOutlet.text = user.name + " " + user.surname
        cell.nameOutlet.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "segueToProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToProfile" {
            if let indexPath = tableViewOutlet.indexPathForSelectedRow {
                let sendUID = segue.destination as? ProfileSellerViewController
                if searchController.isActive && searchController.searchBar.text != "" {
                    let userID = filteredPeople[indexPath.row].id
                    sendUID?.userID = userID!
                } else {
                let userID = FriendSystem.system.userList[indexPath.row].id
                sendUID?.userID = userID!
            }
        }
        
    }
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        moveLabelOut()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        moveButtonsOut()
        searchBar.frame.origin = CGPoint(x: 0.0, y: 15.0)
        print("DID BEGIN: ")
        print(searchBar.frame.origin)
        FriendSystem.system.showUser { () in
            self.tableViewOutlet.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("DID END 1: ")
        print(searchBar.frame.origin)
        searchBar.frame.origin = CGPoint(x: 0.0, y: 15.0)
        print("DID END 2: ")
        print(searchBar.frame.origin)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchText: self.searchController.searchBar.text!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        resignFirstResponder()
    }
    
    func filterContent(searchText:String) {
        self.filteredPeople = FriendSystem.system.userList.filter { user in
            let username = user.name + " " + user.surname + " " + user.descriptions

            return(username.contains(searchText))
            
        }
        tableViewOutlet.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        FriendSystem.system.showRequests {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        searchController.searchBar.tintColor = mainColor
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.searchController.searchBar.barStyle = .blackTranslucent
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.searchBar.placeholder = "\"Name\" or \"#skill\""
        
        self.firstButtonOutlet.center = CGPoint(x: super.view.frame.width/3.78787878, y:super.view.frame.height/3.97)
        
        self.secondButtonOutlet.center = CGPoint(x: super.view.frame.width/1.35869, y:super.view.frame.height/3.97)
        
        self.thirdButtonOutlet.center = CGPoint(x: super.view.frame.width/3.78787878, y:super.view.frame.height/1.9446)
        
        self.fourthButtonOutlet.center = CGPoint(x: super.view.frame.width/1.35869, y:super.view.frame.height/1.9446)
        
        self.fifthButtonOutlet.center = CGPoint(x: super.view.frame.width/3.78787878, y:super.view.frame.height/1.2876)
        
        self.sixthButtonOutlet.center = CGPoint(x: super.view.frame.width/1.35869, y:super.view.frame.height/1.2876)
        
        //settingUpSearchBar
        self.view.addSubview(self.searchController.searchBar)
        //self.searchController.searchBar.frame.origin = CGPoint(x: 0, y: 30)
        //------- SEARCH BAR CONTRAINTS
        
        
        
        //-----------------------------
        
        super.view.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:1.0)
        
        categoryLabelOutlet.center = CGPoint(x: super.view.frame.width/2, y:-super.view.frame.height/33.35)
        
        backButtonOutlet.center = CGPoint(x: super.view.frame.width/7.9, y: -super.view.frame.height/33.35)
        
        tableViewOutlet.frame.origin = CGPoint (x:0, y:super.view.frame.height)
        
        tableViewOutlet.delegate = self
        
        tableViewOutlet.dataSource = self
        
        backButtonOutlet.setImage(#imageLiteral(resourceName: "Back"), for: .normal)
        
        // Do any additional setup after loading the view.
        
        searchController.searchBar.frame.origin = CGPoint(x: 0.0, y: 15.0)
       
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        moveLabelOut()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveButtonsOut() {
        UIView.animate(withDuration: 0.3, animations: {self.firstButtonOutlet.center = CGPoint(x: -super.view.frame.width/5, y:super.view.frame.height/3.97)
        })
        UIView.animate(withDuration: 0.3, animations: {self.secondButtonOutlet.center = CGPoint(x: super.view.frame.width + super.view.frame.width/5, y:super.view.frame.height/3.97)
        })
        UIView.animate(withDuration: 0.3, animations: {self.thirdButtonOutlet.center = CGPoint(x: -super.view.frame.width/5, y:super.view.frame.height/1.9446)
        })
        UIView.animate(withDuration: 0.3, animations: {self.fourthButtonOutlet.center = CGPoint(x: super.view.frame.width + super.view.frame.width/5, y:super.view.frame.height/1.9446)
        })
        UIView.animate(withDuration: 0.3, animations: {self.fifthButtonOutlet.center = CGPoint(x: -super.view.frame.width/5, y:super.view.frame.height/1.2876)
        })
        UIView.animate(withDuration: 0.3, animations: {self.sixthButtonOutlet.center = CGPoint(x: super.view.frame.width + super.view.frame.width/5, y:super.view.frame.height/1.2876)
        })
        UIView.animate(withDuration: 0.5, delay: 0.3, animations: {self.tableViewOutlet.frame.origin = CGPoint (x:0, y:super.view.frame.height/7.666666)
        })
    }
    
    func moveButtonsIn() {
        UIView.animate(withDuration: 0.3, delay:0.3, animations: {self.firstButtonOutlet.center = CGPoint(x: super.view.frame.width/3.78787878, y:super.view.frame.height/3.97)
        })
        UIView.animate(withDuration: 0.3, delay:0.3, animations: {self.secondButtonOutlet.center = CGPoint(x: super.view.frame.width/1.35869, y:super.view.frame.height/3.97)
        })
        UIView.animate(withDuration: 0.3, delay:0.3, animations: {self.thirdButtonOutlet.center = CGPoint(x: super.view.frame.width/3.78787878, y:super.view.frame.height/1.9446)
        })
        UIView.animate(withDuration: 0.3, delay:0.3, animations: {self.fourthButtonOutlet.center = CGPoint(x: super.view.frame.width/1.35869, y:super.view.frame.height/1.9446)
        })
        UIView.animate(withDuration: 0.3, delay:0.3, animations: {self.fifthButtonOutlet.center = CGPoint(x: super.view.frame.width/3.78787878, y:super.view.frame.height/1.2876)
        })
        UIView.animate(withDuration: 0.3, delay:0.3, animations: {self.sixthButtonOutlet.center = CGPoint(x: super.view.frame.width/1.35869, y:super.view.frame.height/1.2876)
        })
        UIView.animate(withDuration: 0.3, animations: {self.tableViewOutlet.frame.origin = CGPoint (x:0, y:super.view.frame.height)
        })
    }
    
    func moveLabelIn() {
        moveButtonsOut()
        UIView.animate(withDuration: 0.3, animations: {self.categoryLabelOutlet.center = CGPoint(x: super.view.frame.width/2, y:(20 + self.searchController.searchBar.frame.height/2))
        })
        UIView.animate(withDuration: 0.3, animations: {self.searchController.searchBar.center = CGPoint(x: super.view.frame.width/2, y:-super.view.frame.height/11.9107)
        })
        UIView.animate(withDuration: 0.3, animations: {self.backButtonOutlet.center = CGPoint(x: super.view.frame.width/7.9, y:(20 + self.searchController.searchBar.frame.height/2))
        })
    }
    
    func moveLabelOut() {
        moveButtonsIn()
        UIView.animate(withDuration: 0.3, delay: 0.3, animations: {self.categoryLabelOutlet.center = CGPoint(x: super.view.frame.width/2, y:-super.view.frame.height/33.35)
        })
        UIView.animate(withDuration: 0.3, delay:0.3, animations: {self.searchController.searchBar.center = CGPoint(x: super.view.frame.width/2, y:54.5)
        })
        UIView.animate(withDuration: 0.3, delay:0.3, animations: {self.backButtonOutlet.center = CGPoint(x: super.view.frame.width/7.9, y:-super.view.frame.height/33.35)
        })
    }
    
    func prepareButtonsForBack() {
        self.firstButtonOutlet.center = CGPoint (x:-super.view.frame.width/1.48809, y:super.view.frame.height/3.97)
        self.thirdButtonOutlet.center = CGPoint (x:-super.view.frame.width/1.48809, y:super.view.frame.height/1.9446)
        self.fifthButtonOutlet.center = CGPoint (x:-super.view.frame.width/1.48809, y:super.view.frame.height/1.2876)
        self.secondButtonOutlet.center = CGPoint (x:-super.view.frame.width/5, y:super.view.frame.height/3.97)
        self.fourthButtonOutlet.center = CGPoint (x:-super.view.frame.width/5, y:super.view.frame.height/1.9446)
        self.sixthButtonOutlet.center = CGPoint (x:-super.view.frame.width/5, y:super.view.frame.height/1.2876)
    }
    
    func prepareBackButtonForCategories() {
        self.backButtonOutlet.center = CGPoint(x: super.view.frame.width/7.9, y:-super.view.frame.height/33.35)
    }
    
    @IBAction func swipeAction (_ sender: UISwipeGestureRecognizer) {
        searchController.searchBar.resignFirstResponder()
        prepareButtonsForBack()
        moveLabelOut()
    }
    
    @IBOutlet weak var categoryLabelOutlet: UILabel!
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBAction func backButtonAction(_ sender: UIButton) {
        moveLabelOut()
    }
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    @IBOutlet weak var firstButtonOutlet: UIButton!
    @IBAction func firstButtonAction(_ sender: UIButton) {
        FriendSystem.system.showUserCoding { () in
            self.tableViewOutlet.reloadData()
        }
        prepareBackButtonForCategories()
        categoryLabelOutlet.text = "Coding"
        moveLabelIn()
    }
    
    @IBOutlet weak var secondButtonOutlet: UIButton!
    @IBAction func secondButtonAction(_ sender: UIButton) {
        FriendSystem.system.showUserDesign { () in
            self.tableViewOutlet.reloadData()
        }
        prepareBackButtonForCategories()
        categoryLabelOutlet.text = "Design"
        moveLabelIn()
    }
    
    @IBOutlet weak var thirdButtonOutlet: UIButton!
    @IBAction func thirdButtonAction(_ sender: UIButton) {
        FriendSystem.system.showUserLanguage { () in
            self.tableViewOutlet.reloadData()
        }
        prepareBackButtonForCategories()
        categoryLabelOutlet.text = "Language"
        moveLabelIn()
    }
    
    @IBOutlet weak var fourthButtonOutlet: UIButton!
    @IBAction func fourthButtonAction(_ sender: UIButton) {
        FriendSystem.system.showUserBusiness { () in
            self.tableViewOutlet.reloadData()
        }
        prepareBackButtonForCategories()
        categoryLabelOutlet.text = "Business"
        moveLabelIn()
    }
    
    @IBOutlet weak var fifthButtonOutlet: UIButton!
    @IBAction func fifthButtonAction(_ sender: UIButton) {
        FriendSystem.system.showUserScience { () in
            self.tableViewOutlet.reloadData()
        }
        prepareBackButtonForCategories()
        categoryLabelOutlet.text = "Science"
        moveLabelIn()
    }
    
    @IBOutlet weak var sixthButtonOutlet: UIButton!
    @IBAction func sixthButtonAction(_ sender: UIButton) {
        FriendSystem.system.showUserOther { () in
            self.tableViewOutlet.reloadData()
        }
        prepareBackButtonForCategories()
        categoryLabelOutlet.text = "Others"
        moveLabelIn()
    }
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue) { }
    
//
//    override func viewWillAppear(_ animated: Bool) {
//
//        if let tabItems = self.tabBarController?.tabBar.items as NSArray!
//        {
//            // Si deve modificare il secondo elemento
//            let tabItem = tabItems[1] as! UITabBarItem
//
//            if FriendSystem.system.requestList.count != 0 {
//
//                tabItem.badgeValue = "\(FriendSystem.system.requestList.count)"
//            }
//        }
//
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
