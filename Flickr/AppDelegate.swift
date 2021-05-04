import UIKit
import Application
import Infra
import Data

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var app: Application = { [weak self] in
        let client = URLSessionAdapter()
        let userSettings = UserDefaultsAdapter()
        let searchPhotos = RemoteSearchPhotos(httpClient: client)
        let getSizes = RemoteGetSizes(httpClient: client)
        let getPhotos = RemoteGetPhotos(searchPhotos: searchPhotos, getSizes: getSizes)
        let getSuggestion = LocalGetSuggestions(userSettings: userSettings)
        let setSuggestion = LocalSetSuggestions(userSettings: userSettings, getSuggestions: getSuggestion)
        let photoListFactory = PhotoListFactory(getPhotos: getPhotos, getSuggestions: getSuggestion, setSuggestions: setSuggestion)
        let main = Main(photoListScene: photoListFactory)
        return main
    }()
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        app.start()
        return true
    }
}

