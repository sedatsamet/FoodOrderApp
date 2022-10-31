//
//  AnasayfaViewController.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 18.10.2022.
//

import UIKit
import Kingfisher
import Firebase

class AnasayfaViewController: UIViewController {
    @IBOutlet weak var populerCollectionView: UICollectionView!
    @IBOutlet weak var menuTableView: UITableView!
    
    var yemekListesi = [YemekModel]()
    var anasayfaPresenterNesnesi : ViewToPresenterAnasayfaProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarDesign()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        populerCollectionView.delegate = self
        populerCollectionView.dataSource = self
        
        AnasayfaRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.yemekleriAl()
        menuTableView.reloadData()
    }
    
    @IBAction func cartButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "anasayfaToSepetVC", sender: nil)
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            let onBoarding = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onboardingVC")
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.pushViewController(onBoarding, animated: true)
        }catch{
            print("Hata")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetayVC" {
            if let detayYemek = sender as? YemekModel {
                let gidilecekVC = segue.destination as! DetayViewController
                gidilecekVC.yemek = detayYemek
            }
        }
    }
}
// MARK: Tableview ve collectionview'da yapılan değişiklikleri uygulamak için reload edip güncelliyoruz.
extension AnasayfaViewController : PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemekListesi: [YemekModel]) {
        self.yemekListesi = yemekListesi
        DispatchQueue.main.async {
            self.menuTableView.reloadData()
            self.populerCollectionView.reloadData()
        }
    }
}

// MARK: NavigationBar için oluşturduğumuz design fonksiyonu.
extension AnasayfaViewController {
    func navigationBarDesign() {
        let appearance = UINavigationBarAppearance()
        self.navigationItem.title = "Yummy Meals"
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white, .font : UIFont(name: "Anton-Regular", size: 32)!]
        appearance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "foodBackgroundImage")!)
    }
}

extension AnasayfaViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = yemekListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.yemekAdLabel.text = yemek.yemek_adi
        cell.yemekDetayLabel.text = "Detay"
        cell.yemekFiyatLabel.text = "₺\(yemek.yemek_fiyat!),00"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.yemekImageView.kf.setImage(with: url)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yemek = yemekListesi[indexPath.row]
        performSegue(withIdentifier: "toDetayVC", sender: yemek)
        tableView.deselectRow(at: indexPath, animated: true) // Seçilen row' un background değiştirme
    }
}

extension AnasayfaViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemekListesi.count - 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var mixedList:[YemekModel] = Array(yemekListesi.reversed())
        let yemek = mixedList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopulerCollectionViewCell", for: indexPath) as! PopulerCollectionViewCell
        cell.yemekAdLabel.text = yemek.yemek_adi
        cell.yemekFiyatLabel.text = "₺\(yemek.yemek_fiyat!),00"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.yemekImageView.kf.setImage(with: url)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var mixedList:[YemekModel] = Array(yemekListesi.reversed())
        let yemek = mixedList[indexPath.row]
        performSegue(withIdentifier: "toDetayVC", sender: yemek)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

