import UIKit
import SnapKit

public class ButtonTableViewCell: UITableViewCell {
    
    public lazy var button: UIButton  = {
        .roundedButton(withTitle: "Logout", backgroundColor: .red)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {    
        contentView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
        }
    }
}
