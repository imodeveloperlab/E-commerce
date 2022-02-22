//
//  Filters1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Filters1ViewController: DSViewController {
    
    var selectedSortBy = "Featured"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Filters"
        
        // Reset
        let reset = UIBarButtonItem(title: "Reset",
                                    style: .plain,
                                    target: self,
                                    action: #selector(resetAction))
        
        navigationItem.rightBarButtonItems = [reset]
        
        update()
    }
    
    @objc func resetAction() {
        self.dismiss()
    }
    
    func update() {
        
        // Show content
        show(content: [sortSection(), filtersSection()])
        
        // Add to cart button
        let viewAll = DSButtonVM(title: "View 245 Items") { [unowned self] tap in
            self.dismiss()
        }
        
        showBottom(content: viewAll)
    }
}

// MARK: - Sort Section
extension Filters1ViewController {
    
    func sortSection() -> DSSection {
        
        let sort = ["Featured", "New Items", "Price (Hight First)", "Price (Low First)"]
        
        let models = sort.map { (title) -> DSViewModel in
            
            // Is selected
            let isSelected = selectedSortBy == title
            
            // Text
            let composer = DSTextComposer()
            composer.add(type: isSelected ? .headlineWithSize(15) : .subheadline, text: title)
            var model = composer.checkboxActionViewModel(selected: isSelected)
            
            // Handle action
            model.didTap { [unowned self] (_: DSActionVM) in
                self.selectedSortBy = title
                self.update()
            }
            
            return model
        }
        
        return models.list().headlineHeader("Sort by")
    }
}

// MARK: - Filtes Section
extension Filters1ViewController {
    
    func filtersSection() -> DSSection {
        
        let filters = ["Size": "All",
                       "Brand": "Adidas, Puma, HRX",
                       "Color": "Black",
                       "Price": "$0-$999",
                       "Range": "All"]
        
        let models = filters.enumerated().map { (key, value) -> DSViewModel in
            
            // Title
            let composer = DSTextComposer()
            composer.add(type: .headlineWithSize(15), text: value.key)
            var model = composer.actionViewModel()
            
            // Right text
            let composer2 = DSTextComposer()
            composer2.add(type: .subheadline, text: value.value)
            model.rightText(composer: composer2)
            
            // Chevron
            let chevron = DSImageVM(imageValue: .sfSymbol(name: "chevron.right", style: .medium),
                                    height: .absolute(15),
                                    displayStyle: .default,
                                    contentMode: .scaleAspectFit)
            
            // Right side view
            model.rightSideView = DSSideView(view: chevron)
            model.height = .absolute(50)
            
            return model
        }
        
        return models.list().headlineHeader("Sort by")
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Filters1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Filters1ViewController())
            PreviewContainer(VC: nav, DSKitAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
