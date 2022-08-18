//
//  OcorrenciaTableViewCell.swift
//  FlavioGuilhermePaulaRafaelRodrigo
//
//  Created by Rodrigo Messias Barros on 17/08/22.
//

import UIKit

class OcorrenciaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with ocorrencia: Ocorrencia) {
        lblName.text = ocorrencia.name ?? ""
        lblDate.text = ocorrencia.date ?? ""
    }

}
