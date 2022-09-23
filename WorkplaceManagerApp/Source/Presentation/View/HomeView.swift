import UIKit

public class HomeView: UIView {
    
    lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Keeping your staff Focused, Productive & Safe by Rewarding Healthy Mobile Behaviour in the Workplace"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var leftContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.borderWidth = 5
        container.layer.borderColor = UIColor.black.cgColor
        
        container.addSubview(leftHeadingLabel)
        container.addSubview(leftImageView)
        container.addSubview(leftSubheadingLabel)
        container.addSubview(leftValueLabel)
        
        leftHeadingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        leftImageView.snp.makeConstraints { make in
            make.top.equalTo(leftHeadingLabel.snp.bottom).offset(10)
            make.center.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        leftSubheadingLabel.snp.makeConstraints { make in
            make.top.equalTo(leftImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        leftValueLabel.snp.makeConstraints { make in
            make.top.equalTo(leftSubheadingLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        return container
    }()
    
    public lazy var leftHeadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Hours"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    public lazy var leftImageView: UIImageView = {
        UIImageView(image: UIImage(named: "clock"))
    }()
    
    public lazy var leftSubheadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Hours Saved"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    public lazy var leftValueLabel: UILabel = {
        let label = UILabel()
        label.text = "379 hrs"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var rightContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.borderWidth = 5
        container.layer.borderColor = UIColor.black.cgColor
        
        container.addSubview(rightHeadingLabel)
        container.addSubview(rightImageView)
        container.addSubview(rightSubheadingLabel)
        container.addSubview(rightValueLabel)
                
        rightHeadingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.equalTo(rightHeadingLabel.snp.bottom).offset(10)
            make.center.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        rightSubheadingLabel.snp.makeConstraints { make in
            make.top.equalTo(rightImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        rightValueLabel.snp.makeConstraints { make in
            make.top.equalTo(rightSubheadingLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        return container
    }()
    
    public lazy var rightHeadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rewards"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    public lazy var rightImageView: UIImageView = {
        UIImageView(image: UIImage(named: "employee_award"))
    }()
    
    public lazy var rightSubheadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Rewards Awarded"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    public lazy var rightValueLabel: UILabel = {
        let label = UILabel()
        label.text = "12 rewards"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var mainContainer: UIView = {
        let container = UIStackView()
        container.distribution = .fillEqually
        container.axis = .horizontal
        
        container.addArrangedSubview(leftContainer)
        container.addArrangedSubview(rightContainer)
        
        return container
    }()
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        addSubview(headingLabel)
        
        headingLabel.snp.makeConstraints { [weak self] make in
            guard let strongSelf = self else { return }
            make.top.equalTo(strongSelf.snp_topMargin).inset(50)
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        addSubview(mainContainer)
        mainContainer.snp.makeConstraints { [weak self] make in
            make.top.equalTo(headingLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(10)
            guard let strongSelf = self else { return }
            make.bottom.equalTo(strongSelf.snp_bottomMargin)
        }
        
        backgroundColor = .black
    }
}
