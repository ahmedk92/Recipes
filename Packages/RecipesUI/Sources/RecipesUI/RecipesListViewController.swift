import UIKit
import RecipesViewModels
import Combine

public class RecipesListViewController: UITableViewController {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: RecipesListViewModel
    private var cancellables: [AnyCancellable] = []
    private var cellReuseId: String { #function }
    
    public init(viewModel: RecipesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        observeViewModel()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(RecipesListItemTableViewCell.self, forCellReuseIdentifier: cellReuseId)
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items?.count ?? .zero
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! RecipesListItemTableViewCell
        cell.viewModel = viewModel.items?[indexPath.row]
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedIndexPaths.send(indexPath)
    }
    
    private func observeViewModel() {
        viewModel.$items.sink { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }
}
