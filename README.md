# Reference/Verweise auf URL

[git-scm.com](https://git-scm.com/book/de/v2)  
[Notes From](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/README.md)    
[GitCommand diagram](https://marklodato.github.io/visual-git-guide/index-de.html)  
[面試](https://segmentfault.com/a/1190000019315509)  

# Note 

- [What is git](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-Git-%E6%98%AF%E4%BB%80%E4%B9%88%EF%BC%9F)
- [Git Quick Review](GitQuickReview.md)
- [`git diff`](https://github.com/maxwolf621/GitNote/blob/main/GitQuickReview.md#git-diff)
## Branch
```diff
#display 所有分支
- git branch 

#遠端/本地分支追蹤
- git branch -a 

- git branch [branch_name]

# switch to branch_name
- git checkout -b [branch_name]
- git checkout [branch_name]

# delete the branch_name
- git branch -d [branch_name]

# display each commit 內容
- git log
```
- [Diagram Branch](https://git-scm.com/book/zh-tw/v2/%E4%BD%BF%E7%94%A8-Git-%E5%88%86%E6%94%AF-%E5%88%86%E6%94%AF%E5%92%8C%E5%90%88%E4%BD%B5%E7%9A%84%E5%9F%BA%E6%9C%AC%E7%94%A8%E6%B3%95)

### [Branch Usage](BranchUsage.md)
- [Git's Ref](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#%E5%8F%83%E7%85%A7ref%E5%90%8D%E7%A8%B1)  
- [smyref && custom ref](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#symref)
- [ref's `~` and `^` ](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#%E7%9B%B8%E5%B0%8D%E5%90%8D%E7%A8%B1%E8%A1%A8%E7%A4%BA)
- [tag](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#tag)  
- [git merge COMMITID](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#merge)  
  > 使用`git merge`的情境(assum master開發版本,stable客戶使用穩定版本)
  > 1. (stable需要hotfix) `cherry-pick master` 緊急的修改到 stable。
  > 2. 或是直接在 stable 修 bug。
  > 3. `git merge stable` 回到 master，降低日後 merge 的複雜度。
  > 4. 短期內無緊急出新版壓力的時候,`git merge` master 到 stable，避免兩者差異愈來愈大。


#### Example For Branch
[refname xxx not found](https://stackoverflow.com/questions/18382986/git-rename-local-branch-failed)
```console
error: refname refs/heads/HEAD not found
fatal: Branch rename failed
```
- Becaause You are currently in detached head state. 

You must checkout a new branch to associate it with the current commit:
```bash
$ git checkout -b NEW_BRANCH
```

### [`git merge CommitId`的fast forward mode](https://medium.com/@fcamel/%E4%BD%95%E6%99%82%E8%A9%B2%E7%94%A8-git-merge-no-ff-d765c3a6bef5)

![image](https://user-images.githubusercontent.com/68631186/127765463-8b5884a8-45f3-475c-b9d7-cbf89198677e.png)

### Usage For Rebase And Merge
```diff
git checkout master
- (master)git merge stable #commit C8 version

git checkout stable
- (stable)git merge master # ref to c8 
```
![image](https://user-images.githubusercontent.com/68631186/127765603-849ade88-a225-4df0-b23f-202dc6b2689b.png)

```diff
git checkout master
(master)git merge stable #commit C8 version

(master)git checkout stable
(stable)git merge master --no--ff #comit C9 version
```
![image](https://user-images.githubusercontent.com/68631186/127765616-e18bd517-e69c-4984-92fc-f638b12ae27e.png)

## Remote and Clone
```diff
# Clone the repository into local storage
# 將遠端儲存庫複製到本地，並建立工作目錄與本地儲存庫 (就是 .git 資料夾)
# 所以remote的Branchs皆會被下載下來
- git clone URL

#---push the modified to remote repository---
- git push origin master
- git push -u origin master #IF the remote has no inital main/master 

# 將遠端儲存庫的最新版下載回來，下載的內容包含完整的物件儲存庫(object storage)。
# 並且將遠端分支合併到本地分支。 (將 origin/master 遠端分支合併到 master 本地分支)
- git pull origin master

git config --global push.default simple

# 將本地儲存庫中目前分支的所有相關物件推送到遠端儲存庫中。
- git push

# 將遠端儲存庫的最新版下載回來，下載的內容包含完整的物件儲存庫(object storage)。
# git fetch指令不包含「合併」分支的動作
- git fetch
# `git fetch`完後利用git merge將版本不同的本地跟遠端分支進行合併
git merge origin/master

# 允許 Git 合併沒有共同祖先的分支。
git pull origin master --allow-unrelated-histories

# 顯示特定遠端儲存庫的參照名稱。包含遠端分支與遠端標籤。
- git ls-remote
```

## 註冊遠端儲存庫
[Remote](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/25.md)    

### 註冊一個遠端分支到本地分支
```console
git remote add origin https://github.com/doggy8088/sandbox-empty2.git
```

這些註冊進工作目錄的遠端儲存庫設定資訊，都儲存在`.git\config`設定檔中，其內容如下範例：
```console
[remote "origin"]
	url = https://github.com/doggy8088/sandbox-empty2.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[remote "jquery"]
	url = https://github.com/jquery/jquery.git
	fetch = +refs/heads/*:refs/remotes/jquery/*
```
- `git ls-remote` 或 `git ls-remote origin` 即可列出所有遠端分支
- `branch -a`會列出所有遠端分支以及本地追蹤

### refsepc
假設設定一個refspec為下
```console
[remote "origin"]
       url = https://github.com/doggy8088/sandbox-empty2.git
       fetch = +refs/heads/master:refs/remotes/origin/master
       fetch = +refs/heads/TestBranch:refs/remotes/origin/TestBranch
```
- 表示只會`git fetch` remote的master以及TestBranch
- `+` : 設定 + 加號，代表傳輸資料時，不會特別使用安全性確認機制。
- `refs/heads/*` : 「來源參照規格」，代表一個位於遠端儲存庫的遠端分支
- `:` : 這用來區隔｢來源分支｣與「目的分支」
- `refs/remotes/origin/*` : 「目的參照規格」，代表一個位於本地儲存庫的本地追蹤分支


### `git push`非本地master的Branch   
一個工作目錄下的本地儲存庫，可能會定義有多個遠端儲存庫   
> 當你想將非main分支透過`git push`推送到Remote Repository時，Git 可能不知道你到底想推送到哪裡，所以我們要另外定義本地分支與遠端儲存庫之間的關係   

#### For example     
建立一個 FixForCRLF 本地分支，直接透過 git push 無法推送成功，你必須輸入完整的`git push origin FixForCRLF`指令才能將本地分支推送上去，原因就出在你並沒有設定「本地分支」與「遠端儲存庫」之間的預設對應    
要將本地分支(如FixForCRLE)建立起跟遠端儲存庫的對應關係，只要在`git push`的時候加上`--set-upstream`參數，即可將本地分支(FixForCRLF)註冊進`.git\config`設定檔，之後再用`git push`就可以順利的自動推送上去         
```console
[branch "FixForCRLF"]
	remote = origin
	merge = refs/heads/FixForCRLF
```

如果你今天發生了衝突(Conflict)狀況，而又不知道如何解決，因為版本尚未被成功合併，所以你可以執行以下指令「重置」到目前的 HEAD 版本：
- `git reset --hard HEAD`

如果你今天成功的合併了，但又想反悔這次的合併動作，那麼你還是可以執行以下指令「重置」到合併前的版本狀態，也就是重置到 ORIG_HEAD 這個版本：
- `git reset --hard ORIG_HEAD`

## Generierte Commits überarbeiten oder rückgängig machen
[Commit版本控制](commit版本控制.md)  

* [commit版本控制基本原則](https://github.com/maxwolf621/GitNote/blob/main/commit%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6.md#%E7%89%88%E6%9C%AC%E6%8E%A7%E7%AE%A1%E7%9A%84%E5%9F%BA%E6%9C%AC%E5%8E%9F%E5%89%87)  
* [git revert](https://github.com/maxwolf621/GitNote/blob/main/commit%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6.md#git-revert)  
* [git cherry-pick](https://github.com/maxwolf621/GitNote/blob/main/commit%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6.md#git-cherry-pick)
* [git reset](https://github.com/maxwolf621/GitNote/blob/main/commit%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6.md#git-reset-commit_version)
* [git commit --amend](https://github.com/maxwolf621/GitNote/blob/main/commit%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6.md#changing-the-last-commit-git-commit---amend)
* [git rebase COMMIT](https://github.com/maxwolf621/GitNote/blob/main/commit%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6.md#rebase)
    > [Example : Somebody else has `push`ed to master already, and your `commit` is behind. Therefore you have to fetch, merge the changeset, and then you'll be able to push again.](https://github.com/maxwolf621/GitNote/blob/main/rebaseExample.sh)  
    >> [! [rejected] master -> master (fetch first)](https://stackoverflow.com/questions/28429819/rejected-master-master-fetch-first)   
     

## 多人遠端合作
- [多人共用Remote Repository](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/26.md)當某一方的本地無法`git push`modified到遠端時
	>```diff
	># fetch遠端所有分支, merge遠端的分支並merge
	>- git fetch
	>- git merge origin/master
	>
	># 直接取代fit fetch跟git merge
	>- git pull
	>```
- [git clone a fork](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/28.md#%E4%BD%BF%E7%94%A8-fork-%E9%81%8E%E7%9A%84-git-%E9%81%A0%E7%AB%AF%E5%84%B2%E5%AD%98%E5%BA%AB)
  > ```diff
  > + UserA_Project --- fork ---> In_UserB -- git clone --> In_UserC
  > - In_UserC --> git push --> In_UserB
  > ```
- How do we merg In_UserB with UserA_Project ? [Via `pull request`](https://gitbook.tw/chapters/github/pull-request.html)
- [Syncing A Fork(From Remote)](https://gitbook.tw/chapters/github/syncing-a-fork.html)
- [團隊不同Branch上的開發之應用](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/27.md#%E9%96%8B%E5%A7%8B%E5%90%84%E8%87%AA%E9%80%B2%E8%A1%8C%E4%B8%8D%E5%90%8C%E7%9A%84%E5%88%86%E6%94%AF%E9%96%8B%E7%99%BC)

### 常見分支開發名稱
```diff
- master : 通常存放系統的穩定版本
- develop : 開發版本
- feature/[branch_name] : 開發的功能
- hotfix/[branch_name] : 穩定版本的突發(hot)錯誤 
```
