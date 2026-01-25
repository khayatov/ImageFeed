//
//  ProfileViewTests.swift
//  ImageFeedTests
//
//  Created by Andrey Khayatov on 25.01.26.
//

@testable import ImageFeed
import XCTest

@MainActor
final class ProfileViewTests: XCTestCase {
    
    func testViewControllerCallsViewDidLoad() {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenterSpy()
        viewController.configure(presenter)
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testPresenterCallsSetupView() async {
        let viewController = ProfileViewControllerSpy()
        
        let profileService = ProfileServiceFake()
        profileService.profile = ImageFeed.Profile(username: "", name: "", loginName: "", bio: "")
        let profileImageService = ProfileImageServiceFake()
        profileImageService.avatarURL = "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.1.0&crop=faces&fit=crop&w=64&h=64"
        let presenter = ProfilePresenter(profileService: profileService, profileImageService: profileImageService)
        viewController.configure(presenter)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(viewController.setupViewCalled)
    }
    
    func testPresenterCallsSetupAvatarCalled() async {
        let viewController = ProfileViewControllerSpy()
        
        let profileService = ProfileServiceFake()
        profileService.profile = ImageFeed.Profile(username: "", name: "", loginName: "", bio: "")
        let profileImageService = ProfileImageServiceFake()
        profileImageService.avatarURL = "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-4.1.0&crop=faces&fit=crop&w=64&h=64"
        let presenter = ProfilePresenter(profileService: profileService, profileImageService: profileImageService)
        viewController.configure(presenter)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(viewController.setupAvatarCalled)
    }
}
