# Forum for iOS 
A congress app that uses Firebase as backend and can receive Push notifications via the Firebase 3.0 console.                      
This app was made for the organisation Bifrost, for the event Forum 2016 in Denmark.

![GitHub Logo](https://github.com/bifrostDK/ForumiOS/blob/master/Screenshots/readme/Tidsplan.png?raw=true)
![GitHub Logo](https://github.com/bifrostDK/ForumiOS/blob/master/Screenshots/readme/Auktion.png?raw=true)

### Download a deployed version in the App store.
https://itunes.apple.com/us/app/forum16/id1141696748?l=da&ls=1&mt=8

## Getting Started
1. [Download](https://developer.apple.com/xcode/download/) the Xcode 8.2 release.
2. Clone this repository.
3. Run `sudo gem install` in a terminal to install tools and dependencies.
4. Run `pod install` in the folder, to build and run tests on all platforms.
5. Go to https://firebase.com and create an account. 
6. Setup an app on Firebase, download the Google-services.json file and replace the old one in the project with it.
7. Upload the json database to Firebase 'FirebaseJsonDatabase/forumapp-4d3f7-export.json'.
7. Upload youre push notification certificates from you're keychain.

### Language: 
Swift 3.0

### Deployment version:
iOS 9.0 + 


### 3rd party librarys:
- EZSwipeController -  https://github.com/goktugyil/EZSwipeController
- Firebase/Storage - https://cocoapods.org/?q=firebase
- Firebase/Database - https://cocoapods.org/?q=firebase
- SwiftyJSON - https://cocoapods.org/?q=SwiftyJSON 
- Kingfisher - https://cocoapods.org/?q=Kingfisher
- FirebaseStorage - https://cocoapods.org/?q=firebase
- FirebaseMessaging - https://cocoapods.org/?q=firebase
- AASquaresLoading - https://cocoapods.org/?q=AASquaresLoading
- SweetAlert - https://github.com/codestergit/SweetAlert-iOS

## Developer 
Joachim Dittman Jepsen
https://github.com/Joachimdj
 

## Everything else is under MIT licence:
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
