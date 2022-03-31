//
//  AboutUs2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 17.12.2020.
//

import UIKit
import DSKit
import DSKitFakery

class AboutUs2ViewController: DSViewController {
    
    enum AboutUs2ViewControllerSegments: Int {
        case info
        case comments
        case contacts
    }
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let faker = DSFaker()
    var currentSectionIndex: AboutUs2ViewControllerSegments = .info
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About Us"
        update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func update() {
        
        var sections = [DSSection]()
        
        sections.append(getSwitchSectionsSection())
        
        // Switch between sections and update content
        switch currentSectionIndex {
        case .info:
            sections.append(getInfoHeaderSection())
            sections.append(getInfoGallerySection())
            sections.append(getInfoDescriptionSection())
        case .comments:
            sections.append(getFeedbackSection())
        case .contacts:
            sections.append(getContactsSection())
        }
        
        let space = DSSpaceVM()
        sections.append(space.list())
        self.show(content: sections)
        
        // Switch between sections and update bottom content
        switch currentSectionIndex {
        case .info:
            self.hideBottomContent()
        case .comments:
            let button = DSButtonVM(title: "Leave feedback", icon: UIImage(systemName: "message.fill")) { _ in
                self.dismiss()
            }
            self.showBottom(content: [button])
        case .contacts:
            self.hideBottomContent()
        }
    }
}

// MARK: - Info
extension AboutUs2ViewController {
    
    /// Info header section
    /// - Returns: DSSection
    func getInfoHeaderSection() -> DSSection {
        
        // Title
        let title = DSLabelVM(.title2, text: "Best Store in town")
        
        // Subtitle
        let subtitle = DSLabelVM(.body ,text: "Here you will feel the attitude, here you will receive quality, here you will see the atmosphere of an authentic store")
        
        return [title, subtitle].list()
    }
    
    /// Info description section
    /// - Returns: DSSection
    func getInfoDescriptionSection() -> DSSection {
        
        let text1 = DSLabelVM(.body ,text: faker.text)
        let text2 = DSLabelVM(.subheadline ,text: faker.text)
        let text3 = DSLabelVM(.body ,text: faker.text)
        
        return [text1, text2, text3].list()
    }
    
    /// Gallery section
    /// - Returns: DSSection
    func getInfoGallerySection() -> DSSection {
        
        let urls = [p1Image, p2Image, p3Image].compactMap({ $0 })
        
        let pictureModels = urls.map { url -> DSViewModel in
            return DSImageVM(imageUrl: url, height: .absolute(200))
        }
        
        let pageControl = DSPageControlVM(type: .viewModels(pictureModels))
        return pageControl.list().zeroLeftRightInset()
    }
}

// MARK: - Contacts
extension AboutUs2ViewController {
    
    /// Contacts section
    /// - Returns: DSSection
    func getContactsSection() -> DSSection {
        
        let phone = textRow(title: "Phone: ", details: faker.phoneNumber, icon: "phone.fill")
        let address = textRow(title: "Address: ", details: faker.streetAddress, icon: "map.fill")
        let workingHours = textRow(title: "Working Hours: ", details: "Open ⋅ Closes 5PM", icon: "calendar.badge.clock")
        let health = textRow(title: "Health and safety: ", details: "Mask required · Temperature check required · Staff wear masks · Staff get temperature checks", icon: "info.circle.fill")
        let map = DSMapVM(coordinate: faker.address.coordinate)
        let button = DSButtonVM(title: "Get directions", icon: UIImage(systemName: "map.fill"))
        
        return [phone, address, workingHours, health, map, button].list()
    }
    
    func textRow(title: String, details: String, icon: String) -> DSActionVM {
        
        let text = DSTextComposer()
        text.add(type: .headline, text: title)
        text.add(type: .subheadline, text: details, newLine: false)
        var row = DSActionVM(composer: text)
        row.leftIcon(sfSymbolName: icon, size: CGSize(width: 18, height: 18))
        row.leftViewPosition = .top
        row.style.displayStyle = .grouped(inSection: false)
        return row
    }
}

// MARK: - Feedback
extension AboutUs2ViewController {
    
    /// Feedback section
    /// - Returns: DSSection
    func getFeedbackSection() -> DSSection {
        
        let models = [0,1,2,4].map { (index) -> DSViewModel in
            
            // Text
            let text = DSTextComposer()
            text.add(type: .headline, text: faker.name)
            text.add(type: .subheadline,
                     text: Date().stringFormatted(dateStyle: .medium, timeStyle: .none) + " ",
                     icon: UIImage(systemName: "calendar"), spacing: 5)
            
            text.add(rating: Int.random(in: 2...5),
                     maximumValue: 5,
                     positiveSymbol: "star.fill",
                     negativeSymbol: "star", style: .custom(size: 12, weight: .medium),
                     tint: .custom(UIColor.systemYellow),
                     spacing: 5,
                     newLine: false)
            
            text.add(type: .caption1, text: faker.text)

            // Action
            var action = DSActionVM(composer: text)
            action.style.displayStyle = .grouped(inSection: false)
            action.leftSideView = profilePicture(index: index)
            
            return action
        }
        
        return models.list()
    }
    
    /// Profile picture
    /// - Parameter index: Int
    /// - Returns: DSSideView
    func profilePicture(index: Int) -> DSSideView {
        
        var picture = DSImageVM(imageUrl: URL.profileUrl(index: index),
                                height: .absolute(50),
                                displayStyle: .circle)
        
        picture.width = .absolute(70)
        picture.height = .absolute(60)
        return DSSideView(view: picture)
    }
}

// MARK: - About Us
extension AboutUs2ViewController {
    
    /// Switch sections section
    /// - Returns: DSSection
    func getSwitchSectionsSection() -> DSSection {
        
        let segment = DSSegmentVM(segments: ["Info", "Feedback", "Contacts"])
        
        segment.didTapOnSegment = { segment in
            self.currentSectionIndex =  AboutUs2ViewControllerSegments(rawValue: segment.index) ?? .info
            
            // Call update to show changes
            self.update()
        }
        
        return segment.list()
    }
}


// MARK: - SwiftUI Preview

import SwiftUI

struct AboutUs2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: AboutUs2ViewController())
            PreviewContainer(VC: nav, BlackToneAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/164763/pexels-photo-164763.jpeg?cs=srgb&dl=pexels-pixabay-164763.jpg&fm=jpg")

fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg?cs=srgb&dl=pexels-pixabay-264636.jpg&fm=jpg")

fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/1402407/pexels-photo-1402407.jpeg?cs=srgb&dl=pexels-lisa-fotios-1402407.jpg&fm=jpg")
