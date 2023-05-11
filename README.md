# Sentimentalyst

My submission for the Swift Student Challenge 2023.

## About

Sentimentalyst is an iOS and iPadOS application that uses natural language processing (NLP) to let a user take diary entries, and provide insights on
their emotions for that day.

It shows a few different statistics such as *emotion per sentence*, *emotion frequency*, *sentiment per sentence*, *average sentiment* and more.

## Machine Learning Analysis

It uses the built-in Natural Language framework to calculate sentiment (a score of how positive or negative a sentence is), and a custom-trained
machine learning classification model to calculate the *emotion* of a sentence, from five different categories, or "unknown".

I tested and evaluated the model myself and it has about a 90%+ accuracy on unseen sentences from the dataset. However, the dataset I used
only has sentences that begin with the word "I", whereas a user could type in anything, so the real-world accuracy is likely lower.

There is a possibility to use large-language models to convert a users input into first-person sentences, to somewhat clean the input, but I didn't
investigate this as the app was only developed in a few days for a competition, and no networking APIs were allowed.

Instead, I provided a help icon with tips, that suggested users write in first-person, and hope that guides them to writing sentences like that.
