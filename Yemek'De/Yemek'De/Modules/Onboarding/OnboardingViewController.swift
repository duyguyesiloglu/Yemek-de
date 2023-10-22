//
//  OnboardingViewController.swift
//  Yemek'D App
//
//  Created by Duygu Yesiloglu on 10.10.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal )
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slides = [ OnboardingSlide(title: "Delicious Dishes", description: "Experience dishes from different cultures!", image: #imageLiteral(resourceName: "nigiri")),
                   OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best." , image: #imageLiteral(resourceName: "slide2")),
                   OnboardingSlide(title: "Fast Delivery", description: "Track your food order on the map.", image: #imageLiteral(resourceName: "location"))]
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UITabBarController
            controller.modalPresentationStyle = .fullScreen
            // controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
 

}
    extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
            
            cell.setup(slides[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x / width)
            
        }
}
