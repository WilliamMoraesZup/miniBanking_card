//
//  REST.swift
//  miniBanking_account
//
//  Created by William Moraes da Silva on 30/10/21.
//

import Foundation


public class REST {
    
    private static let session = URLSession(configuration: configuration)
    
    private static let configuration : URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        
        return config
    }()
    
    private static let statementPath =  "https://mockbin.org/bin/ffd32766-97fc-4fa4-967f-8b63f7e94da8"
    
    private static let userPath =  "https://mockbin.org/bin/3192df13-989c-4174-aa2a-30f4a5cc8742"
    
    // DUVIDA SE MUDA A ESTRUTURA DA FUNCAO, O DATATASK RECLAMA
    class func loadStatement(onComplete : @escaping ([Statement]) -> Void, onError: @escaping (String) -> Void ) {
        guard let url = URL(string: statementPath) else { return }
        
        let dataTask = session.dataTask(with: url)  {  (data : Data?, response: URLResponse?, error : Error?) in
            
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    return   }
                if response.statusCode == 200 {
                    
                    guard let data = data else {
                        onError("Erro")
                        return }
                    do {
                        let statements = try JSONDecoder().decode([Statement].self, from: data)
                      
                        onComplete(statements)
                    }
                    catch
                    {
                        print(error)
                    }
                }
                else {
                    onError("Status code != 200")
                }
            }
            else {
                onError(error?.localizedDescription ?? "erro no retorno")
            }
            
        }
        
        dataTask.resume()
        
    }
    
    
    class func loadUser(onComplete: @escaping (UserFinancial) -> Void){
        
       guard let url = URL(string: userPath) else { return}
       
       let dataTask = session.dataTask(with: url) { ( data : Data?, response : URLResponse?, error : Error?) in
             
           if error == nil {
               guard let response = response as? HTTPURLResponse else { return}
                
               if response.statusCode == 200 {
                    
                   guard let data = data else { return}
                   
                   do {
                       let user = try JSONDecoder().decode(UserFinancial.self, from: data)
                       
                       onComplete(user)
                   }
                   catch {
                       print("erro no Decode")
                   }
               }
               else {
                   print("Status code != 200")
               }
           }
           else {
               print("Erro na requisicao")
           }
       }
        dataTask.resume()
    }
    
     
}  
