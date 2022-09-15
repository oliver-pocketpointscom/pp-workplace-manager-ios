import UIKit
import SnapKit

public class InviteFromContactTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        textLabel?.text = "Invite from contacts"
        textLabel?.textColor = .white
        imageView?.image = UIImage(named: "addContact")?.withRenderingMode(.alwaysTemplate)
        imageView?.tintColor = .white
        
        backgroundColor = .clear
    }
}
