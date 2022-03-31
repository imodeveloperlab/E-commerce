//
//  AboutUs1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit
import DSKitFakery

open class AboutUs1ViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let faker = DSFaker()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "About Us"
        show(content: [getInfoHeaderSection(),
                       getInfoGallerySection(),
                       getInfoDescriptionSection()])
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - Info
extension AboutUs1ViewController {
    
    /// Info header section
    /// - Returns: DSSection
    func getInfoHeaderSection() -> DSSection {
        
        // Title
        let title = DSLabelVM(.title2, text: "Our Story")
        
        // Subtitle
        let subtitle = DSLabelVM(.body ,text: "Start working with DSKit that can provide everything you need to generate any interface you need. Dummy text is text that is used in the publishing industry or by web designers to occupy the space which will later be filled with 'real' content.")
        
        return [title, subtitle].list()
    }
    
    /// Info description section
    /// - Returns: DSSection
    func getInfoDescriptionSection() -> DSSection {
        
        var text1 = DSLabelVM(.body ,text: faker.text)
        text1.leftSideView = iconSideView("message.fill")
        
        var text3 = DSLabelVM(.body ,text: faker.text)
        text3.leftSideView = iconSideView("leaf.arrow.triangle.circlepath")
        
        var text2 = DSLabelVM(.subheadline ,text: faker.text)
        text2.leftSideView = iconSideView("shippingbox.fill")
        
        return [text1, text2, text3].list(separator: true, grouped: true)
    }
    
    /// Icon side view
    /// - Parameter name: String
    /// - Returns: DSSideView
    func iconSideView(_ name: String) -> DSSideView {
        
        var icon = DSImageVM(imageValue: .sfSymbol(name: name, style: .medium),
                             displayStyle: .default,
                             contentMode: .scaleAspectFit)
        
        icon.width = .absolute(25)
        icon.height = .absolute(25)
        icon.tintColor = .text(.headline)
        
        return DSSideView(view: icon)
    }
    
    /// Gallery section
    /// - Returns: DSSection
    func getInfoGallerySection() -> DSSection {
        
        let urls = [p1Image,
                    p2Image,
                    p3Image].compactMap({ $0 })
        
        let pictureModels = urls.map { url -> DSViewModel in
            return DSImageVM(imageUrl: url, height: .absolute(200))
        }
        
        let pageControl = DSPageControlVM(type: .viewModels(pictureModels))
        return pageControl.list().zeroLeftRightInset()
    }
}


// MARK: - SwiftUI Preview

import SwiftUI

struct AboutUs1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: AboutUs1ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/1036857/pexels-photo-1036857.jpeg?cs=srgb&dl=pexels-artem-beliaikin-1036857.jpg&fm=jpg")


fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg?cs=srgb&dl=pexels-pixabay-264636.jpg&fm=jpg")

fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/1402407/pexels-photo-1402407.jpeg?cs=srgb&dl=pexels-lisa-fotios-1402407.jpg&fm=jpg")
