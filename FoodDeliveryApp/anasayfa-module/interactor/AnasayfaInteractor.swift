//
//  AnasayfaInteractor.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 19.10.2022.
//

import Foundation
import Alamofire
import Kingfisher

class AnasayfaInteractor : PresenterToInteractorAnasayfaProtocol{
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    
    func tumYemekleriAl() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemekModelResponse.self, from: data)
                    if let liste = cevap.yemekler {
                        self.anasayfaPresenter?.presenteraVeriGonder(yemekListesi: liste)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
