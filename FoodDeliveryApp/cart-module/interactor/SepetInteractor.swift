//
//  SepetInteractor.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 20.10.2022.
//

import Foundation
import Alamofire
class SepetInteractor : PresenterToInteractorSepetProtocol {
    var sepetPresenter: InteractorToPresenterSepetProtocol?

    func tumSepetYemekleriAl(kullanici_adi: String) {
        let params:Parameters = ["kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method:.post, parameters:params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(SepetYemekModelResponse.self, from: data)
                    if let liste = cevap.sepet_yemekler{
                        self.sepetPresenter?.presenteraVeriGonder(sepetListesi: liste)
                    }
                }catch{
                    self.sepetPresenter?.presenteraVeriGonder(sepetListesi: [SepetYemekModel]())
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepetYemekSil(sepet_yemek_id: Int, kullanici_adi: String) {
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    print(cevap)
                    self.tumSepetYemekleriAl(kullanici_adi: kullanici_adi)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
