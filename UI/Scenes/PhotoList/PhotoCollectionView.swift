import Foundation
import UIKit

class PhotoCollectionView: UICollectionView {
    
    fileprivate lazy var emptyView: UILabel = {
        let emptyView = UILabel()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.font = UIFont.boldSystemFont(ofSize: 30)
        emptyView.isHidden = true
        return emptyView
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        super.reloadData()
        addEmptyState()
    }
    
    private func setup() {
        setupCells()
        setupAppereance()
        buildEmptyView()
        keyboardDismissMode = .onDrag
    }
    
    func setupCells() {
        register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.reuseIdentifier)
        register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
    }
    
    private func setupAppereance() {
        backgroundColor = .systemGray6
        showsVerticalScrollIndicator = false
    }
    
    private func addEmptyState() {
        if numberOfItems(inSection: 0) == 0 {
           let message = "Nothing here"
           let emoticon = ["🙈", "🙉", "🙊"].shuffled()[0]
           emptyView.text = "\(message) \(emoticon)"
           emptyView.isHidden = false
            return
        }
        emptyView.isHidden = true
    }
    
    private func buildEmptyView() {        
        addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
