//
//  Bundle+Extension.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import Foundation
extension Bundle {
    ///Application Name
    var ApplicationName: String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }
}
