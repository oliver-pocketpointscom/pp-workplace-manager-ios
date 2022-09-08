import UIKit

public class PPPendingInvitesViewController: PPBaseTableViewController {
    
    public var pendingInvites: [String]?
    
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
        tableView.backgroundColor = .backgroundColor()
        tableView.separatorColor = .clear
    }
        
    @objc func onCancelInvite(_ sender: UITapGestureRecognizer?) {
        let message = "Are you sure you want to cancel this invite?"
        let alert = UIAlertController(title: "Cancel Invite",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {
            [weak self] action in
            guard let strongSelf = self else { return }
            if let id = sender?.view?.tag {
                strongSelf.pendingInvites?.remove(at: id)
                strongSelf.tableView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension PPPendingInvitesViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pendingInvites?.count ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let value = pendingInvites?[indexPath.row]
        let cell = ContactTableViewCell()
        cell.label.text = value
        cell.selectionStyle = .none
        cell.accessoryType = .none
        cell.backgroundColor = .backgroundColor()
        cell.roundImageView.image = UIImage(named: "pp")
        cell.checkBox.image = UIImage(named: "remove")
        cell.checkBox.isHidden = false
        cell.checkBox.isUserInteractionEnabled = true
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCancelInvite(_:))))
        return cell
    }
}
