# postal-codes

iOS Application using AlamoFire to make requests, CoreData to store a huge CSV file full of postal codes and SnapKit for better constraint managing of the View code.

The app downloads the CSV file from the internet, and if successfully downloaded, the CoreData is used to store all the data for future offline use by converting the CSV file to an array using the swift framework TabularData and then line by line stored inside the device.

Further notes:

Another prototype was made using the Realm dependecy, a third-party lib for database device storage, but the results were not as good as using the CoreData framework, speed-wise.

Some tests were made using CoreData multithreading architecture, as managing a big volume of data is really not for the main thread, reserverd mostly for UI operations, but the lack of time and knowledge to handle a better loading visual representation prevented to use this solution, even though its the best  path to follow. The following line would change the game entirely:

```context = appDelegate.persistentContainer.newBackgroundContext()```

The ViewFactory class was used to facilitate managing all objects.

The project uses the MVVM architecture. Maybe using SwiftUI instead of ViewCode would be a way better solution, but again, the lack of time and knowledge prevented me to do so.

One last topic to be mentioned is the query to search for postal codes, where the terms typed onto the UISearchBar were used to create a NSPredicate to search for data inside CoreData database:

```let predicate: NSPredicate = NSPredicate(format: "postal_code_info CONTAINS[cd] %@", searchTerm)```

Unfortunately the "CONTAINS[cd]" query is not satisfatory, although it can used to search incomplete, case-insensitive results, it is terrible for out-of-order, full tests search. 
