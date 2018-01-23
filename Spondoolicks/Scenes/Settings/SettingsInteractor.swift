//
//  SettingsInteractor.swift
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol SettingsBusinessLogic {
    func doSomething(request: Settings.Something.Request)
}

protocol SettingsDataStore {
    //var name: String { get set }
}

class SettingsInteractor: SettingsBusinessLogic, SettingsDataStore {
    // MARK: - Properties
    var presenter: SettingsPresentationLogic?
    var worker: SettingsWorker?
    //var name: String = ""
  
    // MARK: - Use Cases
    func doSomething(request: Settings.Something.Request) {
        worker = SettingsWorker()
        worker?.doSomeWork()
    
        let response = Settings.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
