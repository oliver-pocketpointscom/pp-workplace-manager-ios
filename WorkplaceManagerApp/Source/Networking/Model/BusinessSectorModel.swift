import Foundation

public struct BusinessSectorModel {
    var key: String = ""
    var name: String = ""
    var description: String = ""
    
    public init(key: String, name: String, description: String) {
        self.key = key
        self.name = name
        self.description = description
    }
}

extension BusinessSectorModel {
    
    public static func toModels(result: Any) -> [BusinessSectorModel] {
        var businessSectors = [BusinessSectorModel]()
        if let response = result as? NSDictionary {
            if let businessSectorsJson = response.object(forKey: "business_sectors") as? [NSDictionary] {
                for businessSectorJson in businessSectorsJson {
                    var key = ""
                    if let keyInt = businessSectorJson.object(forKey: "key") as? Int {
                        key = String(describing: keyInt)
                    }                     
                    let name = businessSectorJson.object(forKey: "name") as? String ?? ""
                    let description = businessSectorJson.object(forKey: "description") as? String ?? ""
                    businessSectors.append(BusinessSectorModel(key: key, name: name, description: description))
                }
            }
        }
        return businessSectors
    }
}
