import Foundation

class User {
    
    var name: String!
    var surname: String!
    var email: String!
    var id: String!
    var requestTime: Int!
    
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
    
    init(userEmail: String, userName: String,userSurname: String, userID: String, userRequestTime: Int){
        self.email = userEmail
        self.id = userID
        self.name = userName
        self.surname = userSurname
        self.requestTime = userRequestTime
        
    }
    
}
