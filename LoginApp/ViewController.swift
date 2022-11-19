//
//  ViewController.swift
//  LoginApp
//
//  Created by Ángel González on 18/03/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    @IBAction func btnContinueTouch(_ sender: Any) {
        guard let mail = txtUser.text,
              let pass = txtPass.text
        else {
            return
        }
        var mensaje = ""
        if mail == "" {
            mensaje = "falta el correo"
        }
        else if pass == "" {
            mensaje = "falta el password"
        }
        else {
            /*let expresionRegular = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$")
                                                            //^w+[+.w-]*@([w-]+.)*w+[w-]*.([a-z]{2,4}|d+)$")
                                                            //)
            let coincidencias = expresionRegular.matches(in: mail, range: NSRange(location: 0, length: mail.count))
            if coincidencias.count != 1 {
                // no hizo match el string con el patron
                mensaje = "debe indicar un correo válido"
            }
            else { */
                // TODO: validar las credenciales...
                /* 1. validación Local (NO RECOMENDABLE)
                let pathToFile = Bundle.main.url(forResource: "USER_DATA", withExtension: "json")
                do {
                    let data = try Data.init(contentsOf: pathToFile!)
                    let jsonArray = try JSONSerialization.jsonObject(with:data, options:.mutableContainers) as! [[String:Any]]
                    let filteredArray = jsonArray.filter {
                      dictionary in
                      return dictionary["user_name"] as! String == self.txtUser.text!
                    }
                    if filteredArray.count == 0 {
                      mensaje = "El usuario no existe"
                    }
                    else {
                        let userInfo = filteredArray.first!
                        if (userInfo["password"] as! String) != self.txtPass.text! {
                            mensaje = "El password es incorecto"
                        }
                    }
                }
                catch {
                  print ("Error, no se puede leer el archivo \(String(describing: error))")
                }
                */
                // 2. Validar contra mi propio backend
                
                // a. Especificar el endpoint
                let endpoint = "https://fundacionunam.org.mx/becas_unam/nutricional/usuarios_controller.php"
                let parametros = ["buscar_usuario_cafeteria" : 1,
                                  "user": mail,
                                  "pass": pass] as [String:Any]
                AF.request(endpoint, method:.post, parameters: parametros).response {
                    response in
                    if let data = response.data {
                        do {
                            let jsonArray = try JSONSerialization.jsonObject(with:data, options:.allowFragments) as? [String:Any]
                            print (jsonArray)
                        }
                        catch {
                          print ("Error, no se recibió respuesta del backend \(String(describing: error))")
                        }
                    }
                }
                
            //}
        }
        
        if mensaje == "" {
            // go to home
            print ("Todo OK... ahora que?")
        }
        else {
            // presentar el mensaje al usuario
            let alert = UIAlertController(title: "error", message: mensaje, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSignUpTouch () {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

