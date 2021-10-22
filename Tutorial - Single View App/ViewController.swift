import UIKit
import ServiceCore
import ServiceChat

class ViewController : UIViewController, SCSChatSessionDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add our chat delegate
        ServiceCloud.shared().chatCore.add(delegate: self)
    }
    
    @IBAction func startChat(_ sender: AnyObject) {
        
        // Create config object
        if let config = SCSChatConfiguration(liveAgentPod:               "d.la4-c1-ia4.salesforceliveagent.com",
                                             orgId: "00D5e000002RP93",
                                             deploymentId: "5725e000000tvzS",
                                             buttonId: "5735e000000twr9") {
            
            // Start a session
            ServiceCloud.shared().chatUI.showChat(with:config)
        }
    }
    
    
    
    func session(_ session: SCSChatSession!, didEnd endEvent: SCSChatSessionEndEvent!) {
        
        var description = ""
        
        // Here we'll handle the situation where the agent ends the session
        // and when there are no agents available...
        switch endEvent.reason {
        case .agent:
            description = "The agent has ended the session."
        case .noAgentsAvailable:
            description = "It looks like there are no agents available. Try again later."
        // TO DO: Handle other reasons
        default:
            description = "Session ended for an unknown reason."
        }
        
        let alert = UIAlertController(title: "Session Ended",
                                      message: description,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func session(_ session: SCSChatSession!, didError error: Error!, fatal: Bool) {
        // TO DO: Handle error condition
        NSLog("Chat error: \(error.localizedDescription)")
    }
    
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
    

}
