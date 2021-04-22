import UIKit
import UI

protocol PhotoListDisplayLogic: class {
    func displayFetchedPhotos(viewModel: PhotoList.GetPhotos.ViewModel)
    func displayFetchedSuggetions(viewModel: PhotoList.GetSuggestions.ViewModel)
}

class PhotoListViewController: UIViewController {
    let interactor: PhotoListBusinessLogic
    
    var displayedPhotos = [DisplayedPhoto]()
    var viewLogic: PhotoListViewLogic
    let imageLoader: UIImageLoader
    
    // MARK: - Control
    var pagination: Int = 1
    var loading: Bool = true
    var query: String = "kitten"
    
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
        setupTitle()
        setupController()
    }
    
    private func start() {
        startLoading()
        fetchSuggestions()
        fetchPhotos(with: query)
    }
    
    private func setupController() {
        setupTitle()
        definesPresentationContext = true
    }
}

// MARK: - PhotoListDisplayLogic
extension PhotoListViewController: PhotoListDisplayLogic {
    func displayFetchedPhotos(viewModel: PhotoList.GetPhotos.ViewModel) {
        viewLogic.set(viewModel: viewModel)
        stopLoading()
    }
    
    func displayFetchedSuggetions(viewModel: PhotoList.GetSuggestions.ViewModel) {
        viewLogic.set(suggestions: viewModel.suggestions)
    }
}

// MARK: - PhotoListViewDelegate
extension PhotoListViewController: PhotoListViewDelegate {
    func getSuggestions() {
        fetchSuggestions()
    }
    
    func didSearch(with query: String) {
        guard query.count > 0 else { return }
        self.query = query
        self.pagination = 1
        self.viewLogic.clearItems()
        self.fetchPhotos(with: query)
    }
    
    func setupInNavigation(controller: UISearchController) {
        navigationItem.searchController = controller
    }
    
    func set(imageView: UIImageView?, with url: String, at row: Int) {
        if let imageView = imageView {
            imageLoader.load(url, for: imageView)
        }
    }

    func isLoading() -> Bool {
        return self.loading
    }

    func reachedEndOfPage() {
        fetchNewPhotoPage(with: query)
    }
}

// MARK: - Helpers
extension PhotoListViewController {
    
    private func fetchSuggestions() {
        interactor.fetchSuggestions(request: PhotoList.GetSuggestions.Request())
    }
    
    private func fetchPhotos(with query: String) {
        interactor.fetchPhotos(request: PhotoList.GetPhotos.Request(query: query, page: pagination))
    }
    
    private func fetchNewPhotoPage(with query: String) {
        self.startLoading()
        self.incrementPagination()
        self.fetchPhotos(with: query)
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
    
    private func setupTitle() {
        title = "Flickr"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
