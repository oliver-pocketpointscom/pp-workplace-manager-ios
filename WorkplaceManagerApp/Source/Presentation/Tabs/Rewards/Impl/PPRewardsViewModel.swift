public class PPRewardsViewModel: RewardsViewModel {
    
    public func createReward(payload: CreateRewardParameters, completion: @escaping(Int, Error?) -> Void) {
        Wire.Reward.createReward(payload: payload, completion: completion)
    }
    
    public func rewardUsers(payload: RewardUserParameters, completion: @escaping(Error?) -> Void) {
        Wire.Reward.rewardUsers(payload: payload, completion: completion)
    }
}
