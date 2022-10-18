import Alamofire

public struct CreateUserParameters {
    var firstname: String
    var surname: String
    var phone: Int
    var tenantId: Int
    var invitedBy: Int
    var status: Int
    
    public init(firstname: String, surname: String, phone: Int, tenantId: Int, invitedBy: Int, status: Int) {
        self.firstname = firstname
        self.surname = surname
        self.phone = phone
        self.tenantId = tenantId
        self.invitedBy = invitedBy
        self.status = status
    }
    
    public func toJson() -> Parameters {
        return [
            "firstname": self.firstname,
            "surname": self.surname,
            "phone": self.phone,
            "tenant_id": self.tenantId,
            "invited_by": self.invitedBy,
            "status": self.status
        ]
    }
}
