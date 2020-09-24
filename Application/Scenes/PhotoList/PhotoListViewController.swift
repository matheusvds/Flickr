import UIKit
import UI

protocol PhotoListDisplayLogic: class {
    func displaySearchPhotos(viewModel: PhotoList.SearchPhotos.ViewModel)
}

class PhotoListViewController: UIViewController {
    let interactor: PhotoListBusinessLogic
    
    var displayedPhotos = [DisplayedPhoto]()
    var viewLogic: PhotoListViewLogic
    let imageLoader: UIImageLoader
    
    // MARK: - Control
    var pagination: Int = 1
    var loading: Bool = true
    
    // MARK: - Life Cycle
    init(viewLogic: PhotoListViewLogic,
         interactor: PhotoListBusinessLogic,
         imageLoader: UIImageLoader) {
        self.viewLogic = viewLogic
        self.interactor = interactor
        self.imageLoader = imageLoader
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
    func cancelLoading(for imageView: UIImageView) {
        imageLoader.cancel(for: imageView)
    }
    
    func set(imageView: UIImageView?, with url: String, at row: Int) {
        if let imageView = imageView {
            imageLoader.load(url, for: imageView, at: row)
        }
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
        interactor.fetchPhotos(request: PhotoList.SearchPhotos.Request(query: "kitten", page: pagination))
    }
    
    private func fetchNewPhotoPage() {
        self.startLoading()
        self.incrementPagination()
        self.fetchPhotos()
        debugPrint("Ask new page: \(self.pagination)")
    }
    
    private func incrementPagination() {
        self.pagination += 1
    }
    
    private func startLoading() {
        self.loading = true
    }
    
    private func stopLoading() {
        self.loading = false
    }
}
