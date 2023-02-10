import Combine
import Foundation

public class RecipesListViewModel {
    @Published public var items: [RecipesListItemViewModel]?
    public let selectedIndexPaths: PassthroughSubject<IndexPath, Never> = .init()
    
    public init() {}
}
