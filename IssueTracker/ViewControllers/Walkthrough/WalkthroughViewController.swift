//
//  WalkthroughViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 04/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let viewModel = WalkthroughViewModel()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSlideScrollView()
    }
    
    // MARK: Actions
    
    @IBAction func didSkipTutorial(_ sender: UIButton) {
        AppDelegate.shared.rootViewController.switchToLogin()
    }
    
    @IBAction func didContinue(_ sender: UIButton) {
        let nextPageIndex = pageControl.currentPage + 1
        
        if nextPageIndex < viewModel.slides.count {
            var frame = scrollView.frame
            frame.origin.x = frame.size.width * CGFloat(nextPageIndex)
            scrollView.scrollRectToVisible(frame, animated: true)
            
            return
        }
        
        AppDelegate.shared.rootViewController.switchToLogin()
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.titleLabel?.font = .title
        
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = .title
    }
    
    private func getSlideViews() -> [WalkthroughSlideView] {
        var slideViews: [WalkthroughSlideView] = []
        
        for slide in viewModel.slides {
            let slideView = Bundle.main.loadNibNamed("WalkthroughSlideView", owner: self, options: nil)?.first as! WalkthroughSlideView
            slideView.setupFor(slide: slide)
            slideViews.append(slideView)
        }
        
        return slideViews
    }
    
    private func setupSlideScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let slideViews = getSlideViews()
        
        pageControl.numberOfPages = slideViews.count
        pageControl.currentPage = 0
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(slideViews.count), height: scrollView.frame.height)
        
        for i in 0 ..< slideViews.count {
            slideViews[i].frame = CGRect(x: scrollView.frame.width * CGFloat(i), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slideViews[i])
        }
    }
}

// MARK: - UIScrollViewDelegate

extension WalkthroughViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

