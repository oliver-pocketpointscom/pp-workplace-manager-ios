import UIKit

public class PPHomeViewController: PPBaseTableViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavBarTitle()
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
            cell.titleLabel.text = "379 hrs"
            cell.descriptionLabel.text = "Total Hours Saved"
            break
        case .rewards:
            cell.titleLabel.text = "12 Rewards"
            cell.descriptionLabel.text = "Total Rewards Awarded"
            cell.roundImageView.image = UIImage(named: "employee_award")
            break
        case .employees:
            cell.titleLabel.text = "25 Employees"
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
