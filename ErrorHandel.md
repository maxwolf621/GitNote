# ErrorHandel


[Source](https://stackoverflow.com/questions/18382986/git-rename-local-branch-failed)
error: refname refs/heads/HEAD not found
fatal: Branch rename failed

Becaause You are currently in detached head state. 
You must checkout a new branch to associate it with the current commit:
```bash
git checkout -b NEW_BRANCH
```

[Deleteing A Git Commit](https://www.clock.co.uk/insight/deleting-a-git-commit)

- [! [rejected] master -> master (fetch first)](https://stackoverflow.com/questions/28429819/rejected-master-master-fetch-first)
  > Probably somebody else has pushed to master already, and your commit is behind. Therefore you have to fetch, merge the changeset, and then you'll be able to push again.
