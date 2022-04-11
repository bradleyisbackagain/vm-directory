#  Directory

A simple directory application.

## Summary

### Architecture

[x] SOLID
[x] Uses MVVM architecture
[x] Uses modular, extensible design
    - Generic, abstracted lists/details
    - Abstracted data-fetching interfaces
[x] Can be used by new developers
    - Code is documented, readable, commented (where required)
[x] Easy to add more data in the future
    - Can just add another tab to the tab bar (and additional pages if even more are added)
[x] Easy to change environment
    - Remote API data source is abstracted, just change URL
    - Stubbing is possible for the data source
    
### Testing

[x] Unit tests for all business logic
[ ] UI tests for views and view controllers

### Other

[ ] iPad support
[x] Accessible
    - Dynamic type font size
    - Accessibility label hints (most automatic, some added)
[x] Uses brand color, easily changable in the future as defined in single module.
