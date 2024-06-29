# Sentimentalyst

My submission for the Swift Student Challenge 2023.

## About

Sentimentalyst is an iOS and iPadOS application that uses natural language processing (NLP) to let a user take diary entries, and provide insights on
their emotions for that day.

It shows a few different statistics such as *emotion per sentence*, *emotion frequency*, *sentiment per sentence*, *average sentiment* and more.

## Training a NLP Model in Swift

A script that trains a natural language processing, machine learning model in Swift. 

### Technologies:
- ```CreateML```
- [Emtions Dataset](https://www.kaggle.com/datasets/nelgiriyewithana/emotions) (anger, fear, joy, love, sadness, and other, now updated to include "surprise")

### Parsing Options

I believe these are only for if your data is formatted as a CSV file. The ```MLDataTable``` also works with JSON by default.

```swift
var parsingOptions = MLDataTable.ParsingOptions()

parsingOptions.containsHeader = true // the first line of my csv was: text,label
parsingOptions.delimiter = "," // my columns were separated by commas, but could be semi-colons, etc
parsingOptions.lineTerminator = "\n" // my rows were separated by new lines

var data = try MLDataTable(contentsOf: csv, options: parsingOptions) // using the parsing options
```

### Fixing incorrect data types

The ```MLTextClassifier``` is a multiclass classifier, and uses ```String``` for the label, rather than ```Int```. My csv used had numbers for the labels, and these were automatically interpreted as ```Int```. There may be a way to specify the type explicitly, but I created a new column and replaced my old one with it:

```swift
// using names to identify the columns
let labelColumnName = "label"
let stringLabelColumnName = "stringLabel"
let textColumnName = "text"

// setting the map of values I want each number to represent
let labelsDictionary: [Int : String] = [
    0: "sadness",
    1: "joy",
    2: "love",
    3: "anger",
    4: "fear"
]

// go through each entry in the label column, and create a new column that uses the string values
let stringLabelColumn = data[labelColumnName].map { label -> String in
    return labelsDictionary[label] ?? "unknown"
}

// remove the old column, and add the new one to our MLDataTable
data.removeColumn(named: labelColumnName)
data.addColumn(stringLabelColumn, named: stringLabelColumnName)
```

### 📊 Evaluating our model

In my code I print the training accuracy, validation accuracy and evaluation accuracy. This was so I could see how my model performs, and with my seed I got the values:

```
Training Accuracy:   99.67622571692877
Validation Accuracy: 86.00252206809584
Evaluation Accuracy: 88.04321139209428
```

so about 88% accuracy when I evaluated with an unseen test dataset (made with ```MLDataTable.randomSplit()```.

### Using the model

I then saved my model to disk using ```MLTextClassifier.write()```. This model can now be used in other Swift projects.


## Machine Learning Analysis

It uses the built-in Natural Language framework to calculate sentiment (a score of how positive or negative a sentence is), and a custom-trained
machine learning classification model to calculate the *emotion* of a sentence, from five different categories, or "unknown".

I tested and evaluated the model myself and it has about a 90%+ accuracy on unseen sentences from the dataset. However, the dataset I used
only has sentences that begin with the word "I", whereas a user could type in anything, so the real-world accuracy is likely lower.

There is a possibility to use large-language models to convert a users input into first-person sentences, to somewhat clean the input, but I didn't
investigate this as the app was only developed in a few days for a competition, and no networking APIs were allowed.

Instead, I provided a help icon with tips, that suggested users write in first-person, and hope that guides them to writing sentences like that.
