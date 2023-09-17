# DBPostListApp
The application is based on VIPER architecture. It has the following components:

View is the user interface. This layer is the ViewController together with the UIView(or xib/storyboard)

Interactor contains business logic related to the data (Entities) or networking, like creating new instances of entities or fetching them from the server.

The presenter is directing data between the view and interactor, taking user actions, and calling to router to move the user between views. The only class to communicate with all the other components.

Entity is your plain data objects, not the data access layer, because that is the responsibility of the Interactor.

The router handles navigation between the VIPER modules.

I have made some modifications to the VIPER architecture. In VIPER mainly Presenter has a weak instance of view and pushes the data to view with the presenter. Here I have used Combine and View is subscribing to the changes in the viewModel done by the Presenter.


**Third-Party Services:**
The application uses Alamofire for network calls and Realm for the database.
