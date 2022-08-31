import UIKit
import SnapKit

public class HeadingImageTableViewCell: UITableViewCell {
    
    public lazy var customImageView: UIImageView  = {
        UIImageView()
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
        contentView.addSubview(customImageView)
        
        customImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
}
