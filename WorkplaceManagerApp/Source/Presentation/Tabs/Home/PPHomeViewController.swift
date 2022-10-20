import UIKit

public class PPHomeViewController: PPBaseTableViewController {
    
    private var homeCard: HomeCard?
    
    private lazy var viewModel: HomeViewModel = {
        PPHomeViewModel()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavBarTitle()
        loadData()
    }
    
    private func loadData() {
        let tenantId = 49 //DataProvider.newInMemoryRealm().getTenantId()
        viewModel.loadData(tenantId: tenantId) { [weak self] homeCard in
            guard let strongSelf = self else { return }
            strongSelf.homeCard = homeCard
            strongSelf.tableView.reloadData()
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .black
        tableView.separatorColor = .clear
    }
}

extension PPHomeViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        CardSections.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CardTableViewCell()
        let section = CardSections(rawValue: indexPath.section)
        
        switch section {
        case .savings:
            cell.titleLabel.text = "\(homeCard?.totalHours ?? 0) hrs"
            cell.descriptionLabel.text = "Total Hours Saved"
            break
        case .rewards:
            cell.titleLabel.text = "\(homeCard?.totalRewards ?? 0) Rewards"
            cell.descriptionLabel.text = "Total Rewards Awarded"
            cell.roundImageView.image = UIImage(named: "employee_award")
            break
        case .employees:
            cell.titleLabel.text = "\(homeCard?.totalEmployees ?? 0) Employees"
            cell.descriptionLabel.text = "Number of Employees"
            cell.roundImageView.image = UIImage(named: "employees")
            break
        case .none:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? UITableView.automaticDimension : 0
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? getTableHeaderView() : nil
    }
    
    private func getTableHeaderView() -> UIView {
        let container = UIView()
        container.backgroundColor = .clear
        let label = UILabel()
        label.text = "Keeping your staff Focused, Productive & Safe by Rewarding Healthy Mobile Behaviour in the Workplace"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        container.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.trailing.equalToSuperview().offset(-16)
        }
        return container
    }
}

public enum CardSections: Int, Hashable, CaseIterable  {
    case savings
    case rewards
    case employees
}
