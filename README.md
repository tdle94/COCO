# COCO

Core Framework I use:
- RxSwift (For data binding)
- Moya (This is a wrapper around Alamofire to abstract away url request & parameters)
- SDWebImage (I use this to download image from the web & cache image from previous requests)
- Swinject (I use this for dependencies injection. It is useful for de-coupling dependencies)
- RxDataSources (I use this instead of the traditional delegate & datasource from collectionView and tableView)

Common Design Pattern I use:
- Coordinator (Top level navigation to handle navigation throughout the app)
- Repository (to provide data abstraction)
- MVVM (to handle data request from user interaction so that we don't clutter the ViewController)

High Level App Design

![alt text](https://i.ibb.co/RcRsGPZ/Flowchart.png)
