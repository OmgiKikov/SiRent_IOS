//
// Copyright (c) 2020 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class ForgotPasswordViewController: UIViewController {
  
  @IBOutlet var labelTitle: UILabel!
  @IBOutlet var labelSubTitle: UILabel!
  @IBOutlet var textFieldEmail: UITextField!
  @IBOutlet var buttonContinue: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    labelTitle.text = "Забыли свой пароль?"
    labelSubTitle.text = "Введите свой адрес электронной почты, чтобы сбросить пароль."
  }
  
  // MARK: - Data methods
  func sendEmail()
  {
    if Utility.shared.isConnectedToNetwork(){
      
      let forgotmutation = ForgotPasswordMutation(email: textFieldEmail.text!)
      apollo.perform(mutation: forgotmutation){(result,error) in
        print(result?.data?.userForgotPassword?.status as Any)
        if result?.data?.userForgotPassword?.status == 200 {
          print(result?.data?.userForgotPassword?.resultMap)
          
          let alert = UIAlertController(title: "Готово", message: "Письмо вместе с ссылкой для сброса пароля уже отправлено в ваш почтовый ящик", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { (NavigatingtoLogin) in
            let logpage = SignInViewController()
            logpage.modalPresentationStyle = .fullScreen
            self.present(logpage, animated: false, completion: nil)
            
          }))
          self.present(alert, animated: true, completion: nil)
          
        }else{
          Loader.stop()
          self.showAlert(title: "Произошла Ошибка", message: "Попробуйте еще раз")
        }
        
      }
    }else{
      Loader.stop()
      self.showAlert(title: "Произошла Ошибка", message: "Проверьте ваше подключение к интернету")
    }
    
  }
  
  // MARK: - User actions actionContinue
  
  @IBAction func actionContinue(_ sender: Any) {
    Loader.start()
    self.sendEmail()
    print(#function)
  }
  
  @IBAction func actionDissmis(_ sender: Any) {
    dismiss(animated: true)
    print(#function)
  }
}

