# Title: GitHub Client 
## Author: Alex Griswold 
### Dependencies: 
- Realm 
- RealmSwift
- Apollo 

### Installation Instructions
First download this repository's zip file. 

To run the project, you'll need to install a few dependencies with Carthage. 

If you don't have Carthage, you can download the pkg file at [Carthage Releases](https://github.com/Carthage/Carthage/releases).

Once installed, open your project directory in terminal and execute 

```
carthage update --platform iOS
```

To view your github's repositories, you'll need to generate a [personal access token](https://github.com/settings/tokens).

Inside AppDelegate.swift, the apollo client is declared. You'll want to replace my key with yours.  

```
let apollo: ApolloClient = {
    let configuration = URLSessionConfiguration.default
    // Add additional headers as needed
    configuration.httpAdditionalHeaders = ["Authorization": "Bearer ADD YOUR KEY HERE"]
    
    let url = URL(string: "https://api.github.com/graphql")!
    
    return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
}()
```

From there, you'll be good to go!
