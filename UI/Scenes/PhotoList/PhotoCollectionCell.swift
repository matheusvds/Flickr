import Foundation
import UIKit
import SnapKit


class PhotoCollectionCell: UICollectionViewCell, Identifiable {
    
    var cancelLoad: ((UIImageView) -> Void)?

    var imageView: UIImageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelLoad?(imageView)
    }
}

// MARK: - UI Implementation
extension PhotoCollectionCell: ViewCode {
    func setupHierarchy() {
        addSubview(imageView)
    }
    
    func buildConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.right.top.left.bottom.equalToSuperview()
        }
    }
    
    func additionalConfiguration() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        backgroundColor = .systemFill
        imageView.contentMode = .scaleAspectFill
    }
}
