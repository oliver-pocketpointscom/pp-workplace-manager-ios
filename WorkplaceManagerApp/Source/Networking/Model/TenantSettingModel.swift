import Foundation

public struct TenantSettingsModel {
    /**
    [
      {
        "daysOfTheWeek" : "Monday,Tuesday, Wednesday",
        "customerId" : null,
        "subscriptionId" : null,
        "id" : 13,
        "tenant_id" : 59,
        "cardNumber" : null,
        "startEarnPoints" : "14:00:00",
        "endEarnPoints" : "15:00:00",
        "timePerPoint" : 2,
        "billingAddress" : null,
        "paymentDate" : null
      }
    ]
    **/
    var daysOfTheWeek: [String]
    var startEarnPoints: String
    var endEarnPoints: String
    var timePerPoint: Int
    
    public init(daysOfTheWeek: [String], startEarnPoints: String, endEarnPoints: String, timePerPoint: Int) {
        self.daysOfTheWeek = daysOfTheWeek
        self.startEarnPoints = startEarnPoints
        self.endEarnPoints = endEarnPoints
        self.timePerPoint = timePerPoint
    }
}

extension TenantSettingsModel {
    
    public static func toModels(result: Any) -> [TenantSettingsModel] {
        var dest = [TenantSettingsModel]()
        if let response = result as? NSDictionary {
            if let jsonArray = response.object(forKey: "business_sectors") as? [NSDictionary] {
                for json in jsonArray {
                    let daysOfTheWeek = json.object(forKey: "daysOfTheWeek") as? String ?? ""
                    let startEarnPoints = json.object(forKey: "startEarnPoints") as? String ?? ""
                    let endEarnPoints = json.object(forKey: "endEarnPoints") as? String ?? ""
                    let timePerPoint = json.object(forKey: "timePerPoint") as? Int ?? -1
                    dest.append(TenantSettingsModel(daysOfTheWeek: daysOfTheWeek.components(separatedBy: ","),
                                                    startEarnPoints: startEarnPoints,
                                                    endEarnPoints: endEarnPoints,
                                                    timePerPoint: timePerPoint))
                }
            }
        }
        return dest
    }
}

