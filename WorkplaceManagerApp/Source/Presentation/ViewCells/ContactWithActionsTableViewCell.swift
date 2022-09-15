import UIKit

import SnapKit

public class ContactWithActionsTableViewCell: UITableViewCell {
    
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
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "trash"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var statusSwitch: UISwitch = {
        let switchButton = UISwitch()
        return switchButton
    }()
    
    private func setupView() {
        addSubview(roundImageView)
        addSubview(label)
        contentView.addSubview(statusSwitch)
        contentView.addSubview(deleteButton)
        
        roundImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.height.width.equalTo(35)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(roundImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(statusSwitch.snp.leading).offset(-8)
        }
        
        statusSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(24)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-16)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        backgroundColor = .clear
    }
}
