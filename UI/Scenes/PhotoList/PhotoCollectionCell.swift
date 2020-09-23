import Foundation
import UIKit
import SnapKit

class PhotoCollectionCell: UICollectionViewCell, Identifiable {

    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Implementation
extension PhotoCollectionCell: ViewCode {
    func setupHierarchy() {
        addSubview(imageView)
    }
    
    func buildConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    func additionalConfiguration() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
}
