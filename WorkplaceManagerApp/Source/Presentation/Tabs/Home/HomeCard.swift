public struct HomeCard {
    var totalHours: Double
    var totalRewards: Int
    var totalEmployees: Int
    
    public init(totalHours: Double, totalRewards: Int, totalEmployees: Int) {
        self.totalHours = totalHours
        self.totalRewards = totalRewards
        self.totalEmployees = totalEmployees
    }
}
