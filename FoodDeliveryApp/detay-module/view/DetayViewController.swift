//
//  DetayViewController.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 19.10.2022.
//

import UIKit
import Kingfisher
import Firebase

class DetayViewController: UIViewController {
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var yemekDetayLabel: UILabel!
    @IBOutlet weak var yemekAdiLabel: UILabel!
    
    @IBOutlet weak var adetLabel: UILabel!
    @IBOutlet weak var adetStepper: UIStepper!
    
    var yemek:YemekModel?
    var yemekDegisenFiyat:Int?
    
    var detayPresenterNesnesi: ViewToPresenterDetayProtocol?
    
    var currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detayYukle()
        
        navigationBarDesign()
        
        adetLabel.text = String(Int(adetStepper.value))
        
        DetayRouter.createModule(ref: self)
        
    }
    
    @IBAction func sepeteEkleButtonClicked(_ sender: Any) {
        let email = currentUser?.email
        
        if let sepetYemek = yemek {
            let eklenecekYemek = SepetYemekModel(sepet_yemek_id: sepetYemek.yemek_id!, yemek_adi: sepetYemek.yemek_adi!, yemek_resim_adi: sepetYemek.yemek_resim_adi!, yemek_fiyat: sepetYemek.yemek_fiyat!, yemek_siparis_adet: adetLabel.text!, kullanici_adi: email!)
            
            detayPresenterNesnesi?.sepetKontrol(yemek: eklenecekYemek)
            
            let alert = UIAlertController(title: "Sepete Eklendi", message: "\(adetLabel.text!) adet \(sepetYemek.yemek_adi!) başarılı bir şekilde sepete eklendi.", preferredStyle: .alert)
            let tamamAction = UIAlertAction(title: "Tamam", style: .default) { action in
                self.performSegue(withIdentifier: "toAnasayfaVC", sender: nil)
            }
            alert.addAction(tamamAction)
            self.present(alert, animated: true)
        }
        
    }
    
    @IBAction func adetStepperDegisim(_ sender: UIStepper) {
        adetLabel.text = String(Int(adetStepper.value))
        if let yemekFiyat = yemek?.yemek_fiyat, let adet = adetLabel.text {
            yemekDegisenFiyat = (Int(yemekFiyat)! * Int(adet)!)
            yemekFiyatLabel.text = "₺\(yemekDegisenFiyat!),00"
        }
    }
    
    @IBAction func cartButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSepetVC", sender: nil)
    }
}

extension DetayViewController {
    func navigationBarDesign(){
        let appearance = UINavigationBarAppearance()
        
        self.navigationItem.title = "Yemek Detay"
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white, .font : UIFont(name: "Anton-Regular", size: 32)!]
        appearance.backgroundColor = UIColor(patternImage: UIImage(named: "foodBackgroundImage")!)
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func detayYukle(){
        if let detayYemek = yemek {
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(detayYemek.yemek_resim_adi!)") {
                yemekImageView.kf.setImage(with: url)
            }
            yemekFiyatLabel.text = "₺\(detayYemek.yemek_fiyat!),00"
            yemekDetayLabel.text = "Yemek Detay"
            yemekAdiLabel.text = detayYemek.yemek_adi
        }
    }
}
