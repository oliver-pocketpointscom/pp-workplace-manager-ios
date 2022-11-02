public struct PPContact {
    var id: Int
    var firstName: String
    var lastName: String
    var status: Int
    
    public func fullName() -> String {
        firstName + " " + lastName
    }
}
