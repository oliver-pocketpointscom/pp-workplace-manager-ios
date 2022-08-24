import UIKit

public class PPSettingsViewController: UITableViewController {
    
    var settings = ["Help Center", "Terms of Use", "Privacy Policy"]
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        navigationItem.title = "Workplace"
    }
}

extension PPSettingsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return settings.count
        }
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            cell.textLabel?.text = "My Profile"
            cell.accessoryType = .disclosureIndicator
        } else if indexPath.section == 1 {
            cell.textLabel?.text = settings[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "Logout Account"
        }
        return cell
    }
}
