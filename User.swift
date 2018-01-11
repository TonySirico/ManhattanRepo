import Foundation

class User {
    
    var name: String!
    var surname: String!
    var email: String!
    var id: String!
    var requestTime: Int!
    var requestDescription: String!
    var requestDate: String!
    var descriptions: String = ""
    var bool: Bool?
    
    init(userEmail: String, userID: String) {
        self.email = userEmail
        self.id = userID
        
    }
    
    init(userEmail: String, userName: String,userSurname: String, userID: String){
        self.email = userEmail
        self.id = userID
        self.name = userName
        self.surname = userSurname
    }
    
    init(userEmail: String, userName: String,userSurname: String, userID: String, userRequestTime: Int, userRequestDate: String, userRequestDescription: String){
        self.email = userEmail
        self.id = userID
        self.name = userName
        self.surname = userSurname
        self.requestTime = userRequestTime
        self.requestDate = userRequestDate
        self.requestDescription = userRequestDescription
        
    }
    
    init(userEmail: String, userName: String,userSurname: String, userID: String, descriptions: String){
        self.email = userEmail
        self.id = userID
        self.name = userName
        self.surname = userSurname
        self.descriptions = descriptions
    }
    
}
