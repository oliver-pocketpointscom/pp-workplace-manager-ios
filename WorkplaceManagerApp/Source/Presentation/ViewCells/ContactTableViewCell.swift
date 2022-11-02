import UIKit
import SnapKit

public class ContactTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    lazy var roundImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 17
        return imageView
    }()
    
    lazy var label: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var checkBox: UIImageView = {
        let box = UIImageView(image: UIImage(named: "checkboxEmpty")?.withRenderingMode(.alwaysTemplate))
        box.tintColor = .white
        box.isHidden = true
        return box
    }()
    
    private var contact: PPContact?
    public func setContact(_ contact: PPContact) {
        self.contact = contact
        
        label.text = contact.fullName()
    }
    
    public func getContact() -> PPContact? {
        self.contact
    }
    
    private func setupView() {
        addSubview(roundImageView)
        addSubview(label)
        addSubview(checkBox)
        
        roundImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.height.width.equalTo(35)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(roundImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(checkBox.snp.leading).offset(8)
        }
        
        checkBox.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        backgroundColor = .clear
    }
}
