//
//  ViewController.swift
//  CustomSegmentedControl
//
//  Created by Daniel Carvajal on 10-02-23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    private let buttonTitles: [String] = ["Button 1", "Button 2", "Button 3"]
    private lazy var segmentedControl: CustomSegmetedControl = CustomSegmetedControl(buttonTitles: buttonTitles)
    private let centeredTitle: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        addViews()
        prepareSegmentedControl()
        prepareCenteredTitle()
    }
    
    private func addViews() {
        view.addSubview(segmentedControl)
        view.addSubview(centeredTitle)
    }
    
    private func prepareSegmentedControl() {
        segmentedControl.delegate = self
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    private func prepareCenteredTitle() {
        centeredTitle.translatesAutoresizingMaskIntoConstraints = false
        centeredTitle.text = "Button 1 selected"
        NSLayoutConstraint.activate([
            centeredTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centeredTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

// MARK: SegmentedControl delegate
extension ViewController: CustomSegmetedControlDelegate {
    func buttonPressed(buttonTitlesIndex: Int, title: String?) {
        centeredTitle.text = "\(buttonTitles[buttonTitlesIndex]) selected"
    }
}

// MARK: SwiftUI Preview
struct ViewController_Previews: PreviewProvider {
    static let viewController = ViewController()
    static var previews: some View {
        PreviewViewController(viewController: viewController)
            .previewLayout(.sizeThatFits)
    }
}
