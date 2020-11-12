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
import Apollo

class SignInViewController: UIViewController {
  
  @IBOutlet var labelTitle: UILabel!
  @IBOutlet var labelSubTitle: UILabel!
  @IBOutlet var textFieldEmail: UITextField!
  @IBOutlet var textFieldPassword: UITextField!
  @IBOutlet var buttonHideShowPassword: UIButton!
  @IBOutlet var buttonLogin: UIButton!
  
  var pasteEmail = String()
  var pastePassword = String()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    labelTitle.text = "Добро Пожаловать \nв SiRent"
    labelSubTitle.text = "База объявлений об аренде и продаже недвижимости по всей России"
    textFieldEmail.setLeftPadding(value: 15)
    textFieldPassword.setLeftPadding(value: 15)
    textFieldPassword.setRightPadding(value: 40)
  }
  
  // MARK: - Data methods
  func checkLoginAPI()
  {
    let loginquery = LoginQuery(email: textFieldEmail.text!, password: textFieldPassword.text!, deviceType:"iOS", deviceDetail: "", deviceId:Utility.shared.pushnotification_devicetoken)
    let apollo = ApolloClient(url: URL(string:graphQLEndpoint)!)
    apollo.fetch(query: loginquery,cachePolicy:.fetchIgnoringCacheData) { (result,error) in
      if(result?.data?.userLogin?.status == 200) {
        
        Utility.shared.logindataArray.removeAll()
        if(result?.data?.userLogin?.result?.user?.preferredCurrency != nil)
        {
          Utility.shared.setPreferredCurrency(currency_rate: (result?.data?.userLogin?.result?.user?.preferredCurrency as AnyObject) as! String)
        }
        else
        {
          Utility.shared.setPreferredCurrency(currency_rate:"RUB")
          Utility.shared.selectedCurrency = "RUB"
        }
        Utility.shared.setopenTabbar(iswhichtabbar:false)
        Utility.shared.setUserToken(userID:(result?.data?.userLogin?.result?.userToken as AnyObject) as! NSString)
        
        Utility.shared.setUserID(userid: (result?.data?.userLogin?.result?.userId as AnyObject)as! NSString)
        Utility.shared.setPassword(password: self.textFieldPassword!.text! as NSString)
        Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.userToken as AnyObject)  //Usertoken
        Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.userId as AnyObject)  //Userid
        Utility.shared.logindataArray.append("\(result?.data?.userLogin?.result?.user?.firstName)" + "" + "\(result?.data?.userLogin?.result?.user?.lastName)" as AnyObject)  //Profilename
        Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.picture as AnyObject)  // Picture
        Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.createdAt as AnyObject)  //createdDate
        Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.verification?.isPhoneVerified as AnyObject) //Phoneverification
        Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.verification?.isEmailConfirmed as AnyObject)  //Email
        Utility.shared.logindataArray.append(result?.data?.userLogin?.result?.user?.verification?.isIdVerification as AnyObject) //idVerification
        Utility.shared.user_token = (result?.data?.userLogin?.result?.userToken)!
        Utility.shared.locationfromSearch = ""
        Utility.shared.isfromsearchLocationFilter = false
        Utility.shared.isfromfloatmap_Page = false
        Utility.shared.isfromGuestProfile = false
        if(Utility.shared.searchLocationDict.count > 0)
        {
          Utility.shared.searchLocationDict.setValue(nil, forKey: "lat")
          Utility.shared.searchLocationDict.setValue(nil, forKey: "lon")
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        Utility.shared.setTab(index: 0)
        
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        
        appDelegate.GuestTabbarInitialize(initialView: CustomTabbar())
        
      }else if result?.data?.userLogin?.status == 500 {
        Loader.stop()
        self.textFieldEmail.resignFirstResponder()
        self.textFieldPassword.resignFirstResponder()
        Utility.shared.showAlert(msg: "\((result?.data?.userLogin?.errorMessage)!)")
        
      }
      else{
        Loader.stop()
        self.textFieldPassword.resignFirstResponder()
        self.textFieldEmail.resignFirstResponder()
        self.showAlert(title: "Неверные учетные данные для входа в систему", message: "")
        
      }
    }
  }
  
  // MARK: - User actions
  @IBAction func actionHideShowPassword(_ sender: Any) {
    
    buttonHideShowPassword.isSelected = !buttonHideShowPassword.isSelected
    textFieldPassword.isSecureTextEntry = !buttonHideShowPassword.isSelected
  }
  
  @IBAction func actionLogin(_ sender: Any) {
    
    if Utility().isConnectedToNetwork() {
      Loader.start()
      checkLoginAPI()
    } else {
      showAlert(title: "Проверьте ваше подключение к интернету", message: "")
      Loader.stop()
    }
    print(#function)
  }
  
  @IBAction func actionForgotPassword(_ sender: Any) {
    
    let forgotObj = ForgotPasswordViewController()
    forgotObj.modalPresentationStyle = .fullScreen
    self.present(forgotObj, animated: true, completion: nil)
    print(#function)
  }
  
  @IBAction func actionSignUp(_ sender: Any) {
    let signUp = SignUpViewController()
    signUp.modalPresentationStyle = .fullScreen
    self.present(signUp, animated: true, completion: nil)
    print(#function)
  }
  
  @IBAction func actionDissmis(_ sender: Any) {
    
    Utility.shared.isfromdetailpage = false
    Utility.shared.setTab(index: 0)
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    appdelegate.GuestTabbarInitialize(initialView: CustomTabbar())
    print(#function)
  }
}
