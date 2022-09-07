import BroadcastPreferences
import Combine
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var isBroadcasting: Bool = false
    
    private var cancellables: [AnyCancellable] = []
    
    init() {
        cancellables += [
            BroadcastPreferences.shared.isBroadcasting.$value
                .receive(on: DispatchQueue.main)
                .sink { [weak self] isBroadcasting in
                    guard let self = self else { return }
                    self.isBroadcasting = isBroadcasting
                }
        ]
    }
}

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack(spacing: 6) {
            Text("Status")
                .bold()
            Text(viewModel.isBroadcasting ? "Broadcasting" : "Not Broadcasting")
                .bold()
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
