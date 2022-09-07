import Foundation

public enum FileObserverError: Error {
    case failedToOpenFile
}

public class FileObserver {
    public typealias EventHandler = (FileObserver, URL) -> ()
    
    private let url: URL
    private var fileSystemObjectSource: DispatchSourceFileSystemObject?
    private let eventHandler: EventHandler
    
    public init(url: URL, eventHandler: @escaping EventHandler) throws {
        self.url = url
        self.eventHandler = eventHandler
        try observe()
    }
    
    deinit {
        if let fileSystemObjectSource = fileSystemObjectSource {
            fileSystemObjectSource.setEventHandler { }
            fileSystemObjectSource.cancel()
            close(fileSystemObjectSource.handle)
        }
    }
    
    private func observe() throws {
        let fileDescriptor = open(url.path, O_EVTONLY)
        guard fileDescriptor >= 0 else {
            throw FileObserverError.failedToOpenFile
        }
        let fileSystemObjectSource = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: fileDescriptor,
            eventMask: .write
        )
        fileSystemObjectSource.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.eventHandler(self, self.url)
        }
        fileSystemObjectSource.resume()
        self.fileSystemObjectSource = fileSystemObjectSource
    }
}
