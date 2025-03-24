No async/await in core GUN operations
Storage operations must be synchronous
Maintain 100% compatibility with the original Gun API from gun-master
All changes must have corresponding tests
Each component must be validated against original GUN (found in folder gun-master)
Ensure that implementations are complete, not just stub implementations. They must really do the work they say they do. 
Document all deviations from original implementation
Always: Add TODO Comments when creating stub or partitial implementions
Always: Atempt to make progress in completing and implemention when a TODO comment is encountered
Always: Update the comments if changes are made to the code
USE: functional code, native solutions, declarative syntax, modern practices, latest versions, idempotency, rich schemas
USE: Deno, powershell, svelte, typescript, jsdoc, json, finte state machines