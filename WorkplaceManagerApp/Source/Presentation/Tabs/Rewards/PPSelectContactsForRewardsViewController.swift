import UIKit
import SnapKit

public class PPSelectContactsForRewardsViewController: PPBaseTableViewController {
    public var rewardTitle: String?
    public var rewardDescription: String?
    
    private var contacts: [PPContact] = []
    private var selectedContactIds: [Int] = []
    
    public func getContacts() -> [PPContact] {
        contacts
    }
    
    private var didSelectAll = false
    
    private lazy var rewardsVM: RewardsViewModel = {
       PPRewardsViewModel()
    }()
    
    public lazy var contactsVM: ContactsViewModel = {
       PPContactsViewModel()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        addNavBarTitle()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadUsers()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .black
        tableView.separatorColor = .clear
        
        let sendBarButton = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(onSend))
        self.navigationItem.rightBarButtonItem  = sendBarButton
    }
    
    @objc func onSend() {
        guard let payload = getCreateRewardParameters() else {
            showInvalidRewardDetails()
            return
        }
        rewardsVM.createReward(payload: payload) {
            [weak self] (rewardId, error) in
            guard let strongSelf = self else { return }
            if let _ = error {
                strongSelf.showFailedToCreateRewardMessage()
            } else {
                if rewardId > 0 {
                    strongSelf.rewardUsers(rewardId)
                } else {
                    strongSelf.showFailedToCreateRewardMessage()
                }
            }
        }
    }
    
    private func rewardUsers(_ rewardId: Int) {
        let param = RewardUserParameters(reward_id: rewardId,
                                         status: 4,
                                         app_user_ids: selectedContactIds)
        rewardsVM.rewardUsers(payload: param) {
            [weak self] error in
            guard let strongSelf = self else { return }
            if let _  = error {
                strongSelf.showFailedToAllocateRewardMessage()
            } else {
                strongSelf.showSuccessDialog()
            }
        }
    }
    
    private func loadUsers() {
        contactsVM.getUsers(completion: { [weak self] (contacts, error) in
            guard let strongSelf = self else { return }
            strongSelf.contacts = contacts
            strongSelf.tableView.reloadData()
        })
    }
    
    private func getCreateRewardParameters() -> CreateRewardParameters? {
        let tenantId = DataProvider.newInMemoryRealm().getTenantId()
        let userId = DataProvider.newInMemoryRealm().getUserId()
        if let rewardTitle = self.rewardTitle,
           let rewardDescription = self.rewardDescription {
            return CreateRewardParameters(title: rewardTitle,
                                          description: rewardDescription,
                                          type: 1,
                                          status: 4,
                                          tenantId: tenantId,
                                          userId: userId)
        }
        return nil
    }
    
    private func showInvalidRewardDetails() {
        let message = "Incomplete reward details"
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showFailedToCreateRewardMessage() {
        let message = "Unable to create the reward. Kindly check your details and try again."
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showFailedToAllocateRewardMessage() {
        let message = "Unable to send the reward. Kindly check your details and try again."
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension PPSelectContactsForRewardsViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ContactTableViewCell {
            cell.tintColor = .white
            if didSelectAll {
                cell.accessoryType = .checkmark
            } else {
                if cell.accessoryType == .none {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
            }
            
            if let contact = cell.getContact() {
                selectedContactIds.append(contact.id)
            }
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getContacts().count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactTableViewCell()
        cell.roundImageView.image = UIImage(named: "pp")
        cell.setContact(getContacts()[indexPath.row])
        cell.checkBox.isHidden = false
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let button = UIButton(type: .system)
        button.setTitle("Select All", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectAll)))
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        return view
    }
    
    @objc func onSelectAll() {
        didSelectAll = true
        for section in 0..<tableView.numberOfSections {
            for row in 0..<tableView.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
            }
        }
        didSelectAll = false
    }
    
    private func showSuccessDialog() {
        let alert = UIAlertController(title: "Hooray!",
                                      message: "Reward sent.",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popToRootViewController(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showErrorDialog() {
        let alert = UIAlertController(title: "Oops! Something went wrong.",
                                      message: "We could not send your new reward right now. Please try again.",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popToRootViewController(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
    }
}
