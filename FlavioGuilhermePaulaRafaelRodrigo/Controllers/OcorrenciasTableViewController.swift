//
//  OcorrenciasTableViewController.swift
//  FlavioGuilhermePaulaRafaelRodrigo
//
//  Created by Rodrigo Messias Barros on 17/08/22.
//

import UIKit
import CoreData

class OcorrenciasTableViewController: UITableViewController {
    
    var fetchedResultController: NSFetchedResultsController<Ocorrencia>!
    var label = UILabel()
    
    lazy var fetchedResultsController: NSFetchedResultsController<Ocorrencia> = {
        let fetchRequest: NSFetchRequest<Ocorrencia> = Ocorrencia.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Não há ocorrências cadastradas"
        label.textAlignment = .center
        
        loadOcorrencias()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "ocorrenciaSegue" {
            let vc = segue.destination as! OcorrenciaViewController
            if let ocorrencias = fetchedResultController.fetchedObjects {
                vc.ocorrencia = ocorrencias[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    func loadOcorrencias(){
        let fetchRequest: NSFetchRequest<Ocorrencia> = Ocorrencia.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "name", ascending: true) // ordena por nome
        let dataDescritor = NSSortDescriptor(key: "date", ascending: true) // ordena por data decrescente
        fetchRequest.sortDescriptors = [dataDescritor, sortDescritor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OcorrenciaTableViewCell
        
        guard let ocorrencia = fetchedResultController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        
        cell.prepare(with: ocorrencia)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let ocorrencia = fetchedResultController.fetchedObjects?[indexPath.row] else {return}
            context.delete(ocorrencia)
        }
    }
  
}

extension OcorrenciasTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            default:
                tableView.reloadData()
        }
        
        
    }
}
