import UIKit

public class PPBaseViewController: UIViewController {
    
    public func push(vc: UIViewController) {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
