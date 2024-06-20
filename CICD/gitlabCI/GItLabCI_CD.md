# Gitlab CI CD

## Artifact
- An artifact is usually the output of a build tool
- In gitlab CI, artifacts are designed to save some compiled/generated part of the build
- Artifacts can be used to pass data between stages/jobs

## Caches

- Caches are not to be used to store build results
- Cache should only be used as a temporary storage for project dependencies

## Environments in Gitlab

- Environments allow you to control de continuos delivery/deploment process
- Easily track deployments
- You will know exactly what was deployed and on which environment
- You will have a full history of your deployments

## GITLAB VS GITHUB

GitHub|	GitLab|	Meaning|
|-|-|-|
Pull request|	Merge request|	Request to integrate a branch into the master
Gist|	Snippet|	Snippet of code
Repository	|Project|	Container that contains the repository, attachments, and project-specific settings
Organization	|Group|	Level at which users are assigned to projects

GitHub|	GitLab|
|-|-|
Issues can be tracked across multiple repositories	|Issues cannot be tracked in multiple repositories
Private repositories are paid	|Private repositories are free
No free hosting on a private server	|Free hosting on a private server
Continuous integration only via third-party tools such as Travis CI, CircleCI, etc.|	Free continuous integration functionality included
No built-in deployment platform	|Software deployment via Kubernetes
Comprehensive comment tracking|	No comment tracking
No ability to export issues as a CSV file|	Ability to export and email issues as a CSV file
Personal dashboard for tracking issues and pull requests|	Analysis dashboard for planning and monitoring projects


```
stages:
  - build
  - test

build website:
  stage: build
  image: node
  script:
    - npm install
    - npm install -g gatsby-cli
    - gatsby build
  artifacts:
    paths:
      - ./public

test artifact:
  stage: test
  script:
    - grep "Gatsby" ./public/index.html
    - grep "XXXXXXXX" ./public/index.html
```

# Parallel

```
stages:
  - build
  - test

build website:
  stage: build
  image: node
  script:
    - npm install
    - npm install -g gatsby-cli
    - gatsby build
  artifacts:
    paths:
      - ./public

test artifact:
  image: alpine
  stage: test
  script:
    - grep -q "Gatsby" ./public/index.html

test website:
  image: node
  stage: test
  script:
    - npm install
    - npm install -g gatsby-cli
    - gatsby serve
    - curl "http://localhost:9000" | grep -q "Gatsby"
```

https://docs.gitlab.com/ee/ci/triggers/

# Caching dependencies

```
image: node:10

stages:
  - build
  - test
  - deploy
  - deployment tests

cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - node_modules/

build website:
  stage: build
  script:
    - echo $CI_COMMIT_SHORT_SHA
    - npm install
    - npm install -g gatsby-cli
    - gatsby build
    - sed -i "s/%%VERSION%%/$CI_COMMIT_SHORT_SHA/" ./public/index.html
  artifacts:
    paths:
      - ./public

test artifact:
  image: alpine
  stage: test
  script:
    - grep -q "Gatsby" ./public/index.html

test website:
  stage: test
  script:
    - npm install
    - npm install -g gatsby-cli
    - gatsby serve &
    - sleep 3
    - curl "http://localhost:9000" | tac | tac | grep -q "Gatsby"

deploy to surge: 
  stage: deploy
  script:
    - npm install --global surge
    - surge --project ./public --domain instazone.surge.sh

test deployment:
  image: alpine
  stage: deployment tests
  script:
    - apk add --no-cache curl
    - curl -s "https://instazone.surge.sh" | grep -q "Hi people"
    - curl -s "https://instazone.surge.sh" | grep -q "$CI_COMMIT_SHORT_SHA"
```

https://docs.gitlab.com/ee/ci/caching/#cache-vs-artifacts

# Environments

https://docs.gitlab.com/ee/ci/environments/

```
image: node:10

stages:
  - build
  - test
  - deploy staging
  - deploy production
  - production tests

cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - node_modules/

build website:
  stage: build
  script:
    - echo $CI_COMMIT_SHORT_SHA
    - npm install
    - npm install -g gatsby-cli
    - gatsby build
    - sed -i "s/%%VERSION%%/$CI_COMMIT_SHORT_SHA/" ./public/index.html
  artifacts:
    paths:
      - ./public

test artifact:
  image: alpine
  stage: test
  script:
    - grep -q "Gatsby" ./public/index.html

test website:
  stage: test
  script:
    - npm install
    - npm install -g gatsby-cli
    - gatsby serve &
    - sleep 3
    - curl "http://localhost:9000" | tac | tac | grep -q "Gatsby"

deploy staging: 
  stage: deploy staging
  environment:
    name: staging
    url: http://instazone-staging.surge.sh
  script:
    - npm install --global surge
    - surge --project ./public --domain instazone-staging.surge.sh

deploy production: 
  stage: deploy production
  environment:
    name: production
    url: http://instazone.surge.sh
  script:
    - npm install --global surge
    - surge --project ./public --domain instazone.surge.sh

production tests:
  image: alpine
  stage: production tests
  script:
    - apk add --no-cache curl
    - curl -s "https://instazone.surge.sh" | grep -q "Hi people"
    - curl -s "https://instazone.surge.sh" | grep -q "$CI_COMMIT_SHORT_SHA"
```

# Variables

```
image: node:10

stages:
  - build
  - test
  - deploy staging
  - deploy production
  - production tests

cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - node_modules/

variables:
  STAGING_DOMAIN: instazone-staging.surge.sh
  PRODUCTION_DOMAIN: instazone.surge.sh

build website:
  stage: build
  script:
    - echo $CI_COMMIT_SHORT_SHA
    - npm install
    - npm install -g gatsby-cli
    - gatsby build
    - sed -i "s/%%VERSION%%/$CI_COMMIT_SHORT_SHA/" ./public/index.html
  artifacts:
    paths:
      - ./public

test artifact:
  image: alpine
  stage: test
  script:
    - grep -q "Gatsby" ./public/index.html

test website:
  stage: test
  script:
    - npm install
    - npm install -g gatsby-cli
    - gatsby serve &
    - sleep 3
    - curl "http://localhost:9000" | tac | tac | grep -q "Gatsby"

deploy staging: 
  stage: deploy staging
  environment:
    name: staging
    url: http://$STAGING_DOMAIN
  script:
    - npm install --global surge
    - surge --project ./public --domain $STAGING_DOMAIN

deploy production: 
  stage: deploy production
  environment:
    name: production
    url: $PRODUCTION_DOMAIN
  script:
    - npm install --global surge
    - surge --project ./public --domain $PRODUCTION_DOMAIN

production tests:
  image: alpine
  stage: production tests
  script:
    - apk add --no-cache curl
    - curl -s "https://$PRODUCTION_DOMAIN" | grep -q "Hi people"
    - curl -s "https://$PRODUCTION_DOMAIN" | grep -q "$CI_COMMIT_SHORT_SHA"
```