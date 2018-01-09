//
//  SellerProfileSingleton.swift
//  Inaldo&Tony
//
//  Created by Antonio Sirica on 19/12/2017.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class FriendSystem {
    static let system = FriendSystem()
    var timeCoins = 0
    
    // MARK: - Firebase references
    let ref = Database.database().reference()
    let userRef = Database.database().reference().child("users")
    /** The Firebase reference to the current user tree */
    var currentUserRef: DatabaseReference {
        let id = Auth.auth().currentUser!.uid
        return userRef.child("\(id)")
    }
    /** The Firebase reference to the current user's friend tree */
    var  currentUserFriendsRef: DatabaseReference {
        return currentUserRef.child("friends")
    }
    /** The Firebase reference to the current user's friend request tree */
    var currentUserRequestRef: DatabaseReference {
        return currentUserRef.child("requests")
    }
    /** The current user's id */
    var uid: String {
        let id = Auth.auth().currentUser!.uid
        return id
    }
    
    var completedList = [User]()
    func showUserCompleted(_ update: @escaping () -> Void) {
        currentUserRef.child("requests").child("completedRequests").observe(DataEventType.value, with: { (snapshot) in
            self.completedList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let fullKey = child.key
                let components = fullKey.components(separatedBy: ",")
                let date = components[0]
                let id = components[1]
                self.getUser(id, { (user) in
                    let requestTime = snapshot.childSnapshot(forPath: "\(fullKey)/time").value as! Int
                    let requestDescription = snapshot.childSnapshot(forPath: "\(fullKey)/description").value as! String
                    let bool = snapshot.childSnapshot(forPath: "\(fullKey)/bool").value as! Bool
                    user.requestTime = requestTime //aggiunge all'utente creato in requestList anche quanto tempo ha chiesto
                    user.requestDate = date
                    user.requestDescription = requestDescription
                    user.bool = bool
                    self.completedList.append(user)
                    update()
                })
            }
            // If there are no children, run completion here instead
            if snapshot.childrenCount == 0 {
                update()
            }
        })
    }
    
    func getUser(_ userID: String,_ completion: @escaping (User) -> Void) {
    userRef.child(userID).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
    let email = snapshot.childSnapshot(forPath: "email").value as! String
    let username = snapshot.childSnapshot(forPath: "name").value as! String
    let usersurname = snapshot.childSnapshot(forPath: "surname").value as! String
    let id = snapshot.key
    completion(User(userEmail: email, userName: username, userSurname: usersurname, userID: id))
    })
    }
    
    func getTimeCoinsCurrentUser(_ uid: String,_ completion: @escaping (Int) -> Void) {
        userRef.child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
            let timeCoins = snapshot.childSnapshot(forPath: "timeCoins").value as! Int
            print("COINS RETURNED \(timeCoins)")
            completion(timeCoins)
        })
    }
    
    //manda una richiesta ad un utente aggiungendo a tale utente un figlio nella sezione request
    func sendRequestToUser(_ userID: String, _ time: Int, _ date: String, _ description: String) {
        self.userRef.child(userID).child("requests").child("newRequests").child(date + "," + self.uid).setValue(["time": time, "bool": true, "date": date, "description": description])
    }
    
    /** Accepts a friend request from the user with the specified id */
    func acceptFriendRequest(_ date: String, _ id: String) {
        
        var time = 0
        var description = ""
        // utilizziamo questo observe per spostare il tempo e la richiesta da newRequests a onGoingRequests
        currentUserRef.child("requests").child("newRequests").child(date + "," + id).observeSingleEvent(of: .value, with: { (DataSnapshot) in
            if let dictionary = DataSnapshot.value as? [String: AnyObject] {
                time = dictionary["time"] as! Int
                description = dictionary["description"] as! String
                self.currentUserRef.child("requests").child("onGoingRequests").child(date + "," + id).setValue(["time": time, "bool": true, "description": description, "date": date])
            }
        }, withCancel: nil)
        currentUserRef.child("requests").child("newRequests").child(date + "," + id).removeValue()
    }
    
    func declineFriendRequest(_ date: String, _ userID: String) {
        
        currentUserRef.child("requests").child("newRequests").child(date + "," + userID).removeValue()
    }
    
    func showTimeRequest() {
        currentUserRef.child("requests").child("newRequests").observe(.value, with: { (DataSnapshot) in
            
        })
        
    }
    
    var requestDates: [String] = []
    var requestList = [User]()
    
    func showRequests(_ update: @escaping () -> Void) {
        currentUserRequestRef.child("newRequests").observeSingleEvent(of: .value, with: { (snapshot) in
            self.requestList.removeAll()
            self.requestDates.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let fullKey = child.key
                let components = fullKey.components(separatedBy: ",")
                let date = components[0]
                let id = components[1]
                let requestTime = snapshot.childSnapshot(forPath: "\(fullKey)/time").value as! Int
                let requestDescription = snapshot.childSnapshot(forPath: "\(fullKey)/description").value as! String
                self.getUser(id, { (user) in
                    user.requestTime = requestTime //aggiunge all'utente creato in requestList anche quanto tempo ha chiesto
                    user.requestDate = date
                    user.requestDescription = requestDescription
                    self.requestList.append(user)
                    self.requestDates.append(date)
                    update()
                })
            }
            if snapshot.childrenCount == 0 {
                update()
            }
        })
//        currentUserRequestRef.child("newRequests").observe(DataEventType.value, with: { (snapshot) in
//            self.requestList.removeAll()
//            for child in snapshot.children.allObjects as! [DataSnapshot] {
//                let id = child.key
//                let requestTime = snapshot.childSnapshot(forPath: "request\(id)/time").value as! Int
//                let requestDate = snapshot.childSnapshot(forPath: "\(id)/date").value as! String
//                let requestDescription = snapshot.childSnapshot(forPath: "\(id)/description").value as! String
//                self.getUser(id, { (user) in
//                    user.requestTime = requestTime //aggiunge all'utente creato in requestList anche quanto tempo ha chiesto
//                    user.requestDate = requestDate
//                    user.requestDescription = requestDescription
//                    self.requestList.append(user)
//                    update()
//                })
//            }
//            // If there are no children, run completion here instead
//            if snapshot.childrenCount == 0 {
//                update()
//            }
//        })
    }
    
    var userList = [User]()
    
    func showUser(_ update: @escaping () -> Void) {
        FriendSystem.system.userRef.observe(DataEventType.value, with: { (snapshot) in
            self.userList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let email = child.childSnapshot(forPath: "email").value as! String
                let name = child.childSnapshot(forPath: "name").value as! String
                let surname = child.childSnapshot(forPath: "surname").value as! String
                let codingDescription = child.childSnapshot(forPath: "skill/coding").value as! String
                let designDescription = child.childSnapshot(forPath: "skill/design").value as! String
                let businessDescription = child.childSnapshot(forPath: "skill/business").value as! String
                let languageDescription = child.childSnapshot(forPath: "skill/language").value as! String
                let otherDescription = child.childSnapshot(forPath: "skill/other").value as! String
                let scienceDescription = child.childSnapshot(forPath: "skill/science").value as! String
                let descriptions = codingDescription + " " + designDescription + " " + businessDescription + " " + languageDescription + " " + otherDescription + " " + scienceDescription
                
                if email != Auth.auth().currentUser?.email! {
                    self.userList.append(User(userEmail: email, userName: name, userSurname: surname, userID: child.key, descriptions: descriptions))
                }
            }
            update()
        })
    }
    
    func showUserCoding(_ update: @escaping () -> Void) {
        FriendSystem.system.userRef.observe(DataEventType.value, with: { (snapshot) in
            self.userList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let email = child.childSnapshot(forPath: "email").value as! String
                let name = child.childSnapshot(forPath: "name").value as! String
                let coding = child.childSnapshot(forPath: "skill/coding").value as! String
                
                let surname = child.childSnapshot(forPath: "surname").value as! String
                if email != Auth.auth().currentUser?.email! && coding != "" {
                    self.userList.append(User(userEmail: email, userName: name, userSurname: surname, userID: child.key))
                }
            }
            update()
        })
    }
    
    func showUserDesign(_ update: @escaping () -> Void) {
        FriendSystem.system.userRef.observe(DataEventType.value, with: { (snapshot) in
            self.userList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let email = child.childSnapshot(forPath: "email").value as! String
                let name = child.childSnapshot(forPath: "name").value as! String
                let design = child.childSnapshot(forPath: "skill/design").value as! String
                let surname = child.childSnapshot(forPath: "surname").value as! String
                if email != Auth.auth().currentUser?.email! && design != "" {
                    self.userList.append(User(userEmail: email, userName: name, userSurname: surname, userID: child.key))
                }
            }
            update()
        })
    }
    
    func showUserBusiness(_ update: @escaping () -> Void) {
        FriendSystem.system.userRef.observe(DataEventType.value, with: { (snapshot) in
            self.userList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let email = child.childSnapshot(forPath: "email").value as! String
                let name = child.childSnapshot(forPath: "name").value as! String
                let business = child.childSnapshot(forPath: "skill/business").value as! String
                let surname = child.childSnapshot(forPath: "surname").value as! String
                if email != Auth.auth().currentUser?.email! && business != "" {
                    self.userList.append(User(userEmail: email, userName: name, userSurname: surname, userID: child.key))
                }
            }
            update()
        })
    }
    
    func showUserLanguage(_ update: @escaping () -> Void) {
        FriendSystem.system.userRef.observe(DataEventType.value, with: { (snapshot) in
            self.userList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let email = child.childSnapshot(forPath: "email").value as! String
                let name = child.childSnapshot(forPath: "name").value as! String
                let language = child.childSnapshot(forPath: "skill/language").value as! String
                let surname = child.childSnapshot(forPath: "surname").value as! String
                if email != Auth.auth().currentUser?.email! && language != "" {
                    self.userList.append(User(userEmail: email, userName: name, userSurname: surname, userID: child.key))
                }
            }
            update()
        })
    }
    
    func showUserScience(_ update: @escaping () -> Void) {
        FriendSystem.system.userRef.observe(DataEventType.value, with: { (snapshot) in
            self.userList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let email = child.childSnapshot(forPath: "email").value as! String
                let name = child.childSnapshot(forPath: "name").value as! String
                let science = child.childSnapshot(forPath: "skill/science").value as! String
                let surname = child.childSnapshot(forPath: "surname").value as! String
                if email != Auth.auth().currentUser?.email! && science != "" {
                    self.userList.append(User(userEmail: email, userName: name, userSurname: surname, userID: child.key))
                }
            }
            update()
        })
    }
    
    func showUserOther(_ update: @escaping () -> Void) {
        FriendSystem.system.userRef.observe(DataEventType.value, with: { (snapshot) in
            self.userList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let email = child.childSnapshot(forPath: "email").value as! String
                let name = child.childSnapshot(forPath: "name").value as! String
                let other = child.childSnapshot(forPath: "skill/other").value as! String
                let surname = child.childSnapshot(forPath: "surname").value as! String
                if email != Auth.auth().currentUser?.email! && other != "" {
                    self.userList.append(User(userEmail: email, userName: name, userSurname: surname, userID: child.key))
                }
            }
            update()
        })
    }
    
    var onGoingList = [User]()
    var onGoingDates: [String] = []
    
    func showUserOnGoing(_ update: @escaping () -> Void) {
        currentUserRef.child("requests").child("onGoingRequests").observe(DataEventType.value, with: { (snapshot) in
            self.onGoingList.removeAll()
            self.onGoingDates.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let fullKey = child.key
                let components = fullKey.components(separatedBy: ",")
                let date = components[0]
                let id = components[1]
                self.getUser(id, { (user) in
                    let requestTime = snapshot.childSnapshot(forPath: "\(fullKey)/time").value as! Int
                    let requestDescription = snapshot.childSnapshot(forPath: "\(fullKey)/description").value as! String
                    user.requestTime = requestTime //aggiunge all'utente creato in requestList anche quanto tempo ha chiesto
                    user.requestDate = date
                    user.requestDescription = requestDescription
                    self.onGoingList.append(user)
                    self.onGoingDates.append(date)
                    update()
                })
            }
            // If there are no children, run completion here instead
            if snapshot.childrenCount == 0 {
                update()
            }
        })
    }
}

class Singleton {
    static var shared = Singleton()
    var array: [ProfileSeller] = []
}

class ProfileSeller {
    static var shared = ProfileSeller()
    var profilePic = UIImage()
    var name = ""
    var surname = ""
    var birthday = ""
    var badge = 0
    var timeCoins = 0
    var codingDescription = ""
    var designDescription = ""
    var businessDescription = ""
    var languageDescription = ""
    var scienceDescription = ""
    var othersDescription = ""
}

class listOfPeople {
    static let shared = listOfPeople()
    var allNames = [String]()
}
