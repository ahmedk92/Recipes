import Combine
import RecipesViewModels
import UIKit

public class RecipesListInteractor {
    private let viewModel: RecipesListViewModel
    private var cancellables: [AnyCancellable] = []
    
    public init(viewModel: RecipesListViewModel) {
        self.viewModel = viewModel
        
        observeViewModel()
        setMockItems()
    }
    
    private func observeViewModel() {
        viewModel.selectedIndexPaths.sink { [weak self] indexPath in
            guard let self = self else { return }
            self.selectOrDeselectItemAtIndexPath(indexPath)
        }.store(in: &cancellables)
    }
    
    private func setMockItems() {
        viewModel.items = (0..<100).map {
            let item = RecipesListItemViewModel()
            item.name = "Recipe \($0)"
            item.isSelected = .random()
            return item
        }
    }
    
    private func selectOrDeselectItemAtIndexPath(_ indexPath: IndexPath) {
        viewModel.items?.indices.forEach { index in
            if index == indexPath.row {
                viewModel.items?[index].isSelected?.toggle()
            }
        }
    }
}
