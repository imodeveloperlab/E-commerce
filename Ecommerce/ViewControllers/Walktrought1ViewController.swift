//
//  Walktrought1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class Walktrought1ViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let person = DSFaker().person
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = WalktroughtData()
        
        // Page control
        let pageControl = DSPageControlVM(type: .pages(data.getFashionPages().walkthroughPages()))
                
        var skipButton = DSButtonVM(title: "Skip", type: .link)
        skipButton.height = .absolute(20)
        skipButton.didTap = { _ in
            self.dismiss()
        }
        
        // Show gallery
        show(content: [pageControl.list().zeroLeftRightInset(), skipButton.list()])
    }
}

public struct WalkthroughSimplePage {
    
    public init(text: (title: String, description: String, alignment: NSTextAlignment),
                image: (content: DSImageContent, style: DSImageDisplayStyle, height: CGFloat)) {
        
        self.text = text
        self.image = image
    }
    
    let text: (title: String, description: String, alignment: NSTextAlignment)
    let image: (content: DSImageContent, style: DSImageDisplayStyle, height: CGFloat)
}

extension WalkthroughSimplePage {
    
    func viewModel() -> DSPageVM {
        
        let appearance = DSAppearance.shared.main
        
        // Image
        let image = DSImageVM(imageValue: self.image.content,
                              height: .absolute(self.image.height),
                              displayStyle: self.image.style)
        
        // Compose text
        let composer = DSTextComposer(alignment: self.text.alignment)
        let spacing = appearance.interItemSpacing
        
        // Title
        composer.add(type: .headlineWithSize(36), text: self.text.title, spacing: spacing, maximumLineHeight: 34)
        
        // Description
        composer.add(type: .body, text: self.text.description, spacing: spacing)
        
        // Space
        let space = DSSpaceVM()
        
        // Page with view models
        var page = DSPageVM(viewModels: [image, space, composer.textViewModel()])
        page.contentInsets = appearance.margins.edgeInsets
        page.height = .absolute(UIDevice.current.contentAreaHeight - 80)
        
        return page
    }
}

fileprivate enum WalkthroughPage {
    case simple(WalkthroughSimplePage)
}

fileprivate extension Array where Element == WalkthroughPage {
    
    func walkthroughPages() -> [DSPageVM] {
        
        self.map { (type) -> DSPageVM in
            switch type {
            case.simple(let page):
                return page.viewModel()
            }
        }
    }
}

fileprivate class WalktroughtData {
    
    func getFashionPages() -> [WalkthroughPage] {
        
        return [.simple(getDiscoverPage()),
                .simple(getFindPage()),
                .simple(getDifferencePage())]
    }
    
    func getDiscoverPage() -> WalkthroughSimplePage {
        
        let title = "Discover clothes, accessories, and more."
        let subtitle = "Get all brands in one place.\nFill the bag full of joy."
        
        return WalkthroughSimplePage(text: (title: title, description: subtitle, alignment: .center),
                                     image: (content: .imageURL(url: image1), style: .circle, height: 300))
    }
    
    func getFindPage() -> WalkthroughSimplePage {
        
        let title = "Find everything you need"
        let subtitle = "Get all brands in one place.\nFill the bag full of joy."
        
        return WalkthroughSimplePage(text: (title: title, description: subtitle, alignment: .left),
                                     image: (content: .imageURL(url: image2), style: .themeCornerRadius, height: 350))
    }
    
    func getDifferencePage() -> WalkthroughSimplePage {
        
        let title = "Feel the difference"
        let subtitle = "Get all brands at one place, Fill the bag with full of joy."
        
        return WalkthroughSimplePage(text: (title: title, description: subtitle, alignment: .left),
                                     image: (content: .imageURL(url: image3), style: .themeCornerRadius, height: 350))
    }
}

fileprivate let image1 = URL(string: "https://images.unsplash.com/photo-1483985988355-763728e1935b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80")

fileprivate let image2 = URL(string: "https://images.unsplash.com/photo-1492707892479-7bc8d5a4ee93?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1301&q=80")

fileprivate let image3 = URL(string: "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1326&q=80")


// MARK: - SwiftUI Preview

import SwiftUI

struct Walktrought1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Walktrought1ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
