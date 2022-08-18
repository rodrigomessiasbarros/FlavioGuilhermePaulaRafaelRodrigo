//
//  AddOcorrenciaViewController.swift
//  FlavioGuilhermePaulaRafaelRodrigo
//
//  Created by Rodrigo Messias Barros on 17/08/22.
//

import UIKit

class AddOcorrenciaViewController: UIViewController {
    
    
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldAddress: UITextField!
    @IBOutlet weak var txtFieldDate: UITextField!
    @IBOutlet weak var txtFieldDetails: UITextView!
    @IBOutlet weak var btnCadastrar: UIButton!
    

    var ocorrencia: Ocorrencia!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if ocorrencia != nil {
                title = "Editar Ocorrência"
                btnCadastrar.setTitle("Alterar", for: .normal)
                txtFieldName.text = ocorrencia.name
                txtFieldAddress.text = ocorrencia.address
                txtFieldDate.text = ocorrencia.date
                txtFieldDetails.text = ocorrencia.details
            }
            
        }
        

        @IBAction func addNewOcorrencia(_ sender: UIButton) {
            if ocorrencia == nil {
                ocorrencia = Ocorrencia(context: context)
            }
            
            ocorrencia.name = txtFieldName.text
            ocorrencia.address = txtFieldAddress.text
            ocorrencia.date = txtFieldDate.text
            ocorrencia.details = txtFieldDetails.text
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            
            navigationController?.popViewController(animated: true)
            
        }

}
