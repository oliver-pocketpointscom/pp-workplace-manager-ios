import Foundation

public struct TenantSettingsModel {
    var daysOfTheWeek: [String]
    var startEarnPoints: String
    var endEarnPoints: String
    var timePerPoint: Int
}

extension TenantSettingsModel {
    
    public static func toModels(results: [Any]) -> [TenantSettingsModel] {
        var dest = [TenantSettingsModel]()
        for result in results {
            if let json = result as? NSDictionary {
                let daysOfTheWeek = json.object(forKey: "daysOfTheWeek") as? String ?? ""
                let startEarnPoints = json.object(forKey: "startEarnPoints") as? String ?? ""
                let endEarnPoints = json.object(forKey: "endEarnPoints") as? String ?? ""
                let timePerPoint = json.object(forKey: "timePerPoint") as? Int ?? -1
                let daysOfTheWeekSelected = daysOfTheWeek.components(separatedBy: ",")
                var trimmedValues = [String]()
                for days in daysOfTheWeekSelected {
                    trimmedValues.append(days.trimmingCharacters(in: .whitespaces))
                }
                dest.append(TenantSettingsModel(daysOfTheWeek: trimmedValues,
                                                startEarnPoints: startEarnPoints,
                                                endEarnPoints: endEarnPoints,
                                                timePerPoint: timePerPoint))
            }
        }
        return dest
    }
}

