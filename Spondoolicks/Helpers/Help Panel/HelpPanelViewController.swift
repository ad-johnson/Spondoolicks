//
//  Displays a modal panel with help information.  Subtitles are used to break
//  up the information.  Subtitle and help entry ordering is important so
//  arrays are used to maintain that order.
//
//  Created by Andrew Johnson on 31/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class HelpPanelViewController: UIViewController {

    // Properties
    weak var dataSource: HelpPanelDataSource?
    
    // MARK: - IBOutlets
    @IBOutlet weak var helpHeading: UILabel!
    @IBOutlet weak var helpEntries: UITableView!
    @IBOutlet weak var panelView: LozengeView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - View handling
    func setupView() {
        helpEntries.delegate = self
        helpEntries.dataSource = self
        
        helpEntries.register(UINib(nibName: Global.Identifier.Cell.HELP_ENTRY_CELL, bundle: nil), forCellReuseIdentifier: Global.Identifier.Cell.HELP_ENTRY_CELL)
        helpEntries.register(UINib(nibName: Global.Identifier.Cell.HELP_PANEL_HEADER_CELL, bundle: nil), forCellReuseIdentifier: Global.Identifier.Cell.HELP_PANEL_HEADER_CELL)

        if let title = dataSource?.helpPanelTitle() {
            helpHeading.text = title
        } else {
            helpHeading.text = "Missing Title"
        }
        helpHeading.font = FontHelper.getFontFor(.title2, traitCollection: self.traitCollection)
        // Inherit the features of LozengeView but actually we want a dark background
        panelView.layer.backgroundColor = UIColor(named: "sp Dark Purple")?.cgColor

        panelView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closePanel)))
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closePanel)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func closePanel() {
        dismiss(animated: true, completion: nil)
    }
}

extension HelpPanelViewController: UITableViewDelegate {
    
}

extension HelpPanelViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let subtitles = dataSource?.subtitles() {
            return subtitles.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Global.Identifier.Cell.HELP_PANEL_HEADER_CELL) as? HelpPanelHeaderCell {
            if let subtitles = dataSource?.subtitles() {
                cell.configureCell(subheading: subtitles[section])
            }
            return cell
        } else {
            fatalError("Help Panel tried to dequeue an incorrect Header cell.")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let subtitles = dataSource?.subtitles(), section < subtitles.count else { return 0 }
        let key = subtitles[section]
        if let entries = dataSource?.helpSectionEntries()[key] {
            return entries.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let key = dataSource?.subtitles()[indexPath.section] else {
            return HelpEntryCell()
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: Global.Identifier.Cell.HELP_ENTRY_CELL) as? HelpEntryCell {
            
            if let entries = dataSource?.helpSectionEntries()[key] {
                cell.configureCell(entry: entries[indexPath.row])
            } else {
                cell.configureCell(entry: "Missing help entry")
            }
            return cell
        } else {
            fatalError("Help Panel dequeuing an invalid cell.")
        }
    }
    
    
}
