import Combine
import FileObserver
import Foundation

public class AppGroupsFile<T: Codable> {
    private let name: String
    private let url: URL

    private var observer: FileObserver?

    @Published public var value: T
    
    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()
    
    public init(
        name: String,
        initialValue: T
    ) throws {
        self.name = name
        self.url = AppGroupsContainer.shared.containerUrl.appendingPathComponent(name)
        self.value = initialValue
        if !FileManager.default.fileExists(atPath: url.path) {
            try write(initialValue)
        }
        self.observer = try FileObserver(url: url) { [weak self] observer, url in
            self?.handleFileEvent(observer: observer, url: url)
        }
        updateValue()
    }
    
    public func write(_ value: T) throws {
        let data = try encoder.encode(value)
        try data.write(to: url)
    }
    
    public func read() throws -> T {
        let data = try Data(contentsOf: url)
        let value = try decoder.decode(T.self, from: data)
        return value
    }
    
    private func handleFileEvent(observer: FileObserver, url: URL) {
        updateValue()
    }
    
    private func updateValue() {
        do {
            let value = try read()
            self.value = value
        } catch {
            print("Failed to read value from app container file.")
        }
    }
}
