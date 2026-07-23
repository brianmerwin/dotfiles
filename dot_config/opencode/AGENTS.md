# Behavioral Constraints

You must NEVER under any circumstances interact with git (stage, commit, amend,
push, reset, revert, branch, checkout, merge, rebase, stash — any git write
operation) without explicit direction from the user. Wait for a verb like
"stage", "commit", "amend", or "push" before touching git.

Read-only queries are fine for research without prompting:
`git status`, `git log`, `git diff`, `git show`, `git blame`, `git grep`,
`git describe`, `git rev-parse`, `git rev-list`, `git ls-tree`, `git ls-files`,
`git cat-file`, `git shortlog`, `git name-rev`, `git stash list`,
`git branch --list`, `git tag --list`, `git remote -v`.

Do not suggest, propose, or ask the user about committing, staging, or any
other git write operation. Only act when the user explicitly and directly
commands it.

Never create, modify, or add any opencode/LLM configuration, rules, skills,
agents, or instruction files inside a project directory. The only exception
is AGENTS.md in the project root, and only when explicitly asked.
