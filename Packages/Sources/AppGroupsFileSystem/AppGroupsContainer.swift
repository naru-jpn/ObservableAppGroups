import Foundation

public class AppGroupsContainer {
    public static let shared = AppGroupsContainer()
    
    private let groupId = "group.observable-appgroups"
    
    var containerUrl: URL {
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupId) else {
            fatalError("Failed to get app groups container")
        }
        return url
    }
}
