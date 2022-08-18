//
//  OcorrenciaViewController.swift
//  FlavioGuilhermePaulaRafaelRodrigo
//
//  Created by Rodrigo Messias Barros on 18/08/22.
//

import UIKit

class OcorrenciaViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDetails: UITextView!
    
    var ocorrencia: Ocorrencia!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblName.text = ocorrencia?.name
        lblAddress.text = ocorrencia?.address
        lblDate.text = ocorrencia?.date
        lblDetails.text = ocorrencia?.details
        
        // Se o campo Data fosse do tipo Date, a implementação ficaria assim
        /*
        if let data = ocorrencia.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .long //possui vários tipos digite "." e veja as opções
            formatter.locale = Locale(identifier: "pt-BR")
            lblDate.text = formatter.string(from: data)  // lembrando que aqui a data precisaria ser do tipo date
        }
         */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddOcorrenciaViewController
        vc.ocorrencia = ocorrencia
    }

}
