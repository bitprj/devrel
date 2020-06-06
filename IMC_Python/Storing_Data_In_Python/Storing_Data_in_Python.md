# Storing Data in Python

When we think about Python, we can think of tons of applications for our potential code; we can create a desktop application, build websites, analyze data, and much more - the possibilities are endless. However, in order to do anything of that caliber with this programming language, you must start from the bottom and master the basics. One essential building block of Python is learning to store pieces of data that will be useful to our program and, more importantly, deciding how we will store this data. Lists, sets, and dictionaries are the most common ways to store data and, in this blog post, I will show you how you can use them, why you would want to use them, and what features each data structure has to offer. 

The first data structure I will talk about is probably the most commonly used in Python - lists. With this method, you can store variables of the same type in a specific order and access and modify them using an index. 

## Lists

**Initialization**

*list= [element1, element2, …, elementn]*

When you initialize a list, you must give it a name. If you choose to add elements to the list at this time (optional), they must be separated by commas and wrapped in square brackets, [].

Ex: Take a list of integers called **numbers**. Let’s suppose you want it to contain numbers 0-4. This is how we would initialize the list: 

<center>numbers = [0, 1, 2, 3, 4]</center>

If we wanted **numbers** initialized to be empty, its declaration would look like this:

<center>numbers = []</center>

**Accessing an Element**

*list[index]*

Quite possibly the most important thing to keep in mind when using a Python list is how indices are numbered. When we count in programming, we always start at 0, not 1. So, when we keep track of the index of a list, the first index is always numbered ‘0’. This means that if your list has six elements, the last element is stored at index ‘5’. 

With that being said, we can access an element using square brackets, [], and its index. 

Ex: If we want to access the fourth element (index 3) and save it to a variable **x**, we would call:

<center>x = numbers[3]</center>

“x =” assigns the value of x and “numbers[3]” returns the item at the third index of the list. If you are new to coding, you should keep in mind that **“=” does not indicate an equivalence relation, it means that you are assigning a value to the variable on the left.** Looking at the example above, we can say that *x is numbers[3]* or *x is 3*, BUT, we CANNOT say that *numbers[3] = x*. We are not modifying the variable on the right at all. So, in this case, although we change what ‘x’ means, the value of numbers[3] remains the same.

**Modifying an Element**

*list[index] = new element*

Just as we can access an element and assign its value to a variable (like we did above), we can also modify the value of an element given its index.

Ex: If we wanted to change the third value of the list (index 2) to 10, we would call the following:

<center>numbers[2] = 10</center>

The “numbers[2]” accesses the list at index 2 using the brackets, []. By putting an equals sign, “=”, to the right of it, we are indicating that we want to reassign numbers[2]’s value to the value on the right of the “=” – in this instance, it is 10.

**Adding an Element**

*append(new_element)* 

*insert(new_element, index)*

Say we want to add the number ‘5’ to our **numbers** list. If we had a specific position in mind, we would need to find that position’s index and call insert() using ‘5’ and the index as parameters.

Ex: If we wanted to place 5 at index 2, we would use the following statement:

<center> numbers.insert(5, 2)</center>

Now, the contents of numbers is: **[0, 1, 2, 3, 4, 5]**. However, if we wanted to tack ‘5’ onto the end of the list, we would simply use the append() function and pass 5 as a parameter.

<center>numbers.append(5)</center>

Here, the contents of numbers is: **[0, 1, 2, 3, 4, 5]**

The append() function is very user-friendly because it lets you append list onto one another.

<center>letters = [‘a’, ‘b’, ‘c’]</center>

<center>numbers.append(letters)</center>

Now the contents of numbers is: **[0, 1, 2, 3, 4, ‘a’, ‘b’, ‘c]**

Because of how Python is designed, if we insert an element at an index, the list automatically expands and shifts all the elements to the right of the given index one position to the right.

**Removing an Element**

*pop(index)* 

*remove(index)*

There are two ways in which we can remove an element - according to its index or according to its value. In the first case, we use the pop() function on the list to remove an element at a given index. 

Ex: If we wanted to remove the fifth element (index 4) of our original list, we would call:

<center>numbers.pop(4)</center>

Now the contents of numbers is: **[0, 1, 2, 3]**

However, if we wanted to remove an element without using its index, then we would use remove() and pass the element as the parameter. 

To better show this technique, let’s use a list of strings as an example:

Let’s define a list called **fruits** where fruits = **[“apple”, “strawberry”, “orange”, “banana”].**

If we wanted to remove “orange” from the list, we would call 

<center>fruits.remove(“orange”)</center>

Which would result in the list: **[“apple”, “strawberry”, “banana”]**

The next method for storing data that we will go over is sets. Sets allow you to store variables of the same type in a group – however, a set is unordered and each element must be unique.

 ## Sets

**Initialization**

*set = {element1, element2, …, elementn}*

Similar to a list, you can initialize a set to be empty, or you can add elements. However, with a set, we use curly brackets, {}, instead of square brackets, [], to initialize its values.

<center>Ex: fruit = {“apple”, “strawberry”, “banana”}</center>

<center>fruit = {}</center>

**Accessing an Element**

Since sets are unordered and do not have indices, you cannot access a specific item in it as you would in a list. 

 **Modifying an Element**

Unfortunately, once an item is added to a set, it cannot be modified, only removed. This is because there is no way to access the element to modify it since there are no indices.

**Adding an Element**

*set.add(new_element)*

*set.update(new_element1, new_element2, …, new_elementn)*

Sets have an add() function that takes a variable of the same type as the rest of the set and appends it to the set. Since sets are unordered, there is no need to worry about where you should place it like you would when adding an item to a list.

<center>Ex: fruits.add(“orange”)</center>

Now the contents of fruits is: **{“apple”, “strawberry”, “banana”, “orange”}**

You can also append multiple items at once using update() by passing several elements.

<center>Ex:fruits.add([“orange”, “pineapple”, “mango”])</center>

Now the contents of fruits is: **{“apple”, “strawberry”, “banana”, “orange”, “pineapple”, “mango”}** 

**Removing an Element**

*set.remove(element)*

*set.discard(element)*

There are two functions that you may use to remove an element from a set. Both require that you pass the element you wish to remove since there is no other way to reference it. The two methods do the same exact thing, *except*, remove() will raise an error if the element you are trying to remove is not in the set while discard() will not.

If **fruits** = {“apple”, “strawberry”, “banana”, “orange”}, then

<center>remove(“strawberry”)</center>

<center>and</center>

<center>discard(“strawberry”)</center>

will both give you fruits = **{“apple”, banana”, “orange”}**

Finally, let’s address dictionaries. This data structure functions using a key-value pair which allows you to find an element given a key, such as a character or a string, rather than using a typical numerical index. Though this type of array is unordered, it is still addressable since you have a way of finding an element using its unique key.

## Dictionaries

**Initialization**

*dictionary = {key1:value1, key2:value2}*

Because of the way dictionaries are designed, you can use different data types as keys and values. We use curly brackets, {}, to define the dictionary, a colon, ‘:’, to assign a key to a value, and a comma, ‘,’, to separate entries.

Ex: If we wanted to create a dictionary about a person with attributes “name”, “age”, and “college”, we could use the attribute names as keys and the personal attributes as values.

my_dictionary = {“name” : “Danielle”,

​            					“age” : 20,

​              				  “college” : “Binghamton University”

​              				}

Though you do not have to insert a new line and tab for each input, it may make initializing your dictionary easier to read. 

**Accessing an Element**

*dictionary[key]*

To get the value stored at a key, you use square brackets, [], just as you would with a list - except, this time you pass a key as the parameter rather than an index.

Ex: my_dictionary[“name”] would return **“Danielle”**

**Modifying an Element**

*dictionary[key] = new_value*

Similar to the way we update an element of a list, you would also use square brackets, [], and an equals sign, =, to update the value of a dictionary at a certain key. It should be noted that you can only update the value in a key-value pair – if you would like to update the key, you must create a new key-value pair and delete the old one.

<center>my_dictionary[“age”] = 21</center>

Now, my_dictionary would look like this:

<center>{“name”: “Danielle”, “age”: 21, “college”: “Binghamton University”}</center>

**Adding an Element**

*dictionary[new_key] = new_value*

The process of adding a new key-value pair to a dictionary is the same as that of updating an existing pair. The only difference is that the key in the square brackets is not expected to be in the dictionary.  **This is where you need to keep in mind that keys are unique.**  If you mistakenly pass a key that is already in the dictionary when you mean to pass a new one, no error will be thrown and the existing key’s value will be updated.

Ex: If you wanted to add a phone number to my_dictionary, the statement would look like this:

<center>my_dictionary[“phone number”] = “(888)123-4567”</center>

Now, my_dictionary’s contents would be: **{“name”: “Danielle”, “age”: 21, “college”: “Binghamton University”, “phone number” = “(888)123-4567”}**

 **Removing an Element**

*dictionary.pop(key)*

If you would like to delete a specific key-value pair, you would use the pop() function and pass the key as the parameter. 

Ex: If you wanted to remove the “college” key, you would call the following:

<center>my_dictionary.pop(“college”)</center>

Now, the dictionary would look like this:

<center>{name: Danielle, age: 21, phone number = (888)123-4567}</center>

## When to Use Which

Now that we have laid out the basic functions of lists, sets, and dictionaries, we can differentiate the three and list out some scenarios in which you would use each. Let’s start by finding what they all have in common and what makes them unique.

To the right is a Venn diagram that shows the differences and similarities between lists, sets, and dictionaries. As you can see, the only similarity they all share in functionality is storing data. This graph will help you narrow down your choice simply based on whether you need something indexable, modifiable, or if you need your variables to be unique.

Now that we know what makes each data structure unique, let’s get into their features that will further assist you in your choice.

![image-20200606192735370](C:\Users\danie\AppData\Roaming\Typora\typora-user-images\image-20200606192735370.png)

**Lists**

Because a list is ordered, it features functions such as *sort()*, which re-orders your list either alphanumerically or according to a given function, and *reverse()* which puts your list in the order opposite to what it is in now. It also has a method called *count()* which returns the amount of times a passed variable is found in the list. These features make lists useful for a dataset that you would want to arrange in a certain manner, especially if your data features duplicate values.

**Sets**

Though sets seem difficult to work with as they aren’t indexable, they can be quite useful. Python sets are similar to mathematical sets – they are unordered and have unique elements. Just as you can find the union and intersection of sets in math, you can also find the union and intersection of Python sets using the *union()* function and *intersection()* function respectively. Both methods can take several sets as parameters and return the resulting set. These two functions only scratch the surface of what Python sets are capable of – you can determine if a set is disjoint from another, if one set is a subset of another, and so much more. Therefore, this option useful if you plan to perform such operations on your datasets.

**Dictionaries**

Dictionaries give you the best of both worlds in sets and lists. They are indexable and keep your information organized with the key-value pair design. Dictionaries can also be nested so that the value that a key maps to is a dictionary rather than a number or a string. This data structure is best if you want to store several pieces of information about one item. A good example would be simulating a phone book or an address book. You could set each key to be a contact’s name and each value as their phone number or address. This problem could also be approached using a nested dictionary where each nested dictionary represents a contact with several key-value pairs to store more information on each of them.

Overall, none of these data structures are better than another – each has their own qualities and capabilities that make them useful for a certain purpose. Hopefully by this point you have figured out which method is best for storing the information that you will be using in your Python program. Otherwise, I advise you pick one out and search for where you may run into a problem. To learn more about Python, visit bitproject.org or e-mail me at danzelo1@binghamton.edu.

 