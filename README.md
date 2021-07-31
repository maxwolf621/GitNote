# Reference/Verweise auf URL

[git-scm.com](https://git-scm.com/book/de/v2)  
[Notes From](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/README.md)    
[GitCommand diagram](https://marklodato.github.io/visual-git-guide/index-de.html)  
[面試](https://segmentfault.com/a/1190000019315509)  

# Note 

## Basic
- [Git](Git.md)

## Branch

## Remote and Clone
- [Clone]()
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

手動註冊一個遠端分支
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

`git ls-remote` 或 `git ls-remote origin` 即可列出所有遠端分支
`branch -a`會列出所有遠端分支以及本地追蹤
### refsepc

`+`設定 + 加號，代表傳輸資料時，不會特別使用安全性確認機制。

refs/heads/* : 「來源參照規格」，代表一個位於遠端儲存庫的遠端分支

`:` : 這用來區隔｢來源分支｣與「目的分支」

`refs/remotes/origin/*` : 「目的參照規格」，代表一個位於本地儲存庫的本地追蹤分支


假設設定一個refspec為下
```bash
[remote "origin"]
       url = https://github.com/doggy8088/sandbox-empty2.git
       fetch = +refs/heads/master:refs/remotes/origin/master
       fetch = +refs/heads/TestBranch:refs/remotes/origin/TestBranch
```
- 只會`git fetch` remote的master以及TestBranch

### `git push`非本地非main的Branc
一個工作目錄下的本地儲存庫，可能會定義有多個遠端儲存庫。
> 當你想將非main分支透過`git push`推送到遠端時，Git 可能不知道你到底想推送到哪裡，所以我們要另外定義本地分支與遠端儲存庫之間的關係。


For example 
建立一個 FixForCRLF 本地分支，直接透過 git push 無法推送成功，你必須輸入完整的`git push origin FixForCRLF`指令才能將本地分支推送上去，原因就出在你並沒有設定「本地分支」與「遠端儲存庫」之間的預設對應。
要將本地分支(如FixForCRLE)建立起跟遠端儲存庫的對應關係，只要在`git push`的時候加上`--set-upstream`參數，即可將本地分支(FixForCRLF)註冊進`.git\config`設定檔，之後再用`git push`就可以順利的自動推送上去。  

```
[branch "FixForCRLF"]
	remote = origin
	merge = refs/heads/FixForCRLF
```

## Generierte Commits überarbeiten oder rückgängig machen

* [git reset](https://github.com/maxwolf621/GitNote/blob/main/commit%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6.md#git-reset-commit_version)
* [git commit --amend](https://github.com/maxwolf621/GitNote/blob/main/commit%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6.md#changing-the-last-commit-git-commit---amend)
* [git rebase COMMIT](https://github.com/maxwolf621/GitNote/blob/main/commit%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6.md#rebase)
