import UIKit
import ServiceCore
import ServiceChat

class MyChatSessionDelegateImplementation: NSObject, SCSChatSessionDelegate {
  
  // TO DO: Register this delegate using
    //ServiceCloud.shared().chatCore.add(delegate: myDelegate)

  /**
   Delegate method to handle state change.
   */
  func session(_ session: SCSChatSession!,
               didTransitionFrom previous: SCSChatSessionState,
               to current: SCSChatSessionState) {
  
    NSLog("Chat state changed...")
    
    switch current {
      case .connecting:
        NSLog("Chat now connecting...")
      case .connected:
        NSLog("Chat connected...")
      // TO DO: Handle other reasons
      default:
        break
      }
  }
  
  /**
   Delegate method for session stop event.
   */
  func session(_ session: SCSChatSession!, didEnd endEvent: SCSChatSessionEndEvent!) {

    var reason = "Unknown"
    
    switch endEvent.reason {
      case .agent:
        reason = "The agent has ended the session."
      case .noAgentsAvailable:
        reason = "No agents were available."
      default:
        // TO DO: Handle other reasons
        break
    }
    
    NSLog("\nChat End Session. Reason: \(reason)")

    // You can access the session ID from the SCSChatSession object
    let sessionId = session.sessionId
  }
  
  /**
   Delegate method for error conditions.
   */
  func session(_ session: SCSChatSession!, didError error: Error!, fatal: Bool) {
    // TO DO: Handle error condition
    NSLog("Chat error: \(error.localizedDescription)")
  }
}
