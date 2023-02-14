//
//  CustomSegmetedControl.swift
//  CustomSegmentedControl
//
//  Created by Daniel Carvajal on 10-02-23.
//

import UIKit
import SwiftUI

final class CustomSegmetedControl: UIView {
    private var verticalContainer: UIView = UIView()
    private var buttonsContainer: UIStackView = UIStackView()
    
    private var buttons: [UIButton] = []
    private var buttonTitles: [String] = []
    
    private var barView: UIView = UIView()
    private var barViewLeadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    weak var delegate: CustomSegmetedControlDelegate?
    private var selectedButtonIndex: Int = 0
    
    private var elementsTintColor: UIColor = UIColor()
    private var fontSelected: UIFont = UIFont()
    private var fontUnselected: UIFont = UIFont()
    
    /// Creates the custom segmented control with segments having the given titles.
    /// - Parameters:
    ///   - buttonTitles: The titles of the segmented control will have.
    ///   - tintColor: The color of the bar and segments.
    ///   - fontSelected: The font of the selected segmented.
    ///   - fontUnselected: The font of the unselected segmented.
    convenience init(buttonTitles: [String], tintColor: UIColor = .systemPurple, fontSelected: UIFont = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .bold)), fontUnselected: UIFont = .preferredFont(forTextStyle: .body)) {
        self.init()
        // Ensures buttonTitles has at least one element to avoid runtime crash
        guard buttonTitles.isEmpty == false else { return }
        self.buttonTitles = buttonTitles
        self.fontSelected = fontSelected
        self.fontUnselected = fontUnselected
        self.tintColor = tintColor
        configure()
    }
    
    private func configure() {
        addViews()
        prepareVContainer()
        prepareButtons()
        prepareButtonsContainer()
        prepareBarView()
    }
    
    private func addViews() {
        addSubview(verticalContainer)
    }
    
    private func prepareVContainer() {
        verticalContainer.translatesAutoresizingMaskIntoConstraints = false
        verticalContainer.addSubview(buttonsContainer)
        verticalContainer.addSubview(barView)
        
        NSLayoutConstraint.activate([
            verticalContainer.topAnchor.constraint(equalTo: topAnchor),
            verticalContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // CustomSegmetedControl UIView constrains to adapt to the height of their subviews
            topAnchor.constraint(equalTo: buttonsContainer.topAnchor),
            bottomAnchor.constraint(equalTo: barView.bottomAnchor)
        ])
    }
    
    // Creates the buttons from the buttonTitles array
    private func prepareButtons() {
        buttons = buttonTitles.map { title in
            let button: UIButton = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tintColor = .black
            button.titleLabel?.font = fontUnselected
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            return button
        }
        buttons[0].setTitleColor(tintColor, for: .normal)
        buttons[0].titleLabel?.font = fontSelected
    }
    
    // Add the buttons in a horizontal container
    private func prepareButtonsContainer() {
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonsContainer.axis = .horizontal
        buttonsContainer.distribution = .fillEqually

        buttons.forEach {
            buttonsContainer.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            buttonsContainer.topAnchor.constraint(equalTo: verticalContainer.topAnchor),
            buttonsContainer.leadingAnchor.constraint(equalTo: verticalContainer.leadingAnchor),
            buttonsContainer.trailingAnchor.constraint(equalTo: verticalContainer.trailingAnchor),
        ])
    }
    
    private func prepareBarView() {
        let firstButton = buttons[0]
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.backgroundColor = tintColor
        barViewLeadingConstraint = barView.leadingAnchor.constraint(equalTo: firstButton.leadingAnchor)
        
        NSLayoutConstraint.activate([
            barView.topAnchor.constraint(equalTo: buttonsContainer.bottomAnchor, constant: 5),
            barView.widthAnchor.constraint(equalTo: firstButton.widthAnchor),
            barView.heightAnchor.constraint(equalToConstant: 4),
            barViewLeadingConstraint
        ])
    }
    
    // Perform the UI/logic changes when a button is pressed
    @objc private func buttonAction(sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        delegate?.buttonPressed(buttonTitlesIndex: buttonIndex, title: sender.titleLabel?.text)
        selectedButtonIndex = buttonIndex
        prepareButtonsUI()
        animateBarViewPosition()
    }
    
    // Change the color and font when a button is pressed
    private func prepareButtonsUI() {
        let selectedButton = buttons[selectedButtonIndex]
        buttons.forEach { button in
            if button == selectedButton {
                button.setTitleColor(tintColor, for: .normal)
                button.titleLabel?.font = fontSelected
            } else {
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = fontUnselected
            }
        }
    }
    
    // Change and animate the barView position
    private func animateBarViewPosition() {
        let selectedButton = buttons[selectedButtonIndex]
        barViewLeadingConstraint.isActive = false
        barViewLeadingConstraint = barView.leadingAnchor.constraint(equalTo: selectedButton.leadingAnchor)
        barViewLeadingConstraint.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

// MARK: SwiftUI Preview
struct CustomSegmetedControl_Previews: PreviewProvider {
    static let uiView: UIView = CustomSegmetedControl(buttonTitles: ["Button 1", "Button 2", "Button 3"])
    static var previews: some View {
        PreviewUIView(uiView: uiView)
            .frame(height: 40)
            .previewLayout(.sizeThatFits)
    }
}
