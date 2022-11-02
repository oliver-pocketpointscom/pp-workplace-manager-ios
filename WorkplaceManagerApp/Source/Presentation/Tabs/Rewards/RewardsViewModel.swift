public protocol RewardsViewModel {
    
    func createReward(payload: CreateRewardParameters, completion: @escaping(Int, Error?) -> Void)
    func rewardUsers(payload: RewardUserParameters, completion: @escaping(Error?) -> Void)
}
