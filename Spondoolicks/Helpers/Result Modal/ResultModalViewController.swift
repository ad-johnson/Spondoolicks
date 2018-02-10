//
//  Display a Success indicator for a brief period of time
//
//  Created by Andrew Johnson on 10/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class ResultModalViewController: UIViewController {

    // MARK: - Properties
    typealias Completion = () -> ()
    var success = true
    var duration: Double = 2.0
    var timer: Timer?
    var completion: Completion?
    
    // MARK: - IBOutlets
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var indicator: UIImageView!
    @IBOutlet weak var panelView: SPLozengeBorderedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if success {
            result.text = "Success"
            indicator.image = #imageLiteral(resourceName: "Success")
        } else {
            result.text = "Failed"
            indicator.image = #imageLiteral(resourceName: "Failure")
       }
        result.font = FontHelper.getFontFor(.title1, traitCollection: traitCollection)
    }

    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(
            timeInterval: TimeInterval(duration),
            target: self,
            selector: #selector(self.removeSelf),
            userInfo: nil,
            repeats: false)
    }
    
    @objc private func removeSelf() {
        // Animate removal of view
        UIView.animate(
            withDuration: 0.15,
            animations: {
                self.panelView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.panelView.alpha = 0.0
        }) { _ in
            self.dismiss(animated: true, completion: self.completion)
        }
    }
}
