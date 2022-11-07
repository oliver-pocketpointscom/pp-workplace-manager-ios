import Foundation

public protocol ChoosePlanViewModel {
    
    func getCheckoutUrl(tenantId: Int, completion: @escaping(String?, Error?) -> Void)
}
