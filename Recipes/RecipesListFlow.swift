import RecipesViewModels
import RecipesUI
import RecipesPresentation
import UIKit

class RecipesListFlow {
    private var recipesListInteractor: RecipesListInteractor?
    
    func start(in window: UIWindow) {
        window.rootViewController = makeRecipesListViewController()
    }
    
    private func makeRecipesListViewController() -> UIViewController {
        let recipesListViewModel = RecipesListViewModel()
        recipesListInteractor = .init(viewModel: recipesListViewModel)
        return RecipesListViewController(viewModel: recipesListViewModel)
    }
}
