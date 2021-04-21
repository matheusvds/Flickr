import Foundation
import UIKit


class PhotoCollectionCell: UICollectionViewCell, Identifiable {
    
    var imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
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
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func additionalConfiguration() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        backgroundColor = .systemFill
    }
}
