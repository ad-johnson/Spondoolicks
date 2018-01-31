//
//  Provides conformance for the Help Panel to obtain data it needs to display
//
//  Created by Andrew Johnson on 31/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

protocol HelpPanelDataSource: class {

    // Returns the Title value to display at the top of the Help Panel
    func helpPanelTitle() -> String
    
    // Returns the subtitles used for section headings in the Help Panel.
    func subtitles() -> [String]
    
    // Returns the entries to display in each section, keyed by section name.
    func helpSectionEntries() -> [String: [String]]
}
