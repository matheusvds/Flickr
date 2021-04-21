import Foundation
import UIKit

public protocol PhotoListViewLogic {
    var view: UIView { get }
    func set(viewModel: PhotoListViewModel)
    func clearItems()
}

public typealias PhotoListViewDelegate = PhotoListTableDelegate & ImageLoadingDelegate & SearchDelegate

public protocol SearchDelegate: class {
    func setupInNavigation(controller: UISearchController)
    func didSearch(with query: String)
}

public protocol PhotoListTableDelegate: class {
    func reachedEndOfPage()
    func isLoading() -> Bool
}

public protocol ImageLoadingDelegate: class {
    func set(imageView: UIImageView?, with url: String, at row: Int)
}

public final class PhotoListView: UIView {
    
    public weak var delegate: PhotoListViewDelegate? {
        didSet {
            delegate?.setupInNavigation(controller: searchController)
        }
    }
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.autocapitalizationType = .none
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "we searched for kittens, wanna try?"
        return controller
    }()
    
    private lazy var screenLoading: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    
    private lazy var collectionView: PhotoCollectionView = { [weak self] in
        guard let `self` = self else { return PhotoCollectionView() }
        let collection = PhotoCollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collection.delegate = self
        collection.dataSource = self
        self.flowLayout.footerReferenceSize = CGSize(width: collection.bounds.width, height: 50)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        return flowLayout
    }()
    
    private var items = [PhotoListItem]()
    private var searchItems = [PhotoListItem]()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        startScreenLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reloadData() {
        collectionView.reloadData()
    }
    
    private func startScreenLoading() {
        self.subviews.forEach { $0.removeFromSuperview() }
        addSubview(screenLoading)
        drawLoading(view: screenLoading, at: self)
    }
    
    private func stopLoading() {
        self.subviews.forEach { $0.removeFromSuperview() }
        setupHierarchy()
        buildConstraints()
    }
}

// MARK: - PhotoListViewLogic
extension PhotoListView: PhotoListViewLogic {
    public func set(viewModel: PhotoListViewModel) {
        if let photosItems = viewModel.items {
            items.append(contentsOf: photosItems)
        }
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
            self?.stopLoading()
        }
    }
    
    public func clearItems() {
        items.removeAll()
        collectionView.reloadData()
        startScreenLoading()
        if items.isEmpty { return }
        collectionView.scrollToItem(at: (IndexPath(row: 0, section: 0)), at: .top, animated: false)
    }
    
    public var view: UIView {
        return self
    }
}

extension PhotoListView: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        delegate?.didSearch(with: text)
    }
}

// MARK: - UICollectionViewDataSource
extension PhotoListView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.reuseIdentifier,
                                                      for: indexPath) as! PhotoCollectionCell
        let item = items[indexPath.row]
        delegate?.set(imageView: cell.imageView, with: item.image, at: indexPath.row)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PhotoListView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height / 2.5
        let collectionPadding = CGFloat(20)
        let collectionWidth = collectionView.bounds.width - collectionPadding
        let cellWidth = collectionWidth / 2
        
        return CGSize(width: cellWidth, height: cellHeight);
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            if let isLoading = delegate?.isLoading(), isLoading {
                footer.addSubview(screenLoading)
                drawLoading(view: screenLoading, at: footer)
            } else {
                footer.subviews.forEach { $0.removeFromSuperview() }
            }
            return footer
        }
        return UICollectionReusableView()
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detectedEnding(of: scrollView)
    }
    
    private func detectedEnding(of scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.frame.size.height*0.6
        let difference = scrollView.contentSize.height - scrollView.frame.size.height
        
        if let isLoading =  delegate?.isLoading(), offset >= difference && !isLoading {
            delegate?.reachedEndOfPage()
        }
    }
}

// MARK: - UI Implementation
extension PhotoListView: ViewCode {
    func setupHierarchy() {
        addSubview(collectionView)
    }
    
    func buildConstraints() {
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: padding)
        ])
    }
    
    private func drawLoading(view: UIView, at superview: UIView) {
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .systemGray6
    }
}
