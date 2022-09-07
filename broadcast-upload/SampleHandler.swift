//
//  SampleHandler.swift
//  broadcast-upload
//
//  Created by Naruki Chigira on 2022/09/07.
//

import BroadcastPreferences
import ReplayKit

class SampleHandler: RPBroadcastSampleHandler {

    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        try! BroadcastPreferences.shared.isBroadcasting.write(true)
    }
    
    override func broadcastPaused() {
        // User has requested to pause the broadcast. Samples will stop being delivered.
    }
    
    override func broadcastResumed() {
        // User has requested to resume the broadcast. Samples delivery will resume.
    }
    
    override func broadcastFinished() {
        try? BroadcastPreferences.shared.isBroadcasting.write(false)
    }
    
    override func finishBroadcastWithError(_ error: Error) {
        try? BroadcastPreferences.shared.isBroadcasting.write(false)
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
        case RPSampleBufferType.video:
            // Handle video sample buffer
            break
        case RPSampleBufferType.audioApp:
            // Handle audio sample buffer for app audio
            break
        case RPSampleBufferType.audioMic:
            // Handle audio sample buffer for mic audio
            break
        @unknown default:
            // Handle other sample buffer types
            fatalError("Unknown type of sample buffer")
        }
    }
}
