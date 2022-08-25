import UIKit

public class PPReportViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavBarTitle()
    }
    
    private func initView() {
        view.backgroundColor = .white
    }
}
