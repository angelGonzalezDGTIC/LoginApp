//
//  GoogleViewController.swift
//  LoginApp
//
//  Created by Ángel González on 19/11/22.
//

import UIKit
import GoogleSignIn

class GoogleViewController: UIViewController {

    var googleButton = GIDSignInButton(frame: .zero)
    var logoutButton = UIButton(type:.system)
    var tvInfo = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var sesionIniciada = false
        // Do any additional setup after loading the view.
        // Validar si el usuario ya inició sesión
        GIDSignIn.sharedInstance.restorePreviousSignIn {
            user, error in
            guard let signInUser = user else {
                print ("Ocurrió un error al autenticar \(String(describing: error))")
                return
            }
            var info = "Nombre: " + (signInUser.profile?.givenName ?? "") + "\n"
            info += "Apellido: " + (signInUser.profile?.familyName ?? "") + "\n"
            info += "Email: " + (signInUser.profile?.email ?? "")
            self.tvInfo.text = info
            sesionIniciada = true
        }
        
        let stack = UIStackView(frame: self.view.bounds.insetBy(dx: 50, dy: 50))
        stack.axis = .vertical
        stack.spacing = 50
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        self.view.addSubview(stack)
        googleButton.style = GIDSignInButtonStyle.wide
        googleButton.addTarget(self, action:#selector(googleButtonTouch), for:.touchUpInside)
        googleButton.isEnabled = !sesionIniciada
        stack.addArrangedSubview(googleButton)
        tvInfo.frame = CGRect(x:0, y:0, width: 200, height:200)
        tvInfo.backgroundColor = .lightGray
        stack.addArrangedSubview(tvInfo)
        logoutButton.setTitle("Cerrar sesión", for: .normal)
        logoutButton.frame = CGRect(x:0, y:0, width: 200, height:100)
        logoutButton.addTarget(self, action:#selector(logoutButtonTouch), for:.touchUpInside)
        logoutButton.isEnabled = sesionIniciada
        stack.addArrangedSubview(logoutButton)
    }
    
    @objc func googleButtonTouch() {
        let configuracion = GIDConfiguration(clientID: "731853760091-3opup49m5omph0domlgchfhvd8v2abj3.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: configuracion, presenting: self) {
            user, error in
            guard let signInUser = user else {
                print ("Ocurrió un error al autenticar \(String(describing: error))")
                return
            }
            var info = "Nombre: " + (signInUser.profile?.givenName ?? "") + "\n"
            info += "Apellido: " + (signInUser.profile?.familyName ?? "") + "\n"
            info += "Email: " + (signInUser.profile?.email ?? "")
            self.tvInfo.text = info
            self.logoutButton.isEnabled = true
        }
    }

    @objc func logoutButtonTouch() {
        // TODO: Confirmar si el usuario quiere cerrar sesión
        GIDSignIn.sharedInstance.signOut()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
