import Foundation

public class PPChoosePlanViewModel: ChoosePlanViewModel {

    public func getCheckoutUrl(tenantId: Int, completion: @escaping (String?, Error?) -> Void) {
        Wire.Chargebee.getCheckoutUrl(tenantId: tenantId, completion: completion)
    }
}
