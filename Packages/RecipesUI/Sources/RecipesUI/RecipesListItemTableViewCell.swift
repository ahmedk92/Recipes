import UIKit
import RecipesViewModels
import Combine

class RecipesListItemTableViewCell: UITableViewCell {
    var viewModel: RecipesListItemViewModel? {
        didSet {
            cancellables = []
            observeViewModel()
        }
    }
    
    private var cancellables: [AnyCancellable] = []
    
    private func observeViewModel() {
        viewModel?.$name.sink { [weak self] name in
            guard let self = self else { return }
            self.textLabel?.text = name
        }.store(in: &cancellables)
        
        viewModel?.$isSelected.sink { [weak self] isSelected in
            guard let self = self else { return }
            self.accessoryType = isSelected == true ? .checkmark : .none
        }.store(in: &cancellables)
    }
}
