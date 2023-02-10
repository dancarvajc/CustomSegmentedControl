//
//  PreviewUIView.swift
//  CustomSegmentedControl
//
//  Created by Daniel Carvajal on 10-02-23.
//

import SwiftUI

// Structs used for previewing UIKit components with SwiftUI Preview

// MARK: UIView
struct PreviewUIView: UIViewRepresentable {
    let uiView: UIView
    
    func makeUIView(context: Context) -> UIView {
        return uiView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

// MARK: UIViewController
struct PreviewViewController: UIViewControllerRepresentable {
    let viewController: UIViewController
    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

