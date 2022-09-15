import UIKit

public class PPContactListViewController: PPBaseTableViewController {
    
    public var employees: [String]?
    public var position: [String]?
    public var mobile: [String]?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearNavBarTitle()
        addTitle("Pending Invites")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .black
        tableView.separatorColor = .clear
    }
        
    private func openContactDetails(index: Int) {
        let vc = PPContactDetailedViewController(style: .grouped)
        vc.id = index
        vc.profileImage = UIImage(named: "pp")
        vc.name = employees?[index]
        vc.active = true
        vc.department = position?[index]
        vc.mobile = mobile?[index]
        vc.delegate = self
        push(vc: vc)
    }
}

extension PPContactListViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openContactDetails(index: indexPath.row)
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees?.count ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let value = employees?[indexPath.row]
        let cell = ContactTableViewCell()
        cell.label.text = value
        cell.label.textColor = .white
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
        cell.roundImageView.image = UIImage(named: "pp")
        return cell
    }
}

extension PPContactListViewController: PPContactDetailedViewDelegate {
    
    public func onDelete(id: Int) {
        employees?.remove(at: id)
        tableView.reloadData()
    }
}
