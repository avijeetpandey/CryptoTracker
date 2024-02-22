## CryptoTracker :tada: :rocket:

An iOS app to list down crypto currencies made with Swift and UIKit

## Video Recording

https://github.com/avijeetpandey/CryptoTracker/assets/40532869/048f1c77-d24f-4a82-87c5-62dccb085a08

The application has been implemented using Swift and Programmatic UI using UIKit

## File structure of the application
The application follows **standard MVVM** architecture to make it modular and scalable as per the problem statement, it also uses `Protocol Oriented Programming` to make the solution more robust.

Given Below is the folder structure of the application

- `Controllers` - contains the code for controllers in the application
- `Views` - Contains custom implementation of views implemented
- `ViewModel` - Contains the viewModel where most of the business logic lives
- `Networking` - Contains the networking part of the application and manages to make network calls over the internet
- `Resources` - Contains the assets needed in the application
- `Protocols` - Contains the implementation of protocols
- `Model` - Contains the implementation of data models needed to parse JSON data from the internet using `Codables`
- `Extensions` - Contains extra functionality extending `UIColor` and `UITableView`
- `Constants`  - Contains the constants used in the application

## Functionalities implemented
- Fetching live data from the internet and populating in the UI
- Support to filter coins by various filter methods ( new, token , only coins, etc)
- Support to search a coin by its `Symbol Name`


PS: Sometimes it may give the error **Server with hostname not found** in that case please, try to **re-run the application** this happens mostly due to an un-stable URL
