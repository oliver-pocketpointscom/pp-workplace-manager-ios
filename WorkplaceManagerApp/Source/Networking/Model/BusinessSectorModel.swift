import Foundation

public struct BusinessSectorModel {
    var key: Int = 0
    var name: String = ""
    var description: String = ""
}

extension BusinessSectorModel {
    
    public static func toModels(result: Any) -> [BusinessSectorModel] {
        var businessSectors = [BusinessSectorModel]()
        if let response = result as? NSDictionary {
            if let businessSectorsJson = response.object(forKey: "business_sectors") as? [NSDictionary] {
                for businessSectorJson in businessSectorsJson {
                    let key = businessSectorJson.object(forKey: "key") as? Int ?? 0
                    let name = businessSectorJson.object(forKey: "name") as? String ?? ""
                    let description = businessSectorJson.object(forKey: "description") as? String ?? ""
                    businessSectors.append(BusinessSectorModel(key: key, name: name, description: description))
                }
            }
        }
        return businessSectors
    }
}
