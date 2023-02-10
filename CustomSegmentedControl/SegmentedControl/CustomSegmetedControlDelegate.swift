//
//  CustomSegmetedControlDelegate.swift
//  CustomSegmentedControl
//
//  Created by Daniel Carvajal on 10-02-23.
//

import Foundation

protocol CustomSegmetedControlDelegate: AnyObject {
    /// Tells the delegate when a button is pressed in the segmented control.
    /// - Parameters:
    ///   - buttonTitlesIndex: The position (index) corresponding to buttonTitles input of the pressed button.
    ///   - title: The title of the pressed button.
    func buttonPressed(buttonTitlesIndex: Int, title: String?)
}
