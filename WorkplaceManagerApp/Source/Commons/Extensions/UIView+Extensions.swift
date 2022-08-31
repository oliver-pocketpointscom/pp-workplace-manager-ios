import UIKit

extension UIView {
    func addBottomBorder(color: UIColor = .primary()){
        let underlineView = UIView()
        underlineView.backgroundColor = color
        
        addSubview(underlineView)
        
        underlineView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).offset(1)
            make.trailing.equalTo(self.snp.trailing)
            make.leading.equalTo(self.snp.leading)
            make.height.equalTo(1)
        }
    }
}
