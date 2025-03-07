AI is a vast and rapidly evolving field with exciting possibilities. The expansion and evolution of this complex field involve various systems and concepts. These include machine learning (ML), deep learning (DL), natural language processing (NLP), generative AI (GenAI), and language models (LM). They are all related concepts in computer science but have different meanings and applications. Here is a brief explanation of how they are connected:

# Artificial Intelligence (AI)

Artificial intelligence is a field of computer science and an umbrella term for machines that can simulate human intelligence. AI focuses on creating intelligent systems that can perform tasks that usually require human intelligence, such as speech recognition, natural language processing, text generation, and decision-making.

# Machine Learning (ML)

Machine learning is a branch of AI that focuses on developing algorithms and statistical models that allow computer systems to learn from experience and improve their skills without explicitly programming instructions. ML enables computers to analyze data, detect patterns within data, and make predictions or decisions.

# Deep Learning (DL)

Deep learning is a subset of ML that uses multi-layered artificial neural networks to deliver state-of-the-art accuracy in object detection, speech recognition, and language translation tasks. DL systems process and analyze various data, such as images, sound, and text, in a way similar to the human brain. 

# Natural Language Processing (NLP)

Natural language processing is a subfield of AI that focuses on the interaction between computers and humans through natural language. It can combine ML models and techniques with specific language algorithms to decode human language. NLP enables computer systems to understand, interpret, generate, and manipulate natural language texts and speech. At a high level, NLP takes human language as an input, processes it, and converts it into the language of numbers that the computer will understand, and vice versa.

# Generative AI (GenAI)

Generative AI (GenAI) is a branch of artificial intelligence that utilizes Machine Learning (ML), specifically deep learning techniques implemented through powerful neural networks, to analyze massive datasets and identify patterns. NLP helps it interpret human language. By leveraging these patterns, GenAI can then produce entirely new and original content, like realistic images, music, text, video, or other creative formats.

# Language Model (LM)

Language models are a type of GenAI. They consist of a neural network with many parameters trained on large quantities of data to understand text. LMs process natural language inputs and predict the next word based on what they have already seen. LMs can also generate new texts based on a given prompt or context.

# Types of Language Models

anguage models (LMs) are sophisticated artificial intelligence systems meticulously trained on extensive textual datasets to comprehend and produce human language. By employing NLP techniques, these models can predict text sequences, and they play a crucial role in various applications, including chatbots and content generation.

Based on the size and complexity, you can distinguish two main types of language models:

## LLM

Large language models (LLMs), the advanced version of LMs, are trained on larger datasets and use advanced techniques such as deep learning and transformers to analyze complex relationships between words.


Examples:

GPT-4 by OpenAI
Gemini Flash v1.5 by Google
Claude v3 Opus by Anthropic
LLMs are computationally intensive. Hosting them locally poses significant challenges due to the high resource needs. This is where cloud service providers (CSPs) come in, offering scaled-up infrastructure capable of fulfilling the computationally heavy demands of LLM. You learn more about CSPs later in the course.

## SML

Small language models (SLMs) are compact versions of LLMs that require less training data, have simpler architectures, and are quicker to develop. They are suitable for specific tasks and domains, offering focused expertise, and are applicable for devices with limited processing power.

Examples:

Gemma Models by Google
Phi-2 by Microsoft
7B by Mistral
Orca 2 by Microsoft
SLMs are intended to use fewer resources. They can be hosted locally on devices with minimal processing capability or on modest server infrastructures. They were designed to be more accessible and practical for specific tasks or domains with little computing complexity.

You’ve just explored the world of small and large language models. It’s time to meet a specific LLM group making big waves—generative pre-trained transformer (GPT) models. They became game changers and revolutionized the entire industry because they:

Use transformer architecture;
Are pre-trained on massive volumes of text data.
It allows them to understand complicated language patterns, generate new text creatively, translate languages, and write basic code.

OpenAI developed the first significant GPT model capable of advanced language processing and built a popular tool based on it—ChatGPT.

# Awareness of Pre-trained Transformers' Specifics

Generative pre-trained transformers (GPT) are trained on specific datasets and do not learn or evolve during user interactions.
Their responses are based solely on their initial training data.
They operate under a "knowledge cutoff," meaning they may not be aware of events or trends after their training period and may exhibit biases based on their training data.
Please use these models responsibly, acknowledging these specifics.

# Tokens

Have you ever wondered how LLMs understand your prompts? LLMs break down the prompts into tiny building blocks called tokens.

Token is a single, distinct unit of meaning in natural language, which can be whole words, parts of words, or even punctuation. It is the smallest segment of a text that still makes sense. In Generative AI, tokens are bits of data that an AI model interprets, processes, and generates.

# TOkenization

The process of breaking down text data into tokens following certain predetermined rules is called tokenization. Since it directly relates to decoding human language, it heavily relies on NLP algorithms. The primary goal of tokenization is to make text data compatible for the AI model to comprehend, learn from, and consequently, use to generate human-like speech.

The tokenization process typically involves several steps, such as identifying word boundaries, handling punctuation, dealing with special characters, and addressing case sensitivity. Different tokenization techniques may be employed depending on the specific requirements of the task or the characteristics of the data. These techniques involve breaking down the text into various units, including:

Individual words (word tokens)
Parts of words (subword tokens)
Machine-readable bytes (byte-level tokens)
Individual characters, including letters, digits, punctuation marks, and special characters (character tokens)
Sentences or paragraphs (sentence or paragraph tokens)
Other types
Each of these techniques has its own strengths and limitations. For example, character tokens are useful when working with languages that do not have clear word boundaries or when handling out-of-vocabulary words. On the other hand, these small tokens can lead to longer text strings and increased computational load and expenses for large datasets.

The sentence or paragraph tokens are often used in tasks like text summarization or document classification, where understanding the broader context is crucial. However, large tokens like full sentences might miss subtle variations in the training or input data that can result in incorrect responses or hallucinations.

The most universal and widely used tokenization technique is word tokenization, where each token corresponds to a single word. However, challenges persist with this approach too, such as handling homonyms, idioms, misspellings, nonstandard text, out-of-vocabulary words, and other context-dependent parts.

Thus, tokens provide a powerful way for LLMs to process language. At the same time, there are several token features that are worth considering when working with LLMs.

IMG
Maximum Input Length: LLMs can only process a certain number of tokens in a single request. This limit is crucial and includes both the prompt and the response. It varies depending on the specific LLM, so checking the documentation beforehand is essential. Exceeding this limit can lead to incomplete or nonsensical responses.
Optimizing Сosts: Most LLMs charge based on the number of tokens used. Keeping your prompts concise helps with cost efficiency. This ensures clear communication while minimizing unnecessary processing for the LLM.

# How LLMs Work

LLMs learn patterns and relationships between words and phrases during the pre-trained process. They learn statistical patterns, grammar, and semantics of human language using massive amounts of text data from the Internet and books. This allows them to collect a vast knowledge base and predict the next word given the context of the preceding words using mathematical calculations and probability.

Look at this example. Imagine you're using LLM trained on a dataset heavily influenced by online forums. A prominent topic in these forums could be the flat-earth theory. Due to this bias in the data, the LLM might predict the next word after "The Earth is..." to be "flat" with a surprisingly high probability, say 40%.

While "round" (the scientifically accepted answer) might still be a strong contender at 35%, the prevalence of flat-earth discussions in the training data would make "flat" a significant option for the LLM's prediction.

The LLM leverages these probabilities to generate coherent and contextually appropriate text based on the data it was trained on. This probability tree is also the reason why LLMs can exhibit biases. Probabilities are established during the training phase and heavily rely on the dataset used to train the model.

But how exactly do LLMs process your input? What changes happen with input data during output generation? The answer hides in the LLM's architecture.

# Transformer Architecture
Before the transformers, LLMs processed data in a sequential manner, which could miss dependencies throughout long text sequences. Transformers revolutionized this field. They process data in parallel, managing long-term dependencies inside the text. Due to the self-attention mechanism, transformer architecture allows for a more context-aware interpretation of the language. It speeds up training, improves model performance, and facilitates better scalability as data volume increases.

The structure of transformers typically includes an encoder and a decoder, where the encoder is responsible for understanding context and the decoder for generating output. Each of these components consists of multiple layers of neural networks. The number and size of these layers vary based on the model.

LLMs operate by converting textual input into numerical data because their inner computations are based on mathematical functions. Here is a simplified explanation of how transformers process your input and produce output.

## OUTPUT

Output

Since the tokens are generated one at a time, the process of detokenization is also sequential.

Based on the model's vocabulary, each token ID is mapped to a specific token. Then tokens are converted into the text output.

Example:

Token IDs: [109, 110, 111, 112, 113, 114, 104, 115, 116, 117, 104, 105, 118, 104, 108, 107]

Tokens: ["That", "is", "an", "interesting", "reversal", "of", "the", "usual", "scenario", "where", "the", "dog", "chases", "the", "cat", "!"]

Output: That is an interesting reversal of the usual scenario where the dog chases the cat!

## Decoder

Similar to the encoder, the decoder is constructed of multiple layers of neural networks. These layers also incorporate positional encoding and self-attention mechanisms. The processes in the decoder are reversive to those in the encoder—from enriched embeddings to token IDs.

Based on the encoded inputs and previously generated tokens, the decoder assigns probabilities to all possible words in its vocabulary (probability distribution) and generates a response, one token at a time. Typically, the word with the highest probability is selected as the next token in the response. Alternatively, the next token can be randomly sampled from the predicted probabilities. This adds some variability and creativity to the model's output.

Example:

Token IDs: [109, 110, 111, 112, 113, 114, 104, 115, 116, 117, 104, 105, 118, 104, 108, 107]

The output of the decoder is the set of token IDs.

## Self-Attention Mechanism

Self-attention connects enriched embeddings as they progress through the model's levels, clarifying the context and mutual dependencies. The self-attention mechanism assists the model in calculating attention scores for the entire input sequence. It indicates how much focus should be placed on different words in the sentence when trying to understand the meaning of a specific word. Based on these attention scores, the transformer can adjust the embeddings during processing, refining their meaning.

Example:

The CAT chased the dog.

Token	Token ID	Updated Embedding
"The"	101	[0.20, 0.10, 0.40]
"CAT"	102	[0.45, 0.49, 0.45]
"chased"	103	[0.52, 0.24, 0.72]
"the"	104	[0.23, 0.26, 0.43]
"dog"	105	[0.64, 0.38, 0.44]
"."	106	[0.15, 0.50, 0.35]
Based on the action-related token "chased," which has high attention scores, the model shifted the meaning of the "CAT" closer to the "animal" context instead of different acronyms. The process of refining the meaning is iterative and can be repeated until the full context-awarness.

## Positional Encoding

The model processes embeddings using many layers of neural networks. An essential part of this processing is positional encoding, where special vectors (positional encodings) are added directly to the embeddings. They have the same dimension as embeddings and help to preserve sequence information. Thus, even if the same word appears in different positions, its resulting vector representation will be different.

This is crucial because swapping words, as in "The CAT chased the dog" and "The dog chased the CAT" sentences, changes the meaning entirely.

So, by adding positional values, the model can correctly interpret the order and meaning of each word and word sequence.

Example:

Token	Token ID	Initial Embedding	Positional Encoding	Combined Vector
"The"	101	[0.2, 0.1, 0.4]	[0.00, 0.00, 0.00]	[0.20, 0.10, 0.40]
"CAT"	102	[0.3, 0.6, 0.1]	[0.01, 0.02, 0.01]	[0.31, 0.62, 0.11]
"chased"	103	[0.5, 0.2, 0.7]	[0.02, 0.04, 0.02]	[0.52, 0.24, 0.72]
"the"	104	[0.2, 0.2, 0.4]	[0.03, 0.06, 0.03]	[0.23, 0.26, 0.43]
"dog"	105	[0.6, 0.3, 0.4]	[0.04, 0.08, 0.04]	[0.64, 0.38, 0.44]
"."	106	[0.1, 0.4, 0.3]	[0.05, 0.10, 0.05]	[0.15, 0.50, 0.35]

## Embedding

After IDs are assigned to tokens, they need to be converted into a set of numbers (vectors) that define each token's initial semantic meaning. This process employs neural networks and is called embedding. The result of the embedding process is a set of vectors called embeddings. They are used in the transformer model for further processing.

Example:

"The" (ID: 101): [0.2, 0.1, 0.4]

"CAT" (ID: 102): [0.3, 0.6, 0.1]

"chased" (ID: 103): [0.5, 0.2, 0.7]

"the" (ID: 104): [0.2, 0.2, 0.4]

"dog" (ID: 105): [0.6, 0.3, 0.4]

"." (ID: 106): [0.1, 0.4, 0.3]

Note that it's a simplified version. The true vectors are much larger and have much more dimensions (up to 760+).

## Input

You provide an input, also called a prompt. The prompt is then tokenized, converting the text into smaller units (tokens). Each token is assigned a numeric ID based on the model's vocabulary. This vocabulary is a list where each unique token from the training dataset is associated with a unique index.

Example:

Prompt: "The CAT chased the dog."

Tokens: ["The", "CAT", "chased", "the", "dog", "."]

Token IDs: [101, 102, 103, 104, 105, 106]

Now you know how the output generation occurs. While the output accuracy heavily depends on the quality of the training dataset, the clarity of your input is also valuable. Next, you will explore the role of prompts and how they influence the results.

# Cognitive Constraints and Interaction Challenges

One of the broadest groups of LLMs' limitations is Cognitive Constraints and Interaction Challenges. The good news is that these are among the most manageable ones for users when interacting with LLMs. This group includes five categories: non-human cognition, hallucinations, biased outputs, lack of knowledge, and stochastic nature.

Now, you will explore each category.


Non-Human Cognition
Despite their learning ability, LLMs have no conscious understanding or thought process. They don't process and interpret information the way humans do. Humans comprehend and synthesize noises, visuals, and concepts, while LLMs map inputs to outputs based solely on learned patterns.

They might impersonate someone during communication if the training data allows it. However, this will not be a personal experience or cognition but just an imitation based on the available knowledge base.

This is an example of an LLM-based chatbot. The LLM acts as a customer support manager and replies in a helpful manner as if understanding the customer's needs. However, it's simply mimicking trained customer service responses without actual comprehension of the situation.

The inability of LLMs to reason and their sensitivity to the semantics of the input (such as using synonyms) may lead to inconsistencies, logical gaps, or repetitions, particularly over long conversations.

Hallucinations
It's essential to remember that AI can trick users with perceptions that seem real but are made up. Although LLMs are usually correct and can generate grammatically correct and semantically meaningful text, their predictions are not always accurate. This phenomenon is known as hallucination.



Hallucinations
Refer to generating content that appears semantically or syntactically plausible but is factually incorrect or unrelated to the provided context.


Hallucinations can happen for a variety of reasons, including:

Inherent features of LLMs
Prompting weaknesses, such as inadequate context or poor wording

Biased Outputs
Due to the nature of its training, LLM may sometimes reproduce or magnify the biases present in the training data it was modeled on.

The model assumes that a nurse is female. This is a biased output because it perpetuates the stereotype that nursing is a female profession, which is not accurate. Both men and women work as nurses.

Lack of Knowledge
When asked about recent events or technologies developed after the knowledge cut-off date, LLMs may plausibly and confidently answer the question. In that case, it is a hallucination. However, LLMs can indicate in their response the date when their knowledge base was frozen.

The model provided the response clearly indicating that the information is relevant as of 2021.

Stochastic Nature
The outputs of LLMs can vary slightly each time, even with the same input. You can write the identical prompts in separate dialogues, or regenerate the response. In each case, you will receive the outputs with different wording and style, even if the main sense remains the same.

In this case, LLM provides slightly different outputs that convey equivalent meanings.

# How to Mitigate?
As a user of LLMs, you typically have no control over the training dataset or the chosen training approaches. This is the responsibility of the development team. However, you can still mitigate and overcome some of the cognitive constraints and interaction challenges by employing the following strategies:

Prompt Engineering: This involves structuring and adjusting your prompts in a way to obtain more accurate and relevant responses from the LLM.
Retrieval-Augmented Generation (RAG): Issues with outdated or incomplete knowledge can be partially resolved using the RAG approach, which involves external data sources in the response generation process. It's important to note that not all LLMs support this feature.
Feedback: Many LLM platforms allow users to tag or report unsatisfactory responses. Developers can use this feedback to fine-tune the models, resulting in improved accuracy and reduced errors over time.
Cross-Verification: Always cross-verify the information provided by LLMs, especially when dealing with factual data. Use reliable external sources to ensure the accuracy of the information.
Combining Models: Combine different LLMs to obtain responses. This can involve querying several models with the same prompt and comparing their answers or using one model's strengths to compensate for another's weaknesses.

# Benchmarks

An LLM benchmark is a standardized performance test used to evaluate various capabilities of AI language models.

Providing a benchmark makes it easier to compare one model against another and, ultimately, select the best one for your proposed use case.

A benchmark usually consists of a dataset, a collection of questions or tasks, and a scoring mechanism. After the benchmark’s evaluation, models are usually awarded a score from 0 to 100.

There are multiple benchmarks existing. Depending on the user case you will solve with language model help, you must choose an appropriate benchmark or a set of benchmarks.

# Choosing the Right Benchmark
The best benchmark for your needs depends on the specific language model and its intended use case. Consider these factors:

Your goals: What tasks do you need the model to perform?

Model type: Are you evaluating a general-purpose LLM or a specialized model?

Desired aspects to assess: Do you prioritize fluency, factual accuracy, or performance on a specific task?

#Retrieval-Augmented Generation (RAG)
Retrieval-augmented generation (RAG) systems enhance LLMs' inherent capabilities by pulling information that is not in the initial training dataset from external databases or documents before generating responses. This approach improves the factual accuracy and contextual relevance of outputs.



Retrieval-Augmented Generation (RAG) refers to a framework that combines information retrieval with text-generative models. It works by retrieving relevant information from a knowledge base, incorporating it into a language model's input, and generating responses based on both the original query and the retrieved data.


RAG systems always include two key components:

Retriever: This component functions like a search engine, scanning a data source to find and retrieve the most relevant documents or pieces of information that can help answer a user request. It may employ AI models designed for specific tasks (such as BERT or SBERT for generating embeddings), search methods and algorithms, plugins, vector databases, and other programming mechanisms.
Generator: This is a core LLM (such as GPT-4) that generates the final output based on the user input and the retrieved context.
Here is a simplified scheme of how the RAG system functions:

Data Source

This is where the system looks for information. The data source contains the raw data, which could be documents attached to the query, a collection of documents on a server, or internet content like Wikipedia articles.

Retriever

This phase includes four main steps:

User prompt processing and constructing the search query.
Semantic search for relevant information utilizing different algorithms.
Extracting the corresponding documents or parts of the documents.
Prioritizing (ranking) the retrieved text and potentially filtering the most useful information from it.
The retriever component might involve the conversion of the prompt into vector-based embeddings representing semantic meaning with the help of transformer-based AI models. Alternatively, it may involve algorithmic-based processes if the search step follows traditional keyword (textual) search techniques for finding exact matches.

User Prompt

This is the original text query or input provided by the user. It serves as the primary context for the LLM to understand what information is being requested.

Example: Imagine you need to analyze an internal report on employee engagement to present to organizational leaders. The prompt can be as follows: "What are the key takeaways from the latest employee engagement survey?"

Retrieved Context

Not all the information extracted from external data sources goes to the LLM input. Since an LLM that generates the final output has a limited context window size, the retrieved context should be concise, capturing the semantic nuances of the text.

This is the most relevant data retrieved in text form.

Example: "1. Employee satisfaction increased by 10% compared to last year, indicating improved morale...

2. 75% of employees feel valued and recognized for their contributions...

3. Areas for improvement include communication and career development opportunities..."

Prompt Constructor

This component is responsible for preparing the input for the main LLM. It combines:

The original user prompt (in text form)
The selected context (retrieved and filtered text)
Any additional instructions or prompt templates, such as how the retrieved information should be applied or any relevant metadata (source citations, document titles, etc.) that may help the model generate a more informed response.
Example: "User Query: What are the key takeaways from the latest employee engagement survey?

Retrieved Context:

Employee satisfaction increased by 10% compared to last year, indicating improved morale...
75% of employees feel valued and recognized for their contributions...
Areas for improvement include communication and career development opportunities...
Instructions: Using the provided context, answer the user's question. If the context doesn't contain all necessary information, use your general knowledge to provide a complete answer."

LLM

This is the main language model, such as GPT-4, responsible for generating the final response based on the constructed prompt.

Output

This is the final response to the user's query, generated by the LLM based on the original query and the retrieved context.

Example: "The key takeaways from the latest employee engagement survey show that employee satisfaction has increased by 10% compared to last year, reflecting an improvement in overall morale. Additionally, 75% of employees report feeling valued and recognized for their contributions. However, there are areas that need attention, such as enhancing communication and providing more opportunities for career development. Addressing these concerns could further bolster employee engagement."

RAG systems are complex. They typically require additional components for the retrieval part, such as retrieval plugins or other LLM plugins and external tools to manage the data sources.

Here are some benefits and disadvantages of using RAG systems:

# Adv

Extension knowledge beyond initial training data of the model
Reduction inaccuracies and "hallucinations" in generated content
Capability to incorporate company/project-specific or proprietary information in responses

# disadv

Potential delays in real-time user interactions due to the speed of the data retrieval process
Dependency on the quality and reliability of the data sources and materials
Higher computational resource requirements compared to traditional models due to the dual processing of generative and retrieval components

