import Alamofire

public struct SignUpParameters {
    var email: String
    var phone: String
    var firstname: String
    var surname: String
    var company_logo: String
    var name: String
    var companyName: String
    var region: Int
    var sector: Int
    var status: Int

    public func toJSON() -> Parameters {
        return [
            "email": self.email,
            "phone": self.phone,
            "firstname": self.firstname,
            "surname": self.surname,
            "company_logo": self.company_logo,
            "name": self.name,
            "companyName": self.companyName,
            "region": self.region,
            "sector": self.sector,
            "status": self.status
        ]
    }
}
