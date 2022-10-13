import UIKit

public class ChoosePlanView: UIView {
    
    public let radioButton = RadioButton()
    
    lazy var primaryButton: UIButton = {
        .roundedButton(withTitle: "Subscribe now")
    }()
    
    lazy var secondaryButton: UIButton = {
        .roundedButton(withTitle: "Continue with Free Trial")
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "3 of 4"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .natural
        
        return label
    }()
    
    lazy var subscriptionLegend: UILabel = {
        let label = UILabel()
        label.text = "Subscription"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .natural
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
//        label.text = "By tapping proceed, you will be redirected into an external browser to select your subscription plan and process the payment."
        label.text = "Enjoy full access starting at $10/mo. Tap the 'Subscribe now' button to get started! You can also continue with our Free Trial for 7-days."
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .justified
        
        return label
    }()
    
    lazy var companyPhotoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "subscription"))
        imageView.tintColor = .primary()
        return imageView
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
        addSubview(subscriptionLegend)
        addSubview(companyPhotoView)
        addSubview(descriptionLabel)
        addSubview(primaryButton)
        addSubview(secondaryButton)
        addSubview(progressLabel)
        
        subscriptionLegend.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        companyPhotoView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(200)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(companyPhotoView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        primaryButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
            make.bottom.equalTo(secondaryButton.snp.top).offset(-16)
        }
        
        secondaryButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
            make.bottom.equalTo(progressLabel.snp.top).offset(-16)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-48)
        }
    }
}
