# Introduction
GraphQL in short is a query language for your API, and a server-side runtime for executing queries by using a type system you define for your data. 
A GraphQL service is created by defining types and fields on those types, then providing functions for each field on each type. For example, a GraphQL service that tells us who the logged in user is (me) as well as that user's name might look something like this: 
```
type Query {
  me: User
}

type User {
  id: ID
  name: String
}
```
Along with functions for each field on each type:
```
function Query_me(request) {
  return request.auth.user;
}

function User_name(user) {
  return user.getName();
}
```
Now, for many of us, as beginners, may have the same question, "How does it compare with REST"?

As you've probably known, the REST has been popular as a industrial standard over many years. Despite of its great functionality, REST APIs have shown to be too inflexible to keep up with the rapidly changing requirements of the clients that access them.

GraphQL was developed to cope with the need for more flexibility and efficiency! It solves many of the shortcomings and inefficiencies that developers experience when interacting with REST APIs.

However, in the beginning of learning GraphQL, many concepts and notions may seem to be confusing and frustrating to learn. In GraphQL, with application data graph, we can represent the queries by graphs to show the relations between the data. Such a representation can help developers to construct what they tend to be in a more natural and logical way. 

# The Application Data Graph
A lot of data in modern applications can be represented using a graph of nodes and edges, with nodes representing objects and the edges representing relationships between these objects.

For instance, say we’re building a cataloging system for libraries. To keep it simple, our catalog has a bunch of books and authors and each of these books has at least one author. The authors also have coauthors with whom the author has written at least one book.

By GraphQL, we can even extract trees from the app data graph. To do so, we can adapt the concepts of binary tree, which a data point starts with the root of the tree, and we can present its subtree and nodes with edges.

# How to model a graph 
In GraphQL, we use a "schema" to present the business domains, which it is composed of different types with entities. Mainly, a schema can be composed with different fields, so each field is pointing to one and another. In the graph theory, they are connected by edges.

```
type User {
    lastname: String
    firstname: String
    email: String
    settings: UserSettings
}
```

Corresponding to the graph aside, the fields, lastname, firstname and email are pointing to the type String, and they are scalar, which means that they don't have any subfields and they can be seen as the leaves of a query tree. The relationships between a type and its fields are unidirectional edges and are the building block of the schema. This makes the GraphQL Schema an acyclic directed graph to which they don't have circles and they are one way around. Hence, the process or behavoir of visiting the nodes in a tree is called tree traversal

# Traversing the Graph with GraphQL
Let’s take a look at an example of a GraphQL query and how it “extracts a tree” out of an application graph. Here’s a query we could run against the data graph we were just talking about:
```
query {
  book(isbn: "9780674430006") {
    title 
    authors {
      name
    }
  }
}
```
Once the server resolves the query, it returns this query result:
```
{
  book: {
    title: “Capital in the Twenty First Century”,
    authors: [
      { name: ‘Thomas Piketty’ },
      { name: ‘Arthur Goldhammer’ },
    ]
  }
}
```
As a result, a path of the tree is a GraphQL query in that graph, and a query is a projection of a certain subset of the GraphQL schema to a tree. On the backend side, every field of a type maps to a resolver function that returns its value when queried.

```
title:() => (database.getTitle())
authors:() => (database.getAuthors())
```
We obtain the query result by running such resolver functions to extract and pull out the result from fields of the schema.

# Schema Parsing
The GraphQl server parses the schema document at execution time. Types are extracted and stored as plain Javascript Objects with references to their fields, and to the resolver functions in a dictionary called typeMap. When a field must be resolved the execution algorithm will look for it in the dictionary and use both the resolver function and the references to its subtypes to build its value.

```
// Simplified structure of the type map
let typeMap = {
  rootType: {
    fields: { // array with the fields of the root ype
      user: {
        type: {
          fields: {
            title: {...},
            authors: {...},
            date: {...},
          }
        },
        resolve: () => ({})  // points to a resolve function for the type
      },
      date: {
        type: {
          fields: {
            year: {...},
            month: {...},
            day: {...},
          }
        },
        resolve: () => ({})  // points to a resolve function for the type
      }
    }
  },
};
```

As every type contains a reference to its resolver function, one can resolve the whole schema by repeating three steps:

1. Retrieve a type from the typeMap dictionary
2. Run its resolver function
3. Repeat the same on the fields of this type

# Query Parsing
The GraphQL server parses every query from a string to an Abstract Syntax Tree(AST). An AST is a tree representation of the syntax of source code from a particular language. Every node in the tree represents a statement in the query, including its type, arguments, and position.

```
query getDates($isbn: ID) {
    book(id: $isbn) {
        title
        dates{
            year
            month
            day
        }
    }
}
```
The AST is a common abstraction for compilers and is used to validate syntax correctness in a process called semantic analysis. Again, because of its tree-like structure, the AST can be processed and interpreted by recursive functions. This process is behind the query validation feature that GraphQL editors usually offer.

# Query Execution
Once a query operation has been converted to an AST and its structure validated, we can use the tree properties to execute the query. The core of the execution algorithm is a recursive function that runs on every node of the query tree following a depth-first-search order.

// will have images inserted here

The traversal ensures that fields are executed and resolved in a stable and consistent order. Following the first order traversal the field execution function will be called on each field in the following sequence:
[book, title, dates, year, month, day]

The executeField function contains the magic behind the field value resolution and is well described in the GraphQL specifications. The function arguments are the name of the type is being run on, the definition of that type from the typeMap dictionary and the resolver function. First, the algorithm executes the resolver function and stores the return. Next, it completes the field value depending on its type. If the field type is a scalar, its value is simply "coerced" using a serialization function and directly returned.

Conclusion
Graphs is what makes GraphQL fascinating to learn and use. It gives you the natural logic when we think about the relations of the data and the querys.
