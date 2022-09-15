import UIKit
import MapKit

public class GeofenceView: UIView {
    lazy var map: MKMapView = {
        return MKMapView()
    }()
    
    lazy var primaryButton: UIButton = {
        .roundedButton(withTitle: "Proceed")
    }()
    
    lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        return textField
    }()
    
    lazy var pinImageView: UIImageView =  {
       let imageView = UIImageView(image: UIImage(named: "pin"))
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var addressContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        let legend = UILabel()
        legend.text = "Company Address"
        legend.font = .systemFont(ofSize: 14)
        legend.textColor = .white
        legend.backgroundColor = .clear
        legend.textAlignment = .natural

        view.addSubview(legend)
        view.addSubview(addressTextField)
        
        legend.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(legend.snp.bottom).offset(-8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(33)
        }
        
        return view
    }()
    
    lazy var detailsView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        view.addSubview(addressContainerView)
        
        addressContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
        return view
    }()
    
    lazy var centerButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.backgroundColor = .white
        button.setImage(UIImage(named: "curLoc"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    lazy var addPinButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.backgroundColor = .white
        button.setImage(UIImage(named: "addPin"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
//    lazy var clearPinsButton: UIButton = {
//        let button = UIButton(type: .infoLight)
//        button.backgroundColor = .white
//        button.setImage(UIImage(named: "removePin"), for: .normal)
//        button.layer.masksToBounds = true
//        button.layer.cornerRadius = 12
//        button.clipsToBounds = true
//        return button
//    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "2 of 4"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .natural
        
        return label
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
        addSubview(map)
        addSubview(detailsView)
        addSubview(centerButton)
        addSubview(addPinButton)
//        addSubview(clearPinsButton)
        addSubview(primaryButton)
        addSubview(progressLabel)
        
        detailsView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(100)
        }
        
        map.snp.makeConstraints { make in
            make.top.equalTo(detailsView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(primaryButton.snp.top).offset(-8)
        }
        
        centerButton.snp.makeConstraints { make in
            make.bottom.equalTo(map.snp.bottom).offset(-16)
            make.trailing.equalTo(map.snp.trailing).offset(-16)
            make.height.width.equalTo(35)
        }

        addPinButton.snp.makeConstraints { make in
            make.bottom.equalTo(centerButton.snp.top).offset(-16)
            make.trailing.equalTo(map.snp.trailing).offset(-16)
            make.height.width.equalTo(35)
        }

//        clearPinsButton.snp.makeConstraints { make in
//            make.bottom.equalTo(primaryButton.snp.top).offset(-16)
//            make.leading.equalToSuperview().offset(16)
//            make.height.width.equalTo(35)
//        }
        
        primaryButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(200)
            make.bottom.equalTo(progressLabel.snp.top).offset(-16)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-48)
        }
        
        backgroundColor = .black
    }
}
