import UIKit
import UI

protocol PhotoListDisplayLogic: class {
    func displaySearchPhotos(viewModel: PhotoList.SearchPhotos.ViewModel)
}

class PhotoListViewController: UIViewController {
    let interactor: PhotoListBusinessLogic
    
    var displayedPhotos = [DisplayedPhoto]()
    var viewLogic: PhotoListViewLogic
    
    // MARK: - Control
    var pagination: Int = 20
    var loading: Bool = true
    
    // MARK: - Life Cycle
    init(viewLogic: PhotoListViewLogic,
         interactor: PhotoListBusinessLogic) {
        self.viewLogic = viewLogic
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = viewLogic.view
    }
    
    override func viewDidLoad() {
        start()
    }
    
    private func start() {
        startLoading()
        fetchPhotos()
    }
}

// MARK: - PhotoListDisplayLogic
extension PhotoListViewController: PhotoListDisplayLogic {
    func displaySearchPhotos(viewModel: PhotoList.SearchPhotos.ViewModel) {
        viewLogic.set(viewModel: viewModel)
        stopLoading()
    }
}

// MARK: - PhotoListViewDelegate
extension PhotoListViewController: PhotoListViewDelegate {
    func set(imageView: UIImageView?, with url: String) {

    }

    func isLoading() -> Bool {
        return self.loading
    }

    func reachedEndOfPage() {
        fetchNewPhotoPage()
    }

    func didSelectRow() {
        
    }
}

// MARK: - Helpers
extension PhotoListViewController {
    
    private func fetchPhotos() {

    }
    
    private func fetchNewPhotoPage() {
        self.startLoading()
        self.incrementPagination()
        self.fetchPhotos()
        debugPrint("Ask new page: \(self.pagination)")
    }
    
    private func incrementPagination() {
        self.pagination += 20
    }
    
    private func startLoading() {
        self.loading = true
    }
    
    private func stopLoading() {
        self.loading = false
    }
}
