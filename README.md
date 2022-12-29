## Swift Photo Gallery

That project it's a personal project to demonstrate how to work with clean architeture on ios native applications.

## Overview

The project was divided in 3 part's.
#### SDK:
Contains all bussines logic, native features handler's and external access in this case firebase.
All that features has unit test.

#### UIKIT application:
That aplication it's a storyboard aplication with mvc architeture.
Some dinamic elements programaticaly replace storyboard elements, like activity indicator.

#### SwiftUI aplication:
That aplication use brand new SwiftUI tool on it's screens with mvvm architeture.

## Project Architeture Diagram

![architeture-diagram](https://user-images.githubusercontent.com/30703894/210006620-730e6592-726e-4d2f-9333-29aa4d68b716.jpg)

### Photo Gallery SDK

That SDK has all business rule's for aplication use, and have ao access to ios native features, like camera, network.

## Overview

As datasource was used firebase and all acess to this datasource is in this SDK and can easily replaced to another datasource without break the applications.

## Features SDK

- get media list url from datasource
- get unique media url from datasource
- delete media from datasource
- save media on datasource
- device gallery access permission
- device camera permission
- aplication autentication: login
- aplication autentication: create account
- aplication autentication: reset password
- most models(entities) are value object
- dependency injection system


## UIKIT APP
<p>
<img src="https://user-images.githubusercontent.com/30703894/210006776-b6d63ba2-c456-4e2f-be36-29b1fd8377c8.png" width=25% height=auto alt="1- onboarding">
<img src="https://user-images.githubusercontent.com/30703894/210006804-7837ea9a-0d66-43d4-9b92-b0dc6e2c3045.png" width=25% height=auto alt="2 - sign in">
<img src="https://user-images.githubusercontent.com/30703894/210006807-85f17caf-419a-4c42-9767-9f148c2c3fab.png" width=25% height=auto alt="3 - sign up">
<img src="https://user-images.githubusercontent.com/30703894/210006809-500f346d-6245-44ee-b62b-72c218311d4e.png" width=25% height=auto alt="4 - permission">
<img src="https://user-images.githubusercontent.com/30703894/210006810-1dc456ad-4e2e-4fcc-8f31-0d551a7c3ff1.png" width=25% height=auto alt="5 - permission alert">
<img src="https://user-images.githubusercontent.com/30703894/210006811-5574d3c3-a1b6-473b-8f17-8446c61dcd20.png" width=25% height=auto alt="6 - home">
<img src="https://user-images.githubusercontent.com/30703894/210006812-ddddf8f8-b2c5-4d8d-9b32-515329caf5ea.png" width=25% height=auto alt="7 - home landscape">
<img src="https://user-images.githubusercontent.com/30703894/210006813-2b34056f-a06f-4f5d-ad17-0af21b499b22.png" width=25% height=auto alt="8 - gallery images">
<img src="https://user-images.githubusercontent.com/30703894/210006814-e16a436a-0c08-48d8-8ace-53f7ace1d095.png" width=25% height=auto alt="9 - gallery images landscape">
<img src="https://user-images.githubusercontent.com/30703894/210006815-6228e0e2-0682-492e-8491-deed93e16bcf.png" width=25% height=auto alt="10 - gallery sheet image detail">
<p/>

## SwiftUI APP

<p>
<img src="https://user-images.githubusercontent.com/30703894/210006943-b2841f93-4ebc-4eaa-a77b-0fbebc2bbec6.png" width=25% height=auto alt="1 - onboarding" />
<img src="https://user-images.githubusercontent.com/30703894/210006946-7bce8f7f-5cf8-4503-a31e-9c1ded454c63.png" width=25% height=auto alt="2 - onboarding landscape" />
<img src="https://user-images.githubusercontent.com/30703894/210006947-dfd1372b-7d2d-4bee-8295-c34d95bec6e1.png" width=25% height=auto alt="3 - login" />
<img src="https://user-images.githubusercontent.com/30703894/210006951-cba7b082-8933-4b04-b701-8fd0af56ba61.png" width=25% height=auto alt="4 - register" />
<img src="https://user-images.githubusercontent.com/30703894/210006953-64e702d2-feac-40fb-8660-0c7d8dcd93de.png" width=25% height=auto alt="5 - permission" />
<img src="https://user-images.githubusercontent.com/30703894/210006956-e1dabed4-d8e8-4ad7-81a8-0c8436ec6ded.png" width=25% height=auto alt="6 - permission landscape" />
<img src="https://user-images.githubusercontent.com/30703894/210006957-8752efb3-63c9-46ea-8822-c02b4996e70b.png" width=25% height=auto alt="7 - home" />
<img src="https://user-images.githubusercontent.com/30703894/210006960-967e97dd-a784-4368-a66d-b026d3a6f8a1.png" width=25% height=auto alt="8 - home pick image" />
<img src="https://user-images.githubusercontent.com/30703894/210006962-d6cde896-5e10-4aea-875c-10708262a4b4.png" width=25% height=auto alt="9 - home upload  image" />
<img src="https://user-images.githubusercontent.com/30703894/210006963-68e1de78-1fbe-48c9-9f56-e42059be8eda.png" width=25% height=auto alt="10 - gallery images" />
<img src="https://user-images.githubusercontent.com/30703894/210006965-ef7a5ca8-6e61-4c3b-9111-41d6d2e15baf.png" width=25% height=auto alt="11 - gallery images landscape" />
<img src="https://user-images.githubusercontent.com/30703894/210006967-f48d00c1-7337-4634-b348-8047308802cb.png" width=25% height=auto alt="12 - gallery image sheet detail" />
<p/>

## SDK Test

To run test open the project thought .xcworkspace, and open the group Photo Gallery With Firebase SDKTests to execute one by one, or just click on test navigator on XCODE menu to access and execute all.

![1 - tests-directory](https://user-images.githubusercontent.com/30703894/210007257-cc29201b-9239-4db2-a82e-44fcc7ace6ab.png)
-
![2 - test navigator](https://user-images.githubusercontent.com/30703894/210007306-9081777b-786f-463e-bd7c-b80f236b92e9.png)
## How To Run

To run this project:
- clone on the machine 
- select the SDK and do the a build(cmb+b)
- select the desired aplication(UIKit ppp or SwiftUI App) 
- select the target device or simulator
- build and run 
- done

![target selection](https://user-images.githubusercontent.com/30703894/210007409-9db5bb7c-4a16-4037-8bd4-8894f9a902be.png)

## Feedback

If you had any feedback, please let me know on pauloantonelli@zoominitcode.dev


## 🔗 Follow me
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://zoominitcode.dev/)

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/pauloantonelli/)

![logo](https://user-images.githubusercontent.com/30703894/210007500-da797234-9264-494c-9fec-4c7ee8c823ef.png)
