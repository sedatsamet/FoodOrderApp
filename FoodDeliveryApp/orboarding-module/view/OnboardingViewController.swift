//
//  OnboardingViewController.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 16.10.2022.
//

import UIKit
import Lottie

class OnboardingViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var collectionViewItemList = [OnboardingItem]()
    
    var onboardingPresenterNesnesi: ViewToPresenterOnboardingProtocol?
    
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == collectionViewItemList.count - 1 {
                nextButton.setTitle("Başla", for: .normal)
            }else{
                nextButton.setTitle("Sonraki", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        OnboardingRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        onboardingPresenterNesnesi?.onboardingYukle()
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == collectionViewItemList.count - 1 {
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
extension OnboardingViewController : PresenterToViewOnboardingProtocol {
    func vieweVeriGonder(onboardingListesi: [OnboardingItem]) {
        self.collectionViewItemList = onboardingListesi
        self.collectionView.reloadData()
    }
}

// MARK: ViewController Extensions for CollectionView & ScrollView
extension OnboardingViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewItemList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let slide = collectionViewItemList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        if let animationView = slide.animation {
            animationView.frame = cell.animationView.bounds
            animationView.loopMode = .loop
            animationView.animationSpeed = 1
            cell.animationView.addSubview(animationView)
            animationView.play()
        }
        cell.collectionTitleLabel.text = slide.title
        cell.collectionDescLabel.text = slide.description
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    // Change pagecontrol currentPage with collectionview scroll
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
