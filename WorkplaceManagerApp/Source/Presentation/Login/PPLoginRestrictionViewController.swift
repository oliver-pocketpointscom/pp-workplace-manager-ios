import UIKit

public class PPLoginRestrictionViewController: PPBaseTableViewController {
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
    }
    
    @objc func onLogout() {
        showLoginScreen()
    }
    
    private func showLoginScreen() {
        let vc = PPOnboardingViewController()
        let nc = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = nc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @objc func onSubscribe() {
        showUnderConstructionDialog()
    }
    
    @objc func onDisplayFAQs() {
        showUnderConstructionDialog()
    }
}

extension PPLoginRestrictionViewController {
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        LoginRestrictionSections.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let section = LoginRestrictionSections(rawValue: section)
        switch section {
            case .info:
                return LoginRestrictionInfoRows.allCases.count
            case .logout: return 1
            case .none: return 0
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none

        let section = LoginRestrictionSections(rawValue: indexPath.section)
        switch section {
        case .info:
            let row = LoginRestrictionInfoRows(rawValue: indexPath.row)
            switch row {
                case .headingImage:
                    let headingCell = HeadingImageTableViewCell()
                    headingCell.customImageView.image = UIImage(named: "notfound")
                    headingCell.selectionStyle = .none
                    return headingCell
                case .heading:
                    cell.textLabel?.textAlignment = .center
                    cell.textLabel?.font = .systemFont(ofSize: 22)
                    cell.textLabel?.text = "Subcription not found"
                    break
                case .description:
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.textAlignment = .justified
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    cell.textLabel?.text = "We can't find an active subscription for this account. You can tap the Subscribe button below to get started."
                    break
                case .subscribe:
                    let btnCell = ButtonTableViewCell()
                    btnCell.button.setTitle("Subscribe", for: .normal)
                    btnCell.button.backgroundColor = .primary()
                    btnCell.button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSubscribe)))
                    btnCell.selectionStyle = .none
                    return btnCell
                case .footer:
                    cell.textLabel?.numberOfLines = 0
                    cell.textLabel?.textAlignment = .justified
                    cell.textLabel?.lineBreakMode = .byWordWrapping
                    cell.textLabel?.text = "If you have already subscribed, please allow at least 24-hours to activate your account. For help and concerns, kindly contact our support team at support@pocketpoints.com or you can check our FAQs."
                    break
                case .faq:
                    let btnCell = ButtonTableViewCell()
                    btnCell.button.setTitle("FAQS", for: .normal)
                    btnCell.button.backgroundColor = .lightGray
                    btnCell.button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDisplayFAQs)))
                    btnCell.selectionStyle = .none
                    return btnCell
            case .none: break
            }
        case .logout:
            let btnCell = ButtonTableViewCell()
            btnCell.button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLogout)))
            btnCell.selectionStyle = .none
            return btnCell
        case .none: break
        }
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        " "
    }
    
    public override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = .white
    }
}

public enum LoginRestrictionSections: Int, Hashable, CaseIterable {
    case info
    case logout
}

public enum LoginRestrictionInfoRows: Int, Hashable, CaseIterable {
    case headingImage
    case heading
    case description
    case subscribe
    case footer
    case faq
}


