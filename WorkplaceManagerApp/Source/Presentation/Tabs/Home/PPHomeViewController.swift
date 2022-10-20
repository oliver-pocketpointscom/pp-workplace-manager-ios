import UIKit

public class PPHomeViewController: PPBaseViewController {
    
    var totalHours: Double = 0.0
    var totalRewards: Int = 0
    var totalEmployee: Int = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavBarTitle()
    }
    
    private func loadData() {
        Wire.Company.getDashBoard(tenantId: 49, completion: { [weak self] error in
            let realm = DataProvider.newInMemoryRealm()
            let results = realm.getDashboardObject()
            
            guard let strongSelf = self else { return }
            for r in results {
                strongSelf.totalHours = r.totalHoursSaved
                strongSelf.totalRewards = r.totalRewardsAchieved
            }
            self?.initView()
        })
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        view.backgroundColor = .black
        let customView = HomeView()
        customView.leftValueLabel.text = "\(self.totalHours) hours"
        customView.rightValueLabel.text = "\(self.totalRewards) rewards"
        self.view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
