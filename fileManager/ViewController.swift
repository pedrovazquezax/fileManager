//
//  ViewController.swift
//  fileManager
//
//  Created by Pedro Antonio Vazquez Rodriguez on 25/05/18.
//  Copyright © 2018 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var lista = [Lista]()
    var pila = [String]()
    var setS = Set<Character>()
    var setE = Set<Character>()
    var setI = Set<Character>()
    var setF = Set<Character>()
    var setT = Set<Character>()
    
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var setTLabel: UILabel!
    @IBOutlet weak var setELabel: UILabel!
    @IBOutlet weak var setFLabel: UILabel!
    @IBOutlet weak var setILabel: UILabel!
    
    @IBOutlet weak var setSLabel: UILabel!
    @IBOutlet weak var pilaTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setS = ["0","1","2"]
        setI = ["0"]
        setF = ["2"]
        // Do any additional setup after loading the view, typically from a nib.
        if let filePath = Bundle.main.path(forResource: "archivotxt", ofType: "txt"){
            do{
               let contenido = try String(contentsOfFile: filePath)
                let fila = contenido.components(separatedBy: "\n")
                for i in 0..<fila.count{
                    let datosArchivo = fila[i].components(separatedBy: "\t")
                    let campos = Lista(simbolosNoTerminales: datosArchivo[0], dir: datosArchivo[3])
                    self.lista.append(campos)
                    self.pila.append(textoPila(A: datosArchivo[0], B: datosArchivo[3]))
                    
                    textSetE(B: datosArchivo[3])
                    textSetT(B: datosArchivo[3])
                }
                
            }catch let error as NSError{
                print("error al leer el archivo", error)
                
            }
        }else{
            print("no existe archivo")
        }
        
        setSLabel.text = "S = {\(setS)}"
        setILabel.text = "I = {\(setI)}"
        setFLabel.text = "F = {\(setF)}"
        setELabel.text = "∑ = {\(setE)}"
        setTLabel.text = "T = {\(setT)}"
        pilaTextView.text = "P = {\(pila)}"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let list = lista[indexPath.row]
        cell.textLabel?.text = list.simbolosNoTerminales
        cell.detailTextLabel?.text = list.dir
        
        return cell
    }
    
    func textoPila(A :String,B:String) -> String {
        return "2;𝛌;\(A);2;\(B)"
    }
    func textSetE(B: String) {
        var auxB = B
        for _ in 0..<auxB.count{
            var aux = "\(auxB.removeFirst())"
            if aux == aux.lowercased(){
                setE.insert(aux.removeFirst())
            }
        }
        
    }
    func textSetT(B: String) {
        var aux = B
        for _ in 0..<aux.count{
            setT.insert(aux.removeFirst())
        }
    }

    
}

