import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore

final class AuthManager {
    static let shared = AuthManager()
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    private init() {}
    
    // MARK: - Email & Password ilə Qeydiyyat
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "AuthError", code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "İstifadəçi məlumatı tapılmadı."])))
                return
            }
            
            // İstifadəçi məlumatlarını Firestore‑a yazırıq.
            self.db.collection("users").document(user.uid).setData([
                "email": email,
                "createdAt": Timestamp(date: Date())
            ]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(user))
                }
            }
        }
    }
    
    // MARK: - Email & Password ilə Giriş
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "AuthError", code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "İstifadəçi məlumatı tapılmadı."])))
                return
            }
            completion(.success(user))
        }
    }
    
    // Google ilə qeydiyyatdan keçmək üçün metod
    func signUpWithGoogle(presenting viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = signInResult?.user else {
                completion(.failure(NSError(domain: "GoogleSignIn", code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Google istifadəçi məlumatı tapılmadı."])))
                return
            }

            let idToken = user.idToken!.tokenString
            let accessToken = user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let firebaseUser = authResult?.user else {
                    completion(.failure(NSError(domain: "AuthError", code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Firebase istifadəçi məlumatı tapılmadı."])))
                    return
                }

                // İstifadəçi məlumatlarını Firestore-a yazırıq (əgər əvvəllər yoxdursa)
                let userRef = self.db.collection("users").document(firebaseUser.uid)
                userRef.getDocument { document, error in
                    if let document = document, document.exists {
                        // İstifadəçi artıq mövcuddur
                        completion(.success(firebaseUser))
                    } else {
                        // Yeni istifadəçidir, Firestore-a yazırıq
                        userRef.setData([
                            "email": firebaseUser.email ?? "",
                            "createdAt": Timestamp(date: Date())
                        ]) { error in
                            if let error = error {
                                completion(.failure(error))
                            } else {
                                completion(.success(firebaseUser))
                            }
                        }
                    }
                }
            }
        }
    }

    
    // MARK: - Google ilə Giriş
    func signInWithGoogle(presenting viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = signInResult?.user else {
                completion(.failure(NSError(domain: "GoogleSignIn", code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Google istifadəçi məlumatı tapılmadı."])))
                return
            }
            
            // Burada `?.tokenString` istifadə etməyə ehtiyac yoxdur!
            let idToken = user.idToken!.tokenString
            let accessToken = user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            self.auth.signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let firebaseUser = authResult?.user else {
                    completion(.failure(NSError(domain: "AuthError", code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Firebase istifadəçi məlumatı tapılmadı."])))
                    return
                }
                completion(.success(firebaseUser))
            }
        }
    }}
