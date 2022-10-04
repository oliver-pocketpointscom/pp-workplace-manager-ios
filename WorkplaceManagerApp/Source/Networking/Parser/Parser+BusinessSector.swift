import Foundation
import Alamofire

extension Parser {
    public struct BusinessSector {
        
        public static func parse(businessSectors: [BusinessSectorModel], completion: @escaping() -> Void) {
            let realm = DataProvider.newInMemoryRealm()
            
            realm.reset()
            
            for model in businessSectors {
                let object = BusinessSectorObject()
                object.key = model.key
                object.name = model.name
                object.desc = model.description
                try! realm.write {
                    realm.add(object)
                }
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
