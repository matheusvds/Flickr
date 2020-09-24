import Foundation
import UI
import UIKit

class PhotoListViewLogicSpy: PhotoListViewLogic {
    var view: UIView = UIView()
    var setViewModelCalled = false
    var viewModel: PhotoListViewModel?
    
    func set(viewModel: PhotoListViewModel) {
        setViewModelCalled = true
        self.viewModel = viewModel
    }
    
    func clearItems() { }
    
    func getSelectedRow() -> Int? {
        return nil
    }
}
