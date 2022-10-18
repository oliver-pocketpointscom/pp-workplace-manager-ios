public protocol RewardsViewModel {
    
    func createReward(payload: CreateRewardParameters, completion: @escaping(Error?) -> Void)
}
