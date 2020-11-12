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

class SignUpViewController: UIViewController {
  
  @IBOutlet var textFieldFirstName: UITextField!
  @IBOutlet var textFieldLastName: UITextField!
  @IBOutlet var textFieldEmail: UITextField!
  @IBOutlet var textFieldPassword: UITextField!
  @IBOutlet var textFieldDateOfBirth: UITextField!
  @IBOutlet var buttonContinue: UIButton!
  
  let datePicker = UIDatePicker()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textFieldFirstName.setLeftPadding(value: 15)
    textFieldLastName.setLeftPadding(value: 15)
    textFieldEmail.setLeftPadding(value: 15)
    textFieldPassword.setLeftPadding(value: 15)
    textFieldDateOfBirth.setLeftPadding(value: 15)
    
    showDatePicker()
    passwordValidation()
  }
  
  // MARK: - User actions
  
  @IBAction func actionContinue(_ sender: Any) {
    Loader.start()
    if Utility().isConnectedToNetwork(){
      signupAPICall()
    }
    print(#function)
  }
  
  @IBAction func actionTerms(_ sender: Any) {
    
    print(#function)
  }
  
  @IBAction func actionPrivacy(_ sender: Any) {
    
    print(#function)
  }
  
  @IBAction func actionDissmis(_ sender: Any) {
    
    dismiss(animated: true)
    print(#function)
  }
  
  
  func showDatePicker() {
    
    //Formate Date
    datePicker.datePickerMode = .date
    
    //ToolBar
    let toolbar = UIToolbar();
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
    
    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    
    textFieldDateOfBirth.inputAccessoryView = toolbar
    textFieldDateOfBirth.inputView = datePicker
    
  }
  
  @objc func donedatePicker() {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    textFieldDateOfBirth.text = formatter.string(from: datePicker.date)
    self.view.endEditing(true)
  }
  
  @objc func cancelDatePicker() {
    
    self.view.endEditing(true)
  }
  
  
  
  // MARK: - Data methods
  func signupAPICall(){
    
    let signupMutation = SignupMutation(firstName:(textFieldFirstName.text), lastName: textFieldLastName.text, email: textFieldEmail.text!, password:textFieldEmail.text!, dateOfBirth: textFieldDateOfBirth.text, deviceType: "iOS", deviceDetail: "", deviceId:Utility.shared.pushnotification_devicetoken, registerType: "email")
    apollo.perform(mutation: signupMutation){ (result,error) in
      if(result?.data?.createUser?.status == 200) {
        Utility.shared.signupArray.removeAllObjects()
        Utility.shared.signupdataArray.removeAll()
        Utility.shared.setUserToken(userID: (result?.data?.createUser?.result?.userToken as AnyObject) as! NSString)
        Utility.shared.setUserID(userid: (result?.data?.createUser?.result?.userId as AnyObject)as! NSString)
        Utility.shared.signupdataArray.append(result?.data?.createUser?.result?.user?.firstName as AnyObject)   //Username
        Utility.shared.signupdataArray.append(result?.data?.createUser?.result?.user?.createdAt as AnyObject) //createdAt
        Utility.shared.signupdataArray.append(result?.data?.createUser?.result?.user?.picture as AnyObject)  //profile
        Utility.shared.signupdataArray.append(result?.data?.createUser?.result?.user?.verification?.isEmailConfirmed as AnyObject) //emailverification
        Utility.shared.signupdataArray.append(result?.data?.createUser?.result?.user?.verification?.isIdVerification as AnyObject) //idVerification
        Utility.shared.signupdataArray.append(result?.data?.createUser?.result?.user?.verification?.isFacebookConnected as AnyObject) //FbVerification
        Utility.shared.signupdataArray.append(result?.data?.createUser?.result?.user?.verification?.isPhoneVerified as AnyObject) //phoneVerifcation
        Utility.shared.signupdataArray.append(result?.data?.createUser?.result?.user?.verification?.isGoogleConnected as AnyObject) //googleVerification
        Utility.shared.user_token = (result?.data?.createUser?.result?.userToken)!
        
        if(result?.data?.createUser?.result?.user?.preferredCurrency != nil)
        {
          Utility.shared.setPreferredCurrency(currency_rate: (result?.data?.createUser?.result?.user?.preferredCurrency as AnyObject) as! String)
        }
        else
        {
          Utility.shared.setPreferredCurrency(currency_rate:"RUB")
          Utility.shared.selectedCurrency = "RUB"
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
      }
      else {
        Loader.stop()
        Utility.shared.showAlert(msg:((result?.data?.createUser?.errorMessage)!))
        //self.view.makeToast(result?.data?.createUser?.errorMessage!)
      }
    }
  }
  
  fileprivate func passwordValidation() {
    
    if ((self.textFieldPassword.text?.count)! >= 7) {
      buttonContinue.isEnabled = true
    } else {
      buttonContinue.isEnabled = false
    }
  }
}
