//
//  requestDescriptionSingleton.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 04/01/18.
//  Copyright © 2018 Antonio Sirica. All rights reserved.
//

import Foundation


class RequestDescription {
    static let shared = RequestDescription() // Singleton
    var description: String = ""
    
}
