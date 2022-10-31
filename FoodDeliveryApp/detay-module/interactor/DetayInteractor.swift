//
//  DetayInteractor.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 20.10.2022.
//

import Foundation
import Alamofire
class DetayInteractor : PresenterToInteractorDetayProtocol {
    var sepetListe = [SepetYemekModel]()
    var eklenecekYemek:SepetYemekModel?
    
    func sepeteYemekEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        let params:Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post, parameters: params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    print(cevap)
                    print("Yemek Eklendi")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepetiKontrolEt(yemek:SepetYemekModel){
        let params:Parameters = ["kullanici_adi":yemek.kullanici_adi!]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method:.post, parameters:params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(SepetYemekModelResponse.self, from: data)
                    if let liste = cevap.sepet_yemekler{
                        self.sepetListe = liste
                        
                        if self.sepetListe.contains(where: {$0.yemek_adi == yemek.yemek_adi}) {
                            var sepetYemek:SepetYemekModel?
                            if let index = self.sepetListe.firstIndex(where: {$0.yemek_adi == yemek.yemek_adi}){
                                sepetYemek = self.sepetListe[index]
                            }
                            print("Ürün Daha Önce Eklenmiş.")
                            self.eklenecekYemek = SepetYemekModel(sepet_yemek_id: yemek.sepet_yemek_id!, yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: yemek.yemek_fiyat!, yemek_siparis_adet: String(Int(yemek.yemek_siparis_adet!)! + Int(sepetYemek!.yemek_siparis_adet!)!), kullanici_adi: yemek.kullanici_adi!)
                                    
                            self.yemekSil(sepet_yemek_id: Int(sepetYemek!.sepet_yemek_id!)!, kullanici_adi: sepetYemek!.kullanici_adi!)
                        }else{
                            print("Ürün Daha Önce Eklenmemiş")
                            self.sepeteYemekEkle(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: Int(yemek.yemek_fiyat!)!, yemek_siparis_adet: Int(yemek.yemek_siparis_adet!)!, kullanici_adi:yemek.kullanici_adi!)
                        }
                    }
                }catch{
                    self.sepeteYemekEkle(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: Int(yemek.yemek_fiyat!)!, yemek_siparis_adet: Int(yemek.yemek_siparis_adet!)!, kullanici_adi:yemek.kullanici_adi!)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func yemekSil(sepet_yemek_id: Int, kullanici_adi: String) {
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    print(cevap)
                    print("Yemek Silindi")
                    if let ey = self.eklenecekYemek {
                        self.sepeteYemekEkle(yemek_adi: ey.yemek_adi!, yemek_resim_adi: ey.yemek_resim_adi!, yemek_fiyat: Int(ey.yemek_fiyat!)!, yemek_siparis_adet: Int(ey.yemek_siparis_adet!)!, kullanici_adi: ey.kullanici_adi!)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
