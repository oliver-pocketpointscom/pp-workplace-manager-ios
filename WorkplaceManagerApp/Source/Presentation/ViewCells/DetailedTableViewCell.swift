import UIKit
import SnapKit

public class DetailedTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    lazy var legendLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var valueLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private func setupView() {
        addSubview(legendLabel)
        addSubview(valueLabel)
        
        legendLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(legendLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        backgroundColor = .white
    }
}
