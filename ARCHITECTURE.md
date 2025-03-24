Here is a simple flow chart:

```mermaid

sequenceDiagram
    participant Runtime
    participant Model
    participant View
    participant Update

    Model->>Runtime: Gives the initial model and<br/>an empty list of commands to execute
    Runtime->>View: Renders view with initial model
    View->>Runtime: Triggers "FirstName" message when typing first name
    Runtime->>Update: Sends "FirstName" message with current model
    Update->>Runtime: Returns model with updated firstName string
    Runtime->>View: Renders view with updated model

    View->>Runtime: Triggers "LastName" message when typing last name
```
