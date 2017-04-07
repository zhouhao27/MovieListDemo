# Movie List

A demo application to show movie list. Implemented by using MVP architecture.

## API

[List](http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877d9080ccb1604c91&primary_release_date.lte=2016-12-31&sort_by=release_date.desc&page=1)

[Details](http://api.themoviedb.org/3/movie/328111?api_key=328c283cd27bd1877d9080ccb1604c91)

[Image path](http://image.tmdb.org/t/p/w128//mfrzt7IDhmS30XtnmqiBTkMTFwC.jpg)

## Develop Environment

- Mac OSX 10.12.4
- Xcode 8.3
- iOS 9.0 and above
- Swift 3

In order to run the app in real device, need to select correct Team in **General** tab for the **MovieList** target.

## Installation

> git clone  
> cd MovieListDemo  
> pod install  

## Dependency

- PromiseKit

Can also consider to use RxSwift, ReactiveCocoa for functional programming.

- Alamofire

Library for networking in Swift. Able to implement the networking function in URLSession. DispatchQueue.main.async is not needed because Response handlers by default are executed on the main dispatch queue.

- AlamofireObjectMapper

To map the json object to Swift object. We can also use responseJson of Alamofire to get Dictionary data to create the Swift object. And we can also use JSONSerialization to parse the json data if we're using URLSession to get data.

- AlamofireImage

To show an image asynchronously. Because it's all handled by AlamofireImage so that I don't need to take of thread issue by myself here.

## Unit Testing

- Presenter

I'm using MVP instead of MVC so that most business logic are moved into Presenter. Presenter is the first thing I need to test. I can pass the Mock service as injected dependency to presenter to make the testing easier.

- Model

Test the Json data parse function (actually this is automatically done by ObjectMapper).
