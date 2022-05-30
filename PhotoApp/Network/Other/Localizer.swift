//
//  Localizer.swift
//  PhotoApp
//
//  Created by Michał Niemiec on 27/05/2022.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}
