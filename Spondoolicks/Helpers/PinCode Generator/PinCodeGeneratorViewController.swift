//
//  Provides a UI for obtaining a 4-digit PIN number.  Designed to be embedded
//  inside another View Controller.
//
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class PinCodeGeneratorViewController: UIViewController {

    // MARK: - Properties
    var delegate: PinCodeDelegate?
    var wheelSettings: [Int] = [0, 0, 0, 0]
    
    // MARK: - IBOutlets
    @IBOutlet weak var pinPicker: UIPickerView!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
     }

    // MARK: - View handling
    func setupView() {
        pinPicker.delegate = self
        pinPicker.dataSource = self
        pinPicker.showsSelectionIndicator = true
    }
    
    // MARK: - IBActions
    
    // MARK: - Functions
}

extension PinCodeGeneratorViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        wheelSettings[component] = row
        delegate?.newPinSelected(wheelSettingsAsString())
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
       
        var pickerLabel = view as? UILabel
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = FontHelper.getFontFor(.subheadline, traitCollection: traitCollection)
            pickerLabel?.textColor = UIColor(named: Global.Identifier.Colour.GREY)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = "\(row)"
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        // Use a dummy label to calculate the height.  It isn't fixed because of
        // Dynamic Type and there is no 'automatic dynamic  sizing' as there
        // is for table view cells.  Assume that each component in the Picker View is equal width.
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width / 4, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 1
        label.font = FontHelper.getFontFor(.subheadline, traitCollection: traitCollection)
        
        label.text = "8"  // Just a dummy value
        label.sizeToFit()
        
        // Set some extra points to provide some space
        return label.frame.height + 8
    }
    
    // MARK: - Delegate helper
    func wheelSettingsAsString() -> String {
        return wheelSettings.reduce("") {pin, wheel in pin + "\(wheel)"}
    }
}

extension PinCodeGeneratorViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}
