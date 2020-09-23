import Foundation

protocol ViewCode {
    func setup()
    func setupHierarchy()
    func buildConstraints()
    func additionalConfiguration()
}

extension ViewCode {
    func setup() {
        setupHierarchy()
        buildConstraints()
        additionalConfiguration()
    }
    func additionalConfiguration() { }
}
