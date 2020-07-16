![GraphQL](https://miro.medium.com/max/1100/1*G5SHJcfMXtofKwJmQmlB2A.jpeg)

# Navigating Schemas, Types, Fetching Requests, using Mutations & Subscriptions

Do you ever wonder how social media services like Facebook or Instagram are able to interact with the user? Whenever you click on that like button on a post that your friend posted, how is it possible that a week after the like button is still there? This is achieved through the usage of application programming interfaces, commonly known as APIs. In short, with the help of APIs, the user is able to deliver requests for information from the server which then the server sends a response back to the user. This is precisely why the like button is still present in the same post a week after -- because the database used by Facebook stores all of the information and we are able to access it through performing an action. You might think that APIs are only allowed to fetch existing data from the server, but there are various other features that are impressive in APIs including creating, updating, and deleting data. Developers choose to use the API of their preference, two of the most common APIs used being REST API and GraphQL. However, throughout this blog, I will be discussing the features and services of GraphQL as well as the reasoning behind why GraphQL is a better query language than the REST API. 

<img src="https://media.geeksforgeeks.org/wp-content/uploads/20200108170534/RestvsGraphQL.png" alt="drawing" width="1250"/>

## Why is GraphQL better than the REST API? 

What makes GraphQL so unique is that it involves a single endpoint instead of multiple endpoints. This means that when you request data from the server, the user can specify the exact data needed in the payload, the body of the query, comparable to parameters of functions when coding. This feature from GraphQL prevents overfetching as well as underfetching data that is unnecessary for the user. The REST API uses multiple endpoints when retrieving data from a server, an extremely inefficient method for fetching data. For example, if a user sends a fetch/GET request to access the names of the user's first three followers on Instagram, the user would receive unnecessary information as well as having to send three separate requests to the server. As can be inferred, this procedure from the REST API is especially ineffective and involves overfetching unnecessary information. 

## Fetching Requests

In order to fetch requests from the server, we need to download Postman, a software enabling users to test API calls. 

After fully installing Postman, 

<ol>
<li>Click on the + sign to create a new request </li>
<li> Observe from *https://api.github.com/users/vdespa* that there is a lot of data stored in the server, for the syntax of GraphQL we can specify the field that we want to obtain information from, such as the name </li>
<li> We can use the REST API which will allow us to obtain all of the data through multiple endpoints but we’ll be demonstrating usage of GraphQL which has a single endpoint, allowing us to update, add, or delete data </li>
<li> We will be using the github API from the link *https://api.github.com/graphql* and because we are using GraphQL we have to change the "request" option to the "post" option </li>
<li> After changing the options, we will see an option of "GraphQL" pop up when we direct to the tab of Body </li>
<li> Because we are using Github's API, we have to click on "authorization" and provide a Bearer Token to get access to all of Github's API features </li>
<li>Create a new API by clicking “new API” on the side and adding a schema that I will attach in the description. Adding this schema will give us access to features related to schemas and formats that we are now allowed to use </li>
<li> Going back to our query, click refresh and observe that we have a new schema that we can use </li>
<li> We can finally implement our query to obtain data that we request from the client </li>
<li> We will request data from the login name "defunkt", which we can indicate in the parameter </li>
<li> Now, we need to request data from the login name "defunkt". For this guide, we will be requesting the name, bio, and twitter username </li>
<li> Adding this altogether yields: </li>

```
{
    user(login: "defunkt") {
        name
        bio
        twitterUsername
    }
}

```

<li> Scrolling down to the bottom, we can see the data that we requested from the server output information back to the client: </li>

```
{
    user(login: "defunkt") {
        name : "Chris"
        bio: "emoji"
        twitterUsername: NULL
    }
}

```
</ol>


## Navigating Schemas & Types

<em>Schemas</em> are a collection of types and the relationship between those different types. Supporting the clients' desired actions, schemas allow the user to see what data is available as well as allowing for specific requests of data wanted to be retrieved from the server to the client side. 

GraphQL defines the schema of an API using its own syntax known as Schema Definition Language (SDL).

Here's a basic example of a schema defining a type called <code>Song</code> and <code>Artist</code>:

```
type Song {
  title: String 
  artist: Artist
}

type Artist {
  name: String
  songs: [Song]
}
```
The <code>Song</code> type has two fields: <code>title</code> and <code>artist</code> and are respectively of type <code>String</code> and <code>Artist</code>. 

The <code>Artist</code> type has two fields: <code>name</code> and <code>songs</code>and are respectively of type <code>String</code> and <code>[Song]</code>. 

## Supported Types of Schemas from GraphQL 

GraphQL schema can be categorized into different types.

In the earlier example, we displayed an object type: 

```
type Song {
  title: String 
  artist: Artist
}

type Artist {
  name: String
  songs: [Song]
}
```

Object types can include another object type or a scalar type as fields.

In this example, object types include the fields <code>artist</code> and <code>songs</code>. Scalar types include the fields <code>title</code> and <code>name</code>.

**The 5 Scalar Types in GraphQL are:**

<code>•int</code> : an integer value of 32-bit

<code>•float</code> : a floating-point value

<code>•string</code> : a character sequence

<code>•boolean</code> : <code>true</code> or <code>false</code>

<code>•id </code> : a unique human-unreadable identifier used to refetch an object 

The most common and simple types of schemas in GraphQL are object types. There are several other types of schemas covered in this blog such as <em>mutations</em> and <em>subscriptions</em> which are structured quite differently from object types.

## The Mutation Type

We've already learned how to fetch data from the server, but we need to learn a way to make changes to the data stored in the server. This is achieved through mutations. <em>Mutations</em> are classified into 3 different types:

• Creating new data

• Updating existing data

• Deleting existing data

As mentioned earlier, mutations have a unique structure that distinguishes their type with other types of schemas.

Try to understand the structure of mutations in this following example when creating a <code>Song</code> object

```
mutation CreateSong {
  addSong(title: "Hello", author: "Adele")
    title
    author {
      name
    }
}
```

<em>Mutations</em> start with the <code>mutation</code> keyword and specifies the data to be added or changed in the parameters of the root field <code>addSong</code>. After specifying the parameters, in our example they would be <code>title</code> and <code>author</code>, we can then specify the information that we want to request from the server in the payload, in our example they would be <code>title</code>, <code>author</code>, and <code>name</code>.

Our server would respond to this call with a response matching the <em>mutation's</em> syntax, like this:

```
{
  "data": {
    "addBook": {
      "title": "Fox in Socks",
      "author": {
        "name": "Dr. Seuss"
      }
    }
  }
}
```

To be clear, <em>mutations</em> are executed in its specified order. In a single request from the client, multiple <em>mutations</em> can be executed at once. 

## The Subscription Type 

The concept of the <em>subscription</em> type in GraphQL is that there is realtime connection to the server. This means that whenever changes are made to the server by a client, the host will be immediately informed about the changes made at that current time. 

Obviously this <em>subscription</em> feature is not accessible for everyone. The subscription features is only available to the clients that <em>subscribe</em> to an event. For example, when you are on Snapchat, you might subscribe to the news Snapchat channel to keep track of what is going on everyday. Subscriptions operate on a "request-response cycle", meaning that data is pushed directly from the server to the client.


The structure of <em>subscriptions</em> are similar to that of mutations. Observe from this example as the client subscribes to an event of the <code>Book</code> type.

```
subscription {
  newBook {
    title 
    author
  }
}
```

When the client subscribes to the server, there is a connection opened between them. As a new mutation is executed creating a new <code>Book</code> type, the server will send the data about the book over to the client: 

```
{
  "newBook": {
    "title": "Green Eggs and Ham",
    "author": "Dr.Seuss"
  }
}
```

## The Big Picture

GraphQL is pretty easy to understand! I think that people have the wrong perception of APIs and learning about APIs because they don't know where to start learning. At large, when you're learning a new concept, you should always start with small steps which will grow into larger steps. In this tutorial, we learned about schemas, the syntax for writing schemas, how to fetch data with the Postman software and object types, mutation types, and subscription types. In conclusion, query languages are becoming more widespread and used by software development by corporations like Facebook, Github, Pinterest, and many more, and it is a powerful tool that everyone can learn and apply themselves to APIs that are self-created or borrowed online.




