import Combine

public class RecipesListItemViewModel {
    @Published public var name: String?
    @Published public var isSelected: Bool?
    
    public init() {}
}
