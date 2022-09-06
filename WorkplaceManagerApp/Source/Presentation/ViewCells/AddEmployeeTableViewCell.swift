import UIKit
import SnapKit

public class AddEmployeeTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        textLabel?.textColor = .black
        textLabel?.text = "Invite using a number"
        imageView?.image = UIImage(named: "addContact")
        
        backgroundColor = .clear
    }
}
