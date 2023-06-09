//
//  ImageGallery1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class ImageGallery1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        self.update()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.update()
    }
    
    // Call every time some data have changed
    func update() {
        
        let section = gallerySection()
        show(content: header(), section)
    }
    
    @objc func openFilters() {
        self.dismiss()
    }
    
    @objc func openSort() {
        self.dismiss()
    }
}

// MARK: - Section

extension ImageGallery1ViewController {
    
    // Header section
    func header() -> DSSection {
        
        // Title
        var label = DSLabelVM(.headline, text: "Images", alignment: .center)
        
        // Close button
        var button = DSButtonVM(sfSymbol: "xmark.circle.fill", type: .link) { [unowned self] btn in
            self.dismiss()
        }
        
        button.width = .absolute(50)
        button.height = .absolute(50)
        
        var colors = DSAppearance.shared.main.primaryView
        colors.button.background = UIColor.label
        button.style.colorStyle = .custom(colors)
        
        label.supplementaryItems = [button.asSupplementary(position: .rightCenter, offset: .custom(.init(x: -15, y: 0)))]
        return label.list()
    }
    
    /// Products gallery
    /// - Returns: DSSection
    func gallerySection() -> DSSection {
        
        let pictures = [p1Image, p2Image, p3Image].map { (url) -> DSViewModel in
            
            DSImageVM(imageUrl: url,
                      height: .absolute(UIDevice.current.contentAreaHeight - 100),
                      displayStyle: .default,
                      contentMode: .scaleAspectFill)
        }
        
        let pageControl = DSPageControlVM(type: .viewModels(pictures), galleryType: .fullWidth)
        return pageControl.list().zeroLeftRightInset().zeroBottomInset()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct ImageGallery1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: ImageGallery1ViewController(), DSKitAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/709791/pexels-photo-709791.jpeg?cs=srgb&dl=pexels-daria-shevtsova-709791.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/3756750/pexels-photo-3756750.jpeg?cs=srgb&dl=pexels-sound-on-3756750.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/3760767/pexels-photo-3760767.jpeg?cs=srgb&dl=pexels-sound-on-3760767.jpg&fm=jpg")
