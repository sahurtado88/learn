def count_char_frequency(string):
    frequency={}
    for char in string:
        if char in frequency:
            frequency[char] += 1
        else:
            frequency[char]=1
    return frequency

input_string= "boca boca compadre la concha de tu madre"
result = count_char_frequency(input_string)
print("character frequencies:", result)

from collections import Counter
input_string= "boca boca compadre la concha de tu madre"
result = Counter(input_string)
print("character frequencies using counter:", result)

# frecuencia por palabras

def count_word_frequency(string):
    words = string.split()
    frequency = {}

    for word in words:
        if word in frequency:
            frequency[word] += 1
        else:
            frequency[word]=1
    return frequency

input_string= "boca boca compadre la concha de tu madre"
result = count_word_frequency(input_string)
print("Word frequencies:", result)