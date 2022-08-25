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
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 17
        return imageView
    }()
    
    lazy var label: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private func setupView() {
        addSubview(roundImageView)
        addSubview(label)
        
        roundImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.height.width.equalTo(35)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(roundImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
        }
        
        backgroundColor = .clear
    }
}
