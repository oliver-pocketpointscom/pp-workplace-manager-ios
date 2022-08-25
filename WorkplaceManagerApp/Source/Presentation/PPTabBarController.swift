import UIKit

public class PPTabBarController: UITabBarController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewControllers()
    }
    
    private func initView() {
        view.backgroundColor = .backgroundColor()
        UITabBar.appearance().barTintColor = .backgroundColor()
        tabBar.tintColor = .label
    }
    
    private func initViewControllers() {
        viewControllers = [
            createNavController(for: PPContactsViewController(style: .grouped),
                                   title: "Contacts", image: UIImage(named: "contact")),
            createNavController(for: PPRewardsViewController(),
                                   title: "Rewards", image: UIImage(named: "reward")),
            createNavController(for: PPReportViewController(),
                                   title: "Report", image: UIImage(named: "report")),
            createNavController(for: PPSettingsViewController(style:. grouped),
                                   title: "Settings", image: UIImage(named: "settings"))
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                         title: String?,
                                         image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        navController.tabBarItem.title = title
        return navController
    }
}
