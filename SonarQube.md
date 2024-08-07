# Sonar Qube
SonarQube, is a self-managed, automatic code review tool that systematically helps you deliver Clean Code. As a core element of our Sonar solution, SonarQube integrates into your existing workflow and detects issues in your code to help you perform continuous code inspections of your projects. The tool analyses 30+ different programming languages and integrates into your CI pipeline and DevOps platform to ensure that your code meets high-quality standards.

## Arquitecture


|Concept|	Definition|
|-|-|
Analyzer|	A client application that analyzes the source code to compute snapshots.
Database|	Stores configuration and snapshots
Server|	Web interface that is used to browse snapshot data and make configuration changes

- SONARQUEBE
- sonarScanner
- BD POSTGRESS

## Quality Concepts

|Concept|	Definition|
|-|-|
Bug|	An issue that represents something wrong in the code. If this has not broken yet, it will, and probably at the worst possible moment. This needs to be fixed. Yesterday.
Code Smell|	A maintainability-related issue in the code. Leaving it as-is means that at best maintainers will have a harder time than they should making changes to the code. At worst, they'll be so confused by the state of the code that they'll introduce additional errors as they make changes.
Cost|	See Remediation Cost
Debt|	See Technical Debt
Issue|	When a piece of code does not comply with a rule, an issue is logged on the snapshot. An issue can be logged on a source file or a unit test file. There are 3 types of issue: Bugs, Code Smells and Vulnerabilities
Measure|	The value of a metric for a given file or project at a given time. For example, 125 lines of code on class MyClass or density of duplicated lines of 30.5% on project myProject
Metric|	A type of measurement. Metrics can have varying values, or measures, over time. Examples: number of lines of code, complexity, etc. A metric may be either qualitative (gives a quality indication on the component, E.G. density of duplicated lines, line coverage by tests, etc.) or quantitative (does not give a quality indication on the component, E.G. number of lines of code, complexity, etc.)
New Code definition|	A changeset or period that you're keeping a close watch on for the introduction of new problems in the code. Ideally this is since the previous_version, but if you don't use a Maven-like versioning scheme you may need to set a time period such as 21 days, since a specific analysis, or use a reference branch.
Quality Profile	|A set of rules. Each snapshot is based on a single Quality Profile. See also Quality Profiles
Rule|	A coding standard or practice which should be followed. Not complying with coding rules leads to Bugs, Vulnerabilities, Security Hotspots, and Code Smells. Rules can check quality on code files or unit tests.
Remediation Cost|	The estimated time required to fix Vulnerability and Reliability Issues.
Snapshot|	A set of measures and issues on a given project at a given time. A snapshot is generated for each analysis.
Security Hotspot|	Security-sensitive pieces of code that need to be manually reviewed. Upon review, you'll either find that there is no threat or that there is vulnerable code that needs to be fixed.
Technical Debt	|The estimated time required to fix all Maintainability Issues / code smells
Vulnerability|	A security-related issue which represents a backdoor for attackers. See also Security-related rules.

tipos issues
- bug
- vulnerability 
- code smell pcoco claro sin estandares de codificacion
- security hotspot

severity issues
- Blocker
- Critical
- Major
- Minor
- Info

Rules

cobertura de pruebas unitarias (measures - tests)
- unit test
- error
- failures
- skipped
- success
- duration 

codigo duplicado

complejidad

deuda tecnica

SOALE( software quality assesment based on lifecycle expectations)

Compuerta de calidad (Quality Gate)

## SonarCloud