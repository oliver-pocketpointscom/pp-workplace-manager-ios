import UIKit
import SnapKit

public class PPReportViewController: PPBaseViewController {
    
    var employees: [UserObject] = []
    var ranks = ["1", "2", "3", "4", "5"]
    
    private var tableView: UITableView!
    
    private lazy var viewModel: ReportViewModel = {
       PPReportViewModel()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        loadUsers()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavBarTitle()
        tableView.reloadData()
    }
    
    private func initView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain)
        tableView.backgroundColor = .black
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    private func loadUsers() {
        viewModel.getLeaderBoard(tenantId: 104, completion: { [weak self] error in
            let realm = DataProvider.newInMemoryRealm()
            let results = realm.getAllUserObject()
            
            guard let strongSelf = self else { return }
            strongSelf.employees.removeAll()
            
            for r in results {
                strongSelf.employees.append(r)
            }
            strongSelf.tableView.reloadData()
        })
    }
}

extension PPReportViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LeaderBoardTableViewCell()
        var nameArray: [String] = []
        var surnameArray: [String] = []
        var minutesArray: [String] = []
        
        cell.rankLabel.text = ranks[indexPath.row]
        cell.roundImageView.image = UIImage(named: "pp")
        
        for name in employees {
            nameArray.append(name.firstname)
            surnameArray.append(name.surname)
            minutesArray.append("\(name.minutesOffPhone)")
        }
        
        let name = nameArray[indexPath.row]
        cell.nameLabel.text = name
        cell.descriptionLabel.text = surnameArray[indexPath.row]
        cell.pointsLabel.text = minutesArray[indexPath.row]
        cell.timeLabel.text = "Minutes"
        
//        if name == "Marlise" {
//            cell.highlight()
//        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Scoreboard"
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .clear
            headerView.backgroundView?.backgroundColor = .clear
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.textAlignment = .center
            headerView.textLabel?.font = .systemFont(ofSize: 24, weight: .bold)
            headerView.textLabel?.snp.makeConstraints({ make in
                make.leading.trailing.equalToSuperview()
            })
        }
    }
}
