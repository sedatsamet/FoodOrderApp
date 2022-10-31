//
//  SepetViewController.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 19.10.2022.
//

import UIKit
import Firebase

class SepetViewController: UIViewController {
    @IBOutlet weak var sepetTableView: UITableView!
    @IBOutlet weak var toplamSepetTutarLabel: UILabel!
    
    var sepetYemekListesi = [SepetYemekModel]()
    var sepetPresenterNesnesi : ViewToPresenterSepetProtocol?
    
    var currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarDesign()
        
        SepetRouter.createModule(ref: self)
        
        sepetTableView.delegate = self
        sepetTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let email = currentUser?.email
        sepetPresenterNesnesi?.sepetYemekleriAl(kullanici_adi: email!)
        self.sepetTableView.reloadData()
    }
    
    @IBAction func siparisVerButtonClicked(_ sender: Any) {
        if sepetYemekListesi.isEmpty {
            let alert = UIAlertController(title: "Sepet Boş", message: "Sipariş verebilmek için yemek ekleyin.", preferredStyle: .alert)
            let tamamAction = UIAlertAction(title: "Tamam", style: .default) { action in
                self.performSegue(withIdentifier: "sepetToAnasayfaVC", sender: nil)
            }
            alert.addAction(tamamAction)
            self.present(alert, animated: true)
        }else{
            let alert = UIAlertController(title: "Sipariş Alındı", message: "Sipariş başarılı bir şekilde alındı.", preferredStyle: .alert)
            let tamamAction = UIAlertAction(title: "Tamam", style: .cancel) { action in
                for yemek in self.sepetYemekListesi {
                    self.sepetPresenterNesnesi?.YemekSil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: yemek.kullanici_adi!)
                }
                self.performSegue(withIdentifier: "sepetToAnasayfaVC", sender: nil)
            }
            alert.addAction(tamamAction)
            self.present(alert, animated: true)
        }
    }
}

extension SepetViewController : PresenterToViewSepetProtocol {
    func vieweVeriGonder(sepetListesi: [SepetYemekModel]) {
        DispatchQueue.main.async {
            self.sepetYemekListesi = sepetListesi
            self.sepetTableView.reloadData()
            
            if sepetListesi.count == 0 {
                self.toplamSepetTutarLabel.text = "₺0,00"
            }
            
            var toplamTutar = 0
            for yemek in sepetListesi {
                let fiyat = Int(yemek.yemek_fiyat!)!
                let adet = Int(yemek.yemek_siparis_adet!)!
                let tutar = fiyat * adet
                toplamTutar += tutar
                self.toplamSepetTutarLabel.text = "₺\(toplamTutar),00"
            }
        }
    }
}

extension SepetViewController {
    func navigationBarDesign(){
        let appearance = UINavigationBarAppearance()
        
        self.navigationItem.title = "Sepetim"
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white, .font : UIFont(name: "Anton-Regular", size: 32)!]
        appearance.backgroundColor = UIColor(patternImage: UIImage(named: "foodBackgroundImage")!)
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension SepetViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetYemekListesi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = sepetYemekListesi[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SepetTableViewCell", for: indexPath) as! SepetTableViewCell
        cell.sepetYemekAdiLabel.text = yemek.yemek_adi
        let fiyat = (Int(yemek.yemek_fiyat!)! * Int(yemek.yemek_siparis_adet!)!)
        cell.sepetYemekFiyatLabel.text = "₺\(fiyat),00"
        cell.adetLabel.text = yemek.yemek_siparis_adet
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.sepetYemekImageView.kf.setImage(with: url)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            let yemek = self.sepetYemekListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(yemek.yemek_adi!) silinsin mi ?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.sepetPresenterNesnesi?.YemekSil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: yemek.kullanici_adi!)
                
                self.sepetYemekListesi.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
