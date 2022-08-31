import UIKit
import SnapKit

public class LeaderBoardTableViewCell: UITableViewCell {
    
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
    
    lazy var rankLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = rankLabelDefaultFont()
        label.textColor = .black
        return label
    }()
    
    lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = nameLabelDefaultFont()
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = descriptionLabelDefaultFont()
        label.textColor = .darkGray
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = pointsLabelDefaultFont()
        label.textColor = .black
        return label
    }()
    
    lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = timeLabelDefaultFont()
        label.textColor = .darkGray
        return label
    }()
    
    private func setupView() {
        let containerView = containerView()
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        backgroundColor = .clear
    }
    
    public func containerView() -> UIView {
        let containerView = UIView()
        containerView.addSubview(rankLabel)
        containerView.addSubview(roundImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(pointsLabel)
        containerView.addSubview(timeLabel)
        
        rankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(16)
        }
        
        roundImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(rankLabel.snp.trailing).offset(16)
            make.height.width.equalTo(35)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(roundImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalTo(pointsLabel).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.leading.equalTo(roundImageView.snp.trailing).offset(16)
            make.trailing.equalTo(timeLabel).offset(8)
            make.height.equalTo(16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(80)
            make.height.equalTo(24)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(pointsLabel.snp.bottom).offset(2)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(56)
            make.height.equalTo(16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        return containerView
    }
    
    public func highlight() {
        rankLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.font = .boldSystemFont(ofSize: 22)
        descriptionLabel.font = .systemFont(ofSize: 14)
        pointsLabel.font = .boldSystemFont(ofSize: 22)
        timeLabel.font = .systemFont(ofSize: 12)
        backgroundColor = .pocketpointsGreen2()
    }
    
    private func rankLabelDefaultFont() -> UIFont {
        .systemFont(ofSize: 14, weight: .bold)
    }
    
    private func nameLabelDefaultFont() -> UIFont {
        .systemFont(ofSize: 18, weight: .regular)
    }
    
    private func descriptionLabelDefaultFont() -> UIFont {
        .systemFont(ofSize: 12, weight: .regular)
    }
    
    private func pointsLabelDefaultFont() -> UIFont {
        .systemFont(ofSize: 18, weight: .regular)
    }
    
    private func timeLabelDefaultFont() -> UIFont {
        .systemFont(ofSize: 10, weight: .regular)
    }
}
