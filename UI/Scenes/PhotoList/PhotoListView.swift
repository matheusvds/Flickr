import Foundation
import UIKit

public protocol PhotoListViewLogic {
    var view: UIView { get }
    func set(viewModel: PhotoListViewModel)
    func getSelectedRow() -> Int?
}


public protocol PhotoListViewDelegate: class {
    func reachedEndOfPage()
    func didSelectRow()
    func set(imageView: UIImageView?, with url: String)
    func isLoading() -> Bool
}

public final class PhotoListView: UIView {
    
    public weak var delegate: PhotoListViewDelegate?
    
    private lazy var screenLoading: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.startAnimating()
        return view
    }()
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        guard let `self` = self else { return UICollectionView() }
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.reuseIdentifier)
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
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
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        startScreenLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func startScreenLoading() {
        self.subviews.forEach { $0.removeFromSuperview() }
        addSubview(screenLoading)
        drawLoading()
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
        items.append(contentsOf: viewModel.items)
        reloadData()
        stopLoading()
    }
    
    public func getSelectedRow() -> Int? {
        return collectionView.indexPathsForSelectedItems?.first?.row
    }
    
    public var view: UIView {
        return self
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
        delegate?.set(imageView: cell.imageView, with: item.image)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PhotoListView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height / 6
        let collectionPadding = CGFloat(20)
        let collectionWidth = collectionView.bounds.width - collectionPadding
        let cellWidth = collectionWidth / 2
        
        return CGSize(width: cellWidth, height: cellHeight);
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectRow()
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
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(10)
            make.left.right.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func drawLoading() {
        screenLoading.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
    }
}
