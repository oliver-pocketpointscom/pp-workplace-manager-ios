import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent
        
        Wire.default.delegate = self
        
        return true
    }
}

extension AppDelegate: WireDelegate {
    
    var devBaseUrl: URL {
        URL(string: "https://api-wp-dev.pocketpoints.com/api/")!
    }
    
    var qaBaseUrl: URL {
        URL(string: "https://api-wp-dev.pocketpoints.com/api/")!
    }
    
    var prodBaseUrl: URL {
        URL(string: "https://api-wp-dev.pocketpoints.com/api/")!
    }
}
