public class PPRewardsViewModel: RewardsViewModel {
    
    public func createReward(payload: CreateRewardParameters, completion: @escaping(Error?) -> Void) {
        Wire.Reward.createReward(payload: payload, completion: completion)
    }
}
