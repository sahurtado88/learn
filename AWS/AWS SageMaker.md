# Amazon Sagemaker

is a comprehensive suite of services designed to enable developers and data scientist to build, train, and deploy machine learning models quickly and efficiently

Sagemaker also includes fully managed services like SageMaker notebook instances created with the SageMaker Studio, these managed services will actually create EC2 instances or S3 storage on the backend and manages them for you

sagemaker is analogies with vertex AI or Azure AI or Azure ML

## Machine learning Workflow

- fetch
- Clean
- Prepare
- Trian model
- Evaluate model
- deploy production
- monitor/collect data/ evaluate

### Generating example data for model training

- Essential for training models to solve specific business problems
- The data type depends on the problem and the expected model inferences
- role od data scientist in data preparation
    - Spend time exploringand preprocessing data before training models
    - Preprocessing steps typically include fetching, cleaning, and transforming data
- cleaning data
     - inspect data for inconsistencies and clean to improve model training
- preparing or transforming the data
    - perform transformations to enhance model performance

### Trainig a model

- Model training encompasses training the model and evaluating its performance.
- training model
    - requieres selecting an algorithm or using a pre-trained base model
    - sage maker offers built-in algorithms and pre-trained models for various use cases

- SageMaker JumpStart provides a UI-based training solution with access to algorithms and models
- Compute resources are essential for training, ranging from a single instance to a distributed cluster of GPU instances, based on dataset size and urgency

- evaluating a model
    - post-training, evaluate the model to asses the accuracy of its interferences
    - Utilize the SageMaker Python SDK to send inference rerquests via available IDEs, facilitating model evaluation

### Deploy ythe model
- you traditionally re-engineer a model before you integrate it with your application and deploy it
- With SageMaker hosting services, you can deploy your model independently, which decouples it from your application code

We can see that AWS SageMaker considers three major categories of ML Services:

- Data
    storing, generating and cleaning
- Training
    models and tuning
- Deployment
    monitoring and management

### SageMaker Studio

- A cloud-based integrated development environment (IDE) for building, training, and deploying machine learning models
- You can use Studio notebooks to write code, train models, visualize result, and manage your machine learning projects. Studio also includes tools for debbuging, profiling and managing models

### SageMaker Notebooks

- jupyter notebooks that run in the cloud, specifically designed for mahcine learning
- With SageMaker notebooks, you can access powerful compute resources to train your models without having to manage any infraestructure

### SageMaker JumStart

- A collection of pre-built machine learning models and algorithms that you can use to get started with your mahcine learning projects quickly adn easily
- Jumpstart models are trained on high-quality data and are optimized for performance

### SageMaker model Registry

- A centralized repository for stroing, managing and deploying machine learning models
- With the model registry, you can track the lineage of your models, compare different versions and deploy them to production

### SageMaker Pipelines

- Workflow orchestration service to automate all phases of mahcine learning (ML) from data pre-processing to model monitoring
- The antive integration with multiple aws services allows you to customize the ML lifecycle based on your MLOps requeriments

### SageMaker Data Wrangler

- Allows you to simplify the process of data preparation and feature engineering, and complete each step of the data preparation workflow (including data selection, cleansing, exploration, visualization and processing at scale) form a single visual interface

### SageMaker Debugger
- provides tools to debug training jobs and resolve such problems to improve the performance of your model
- Debugger also offers tools to send alerts when training anomalies are found, take actions against the problems and identify the root cause of them by visualizing collected metrics and tensors

### SageMaker Neo
- Automatically optimizes machine learning models for inference on cloud instances and edge devices to run faster with no loss in accuracy
- Start with an ML model and choose a target hardware platform, then SageMaker Neo attempts to optimize the trained model and compile it

### SageMaker Ground Truth

- helps you build highly accurate training datasets for mahcine learning quickly
- It offers easy access to human labelers and incorporates your own or third party labeling workforces



