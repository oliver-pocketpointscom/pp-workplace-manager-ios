import UIKit
import SnapKit

public class PPReportViewController: PPBaseViewController {
    
    var employees = ["Nikky", "Sheena", "Marlise", "Michelle"]
    var ranks = ["1", "2", "3", "4"]
    var points = ["10,023", "8,950", "7,509", "5,819"]
    var departments = ["Manager", "Barista", "Asst. Manager", "Barista"]
    private var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavBarTitle()
        tableView.reloadData()
    }
    
    private func initView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
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
        cell.rankLabel.text = ranks[indexPath.row]
        cell.roundImageView.image = UIImage(named: "pp")
        let name = employees[indexPath.row]
        cell.nameLabel.text = name
        cell.descriptionLabel.text = departments[indexPath.row]
        cell.pointsLabel.text = points[indexPath.row]
        cell.timeLabel.text = "Minutes"
        
        if name == "Marlise" {
            cell.highlight()
        }
        
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Leader Board"
    }
}
