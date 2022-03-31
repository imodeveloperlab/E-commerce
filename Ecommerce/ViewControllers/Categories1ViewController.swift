//
//  Categories1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Categories1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        update()
    }
    
    func update() {
        show(content: categoriesSection())
    }
}


// MARK: - Categories

extension Categories1ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func categoriesSection() -> DSSection {
        
        let shoes = category(title: "Shoes",
                             description: "812 items",
                             image:  URL.purpleShoes)
        
        let shirts = category(title: "Shirts", description: "1.4K items")
        let jeans = category(title: "Jeans", description: "345 items", image: URL.jeansPairs)
        
        let watches = category(title: "Watches", description: "20K items", image: URL.watchesOnYellowBg)
        let shorts = category(title: "Shorts", description: "2.5k items")
        let trackPants = category(title: "Track Pants", description: "600 items", image: URL.pantsTrack)
        let jackets = category(title: "Jackets", description: "20K items")
        let blazers = category(title: "Blazers", description: "915 items", image: URL.blazers)
        
        let socks = category(title: "Socks", description: "75.1K items")
        
        let section = [shoes, shirts, jeans, watches, shorts, trackPants, jackets, blazers, socks].list()
       // section.header = header(title: "Categories")
        
        section.headlineHeader("Categories", size: 30)
        
        return section
    }
    
    func category(title: String, description: String, image: URL? = nil) -> DSViewModel {
        
        var category = DSActionVM(title: title, subtitle: description, arrow: true) { [unowned self] action in
            self.dismiss()
        }
        
        if let image = image {
            category.leftImage(url: image, size: .size(CGSize(width: 60, height: 60)))
        }
        
        category.height = .absolute(80)
        
        return category
    }
}


// MARK: - SwiftUI Preview

import SwiftUI

struct Categories1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Categories1ViewController(), BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
