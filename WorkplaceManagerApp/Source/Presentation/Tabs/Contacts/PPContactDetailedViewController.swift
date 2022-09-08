import UIKit

public protocol PPContactDetailedViewDelegate {
    func onDelete(id: Int)
}
public class PPContactDetailedViewController: PPBaseTableViewController {
    
    public var id: Int?
    public var profileImage: UIImage?
    public var name: String?
    public var active: Bool?
    public var department: String?
    public var mobile: String?
    public var delegate: PPContactDetailedViewDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clearNavBarTitle()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func initView() {
        tableView.backgroundColor = .backgroundColor()
        tableView.separatorColor = .clear
    }
    
    private func confirmDeleteContact() {
        let message = "Are you sure you want to delete this contact?"
        let alert = UIAlertController(title: "Delete Contact",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: {
            [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popViewController(animated: true)
            if let id = strongSelf.id {
                strongSelf.delegate?.onDelete(id: id)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension PPContactDetailedViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = ContactDetailsSections(rawValue: indexPath.section)
        
        switch section {
        case .heading, .details, .none:
            break
        case .delete:
            confirmDeleteContact()
            break
        }
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        ContactDetailsSections.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = ContactDetailsSections(rawValue: section)
        
        switch section {
        case .heading:
            return ContactHeadingRows.allCases.count
        case .details:
            return ContactDetailsRows.allCases.count
        case .delete:
            return 1
        case .none:
            return 0
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .default
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        
        let section = ContactDetailsSections(rawValue: indexPath.section)
        
        switch section {
        case .heading:
            let row = ContactHeadingRows(rawValue: indexPath.row)
            
            switch row {
            case .photo:
                cell.backgroundColor = .backgroundColor()
                let imageView = UIImageView(image: profileImage)
                imageView.layer.cornerRadius = 50
                imageView.layer.masksToBounds = true
                imageView.clipsToBounds = true
                cell.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.centerX.equalToSuperview()
                    make.height.width.equalTo(100)
                }
                break
            case .name:
                cell.backgroundColor = .backgroundColor()
                cell.textLabel?.text = name
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.font = .systemFont(ofSize: 20, weight: .bold)
                break
            case .status:
                cell.textLabel?.text = "Status"
                
                let switchButton = UISwitch()
                switchButton.isOn = active ?? false
                cell.contentView.addSubview(switchButton)
                switchButton.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().offset(-16)
                    make.top.equalToSuperview().offset(8)
                    make.bottom.equalToSuperview().offset(-8)
                }
                break
            case .none: break
            }
            
        case .details:
            let row = ContactDetailsRows(rawValue: indexPath.row)
            switch row {
            case .department:
                let cell = DetailedTableViewCell()
                cell.selectionStyle = .none
                cell.legendLabel.text = "position"
                cell.valueLabel.text = department
                return cell
            case .mobile:
                let cell = DetailedTableViewCell()
                cell.selectionStyle = .none
                cell.legendLabel.text = "mobile"
                cell.valueLabel.text = mobile
                return cell
            case .none: break
            }
        case .delete:
            cell.textLabel?.text = "Delete"
            cell.textLabel?.textAlignment = .natural
            cell.textLabel?.textColor = .red
        case .none: break
        }
        
        return cell
    }
}

public enum ContactDetailsSections: Int, Hashable, CaseIterable {
    case heading
    case details
    case delete
}

public enum ContactHeadingRows: Int, Hashable, CaseIterable {
    case photo
    case name
    case status
}

public enum ContactDetailsRows: Int, Hashable, CaseIterable {
    case department
    case mobile
}
