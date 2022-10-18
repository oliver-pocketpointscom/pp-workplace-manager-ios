import Alamofire

public struct SignUpParameters {
    private var email: String
    private var phone: String
    private var firstname: String
    private var surname: String
    private var company_logo: String
    private var name: String
    private var companyName: String
    private var region: Int
    private var sector: Int
    private var status: Int
    
    public init(email: String, phone: String, firstname: String, surname: String, company_logo: String, name: String, companyName: String, region: Int, sector: Int, status: Int) {
        self.email = email
        self.phone = phone
        self.firstname = firstname
        self.surname = surname
        self.company_logo = company_logo
        self.name = name
        self.companyName = companyName
        self.region = region
        self.sector = sector
        self.status = status
    }
    
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
