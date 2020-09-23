import UIKit
import Application
import Infra

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var app: Application = { [weak self] in
        let client = URLSessionAdapter()
        let main = Main(client: client)
        main.window = self?.window
        return main
    }()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        app.start()
        return true
    }
    
    func configureApp() {
        let vc = ViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        self.window = window
        
        window.makeKeyAndVisible()
    }
}

