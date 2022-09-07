import AppGroupsFileSystem
import Foundation

public class BroadcastPreferences {
    public static let shared = BroadcastPreferences()
    
    public let isBroadcasting: AppGroupsFile<Bool>
    
    init() {
        do {
            isBroadcasting = try AppGroupsFile<Bool>(name: "is_broadcasting", initialValue: false)
        } catch {
            fatalError("Failed to initialize BroadcastPreferences with error: \(error)")
        }
    }
}
