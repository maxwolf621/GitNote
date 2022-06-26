# Reference/Verweise auf URL

- [git-scm.com](https://git-scm.com/book/de/v2)  
- [Learn Git in 30days](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/README.md)    
- [Git Commands diagram](https://marklodato.github.io/visual-git-guide/index-de.html)  
- [Interview](https://segmentfault.com/a/1190000019315509)  
- [What is git](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-Git-%E6%98%AF%E4%BB%80%E4%B9%88%EF%BC%9F)

## Quick Review
- [Git Quick Review](GitQuickReview.md)

## Branch 
- [Branch](https://git-scm.com/docs/git-branch)
- [Branch with Diagram](https://git-scm.com/book/zh-tw/v2/%E4%BD%BF%E7%94%A8-Git-%E5%88%86%E6%94%AF-%E5%88%86%E6%94%AF%E5%92%8C%E5%90%88%E4%BD%B5%E7%9A%84%E5%9F%BA%E6%9C%AC%E7%94%A8%E6%B3%95)

The Most Used Command   
`git branch -a` : shows both local and remote branches.   
`git branch [branch_name]` : create a branch_name   
`git checkout -b [branch_name]` : create a branch_name and switch to it   
`git checkout [branch_name]` : switch to branch_name    
`git branch -d [branch_name]` : delete the branch_name   
`git log` : Display each commitment內容   

### [Branch Usage](BranchUsage.md)

- [Git's Ref](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#%E5%8F%83%E7%85%A7ref%E5%90%8D%E7%A8%B1)  
- [smyref && custom ref](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#symref)
- [ref's `~` and `^` ](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#%E7%9B%B8%E5%B0%8D%E5%90%8D%E7%A8%B1%E8%A1%A8%E7%A4%BA)
- [tag](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#tag)  

#### ERROR [`refname xxx not found`](https://stackoverflow.com/questions/18382986/git-rename-local-branch-failed)
```console
error: refname refs/heads/HEAD not found
fatal: Branch rename failed
```

This Error tells you are currently in detached head state.  
You must `checkout -b` a new branch to associate it  
```bash
$ git checkout -b NEW_BRANCH
```

### [git merge COMMIT_ID](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#merge)  

使用`git merge`的情境 (假設master(或main)分支為開發版本,stable分支是客戶使用穩定版本) 如下
1. (當stable分支需要Hot Fix) 要使用`cherry-pick master` 緊急的修改到stable分支或是直接在stable分支修bug
2. 為了降低未來merge的複雜度使分支版本不要相異太大,則利用`git merge stable`併到分master(或main)分支
3. 短期內無緊急出新版壓力的時候,`git merge master`到stable，避免兩者差異愈來愈大。

### `git merge` fast forward mode and No Fast Mode 
- [`git merge` fast forward mode and No Fast Mode](https://medium.com/@fcamel/%E4%BD%95%E6%99%82%E8%A9%B2%E7%94%A8-git-merge-no-ff-d765c3a6bef5)   



![image](https://user-images.githubusercontent.com/68631186/127765463-8b5884a8-45f3-475c-b9d7-cbf89198677e.png)   
- no fast mode `--no-ff` 額外會在提交一個merge commit


### Difference btw `git rebase` And `git merge`

![image](https://user-images.githubusercontent.com/68631186/127765603-849ade88-a225-4df0-b23f-202dc6b2689b.png)
```console
git checkout master
# Commit C8 Version
(master) git merge stable 

git checkout stable
# Ref To C8 
(stable)　git merge master 
```

![image](https://user-images.githubusercontent.com/68631186/127765616-e18bd517-e69c-4984-92fc-f638b12ae27e.png)  
```diff
git checkout master
# commit C8 version
git merge stable 

(master)git checkout stable
# commit C9 version
(stable) git merge master --no--ff 
```

## Remote and Local Repository

`git clone URL_of_RemoteBranch`   
Clone the repository into local storage and Create Work Directory與Local Repository (that is `.git` fold)

`git push origin master`  
(IF the remote has no initial main/master) `git push -u origin master` 
To Push the modified to remote repository
 
`git pull origin master`  
`git config --global push.default simple`  
將遠端儲存庫的最新版下載回來，下載的內容包含完整的物件儲存庫(object storage), 並且將遠端分支合併到本地分支。 (將 origin/master 遠端分支合併到 master 本地分支)

`git push`將本地儲存庫中目前分支的所有相關物件推送到遠端儲存庫中。

`git fetch`
將遠端儲存庫的最新版下載回來，下載的內容包含完整的物件儲存庫(object storage)   
`git fetch`不包含merge分支的動作  

`git fetch`完後可以利用`git merge`將版本不同的本地跟遠端分支進行合併
`git merge origin/master`

`git pull origin master --allow-unrelated-histories`
允許Git合併沒有共同祖先的分支  

`git ls-remote` 
顯示特定遠端儲存庫的參照名稱。包含遠端分支與遠端標籤。

`git remote -v`
列出目前註冊在工作目錄裡的遠端儲存庫資訊

[Git Reset](https://reurl.cc/LmrR4L)

## `git remote` 註冊遠端儲存庫remote repository
-  [`git remote` 註冊遠端儲存庫remote repository](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/25.md)    

Register an alias name for remote repository 
```console
# Syntax
git remote add [Alias For Remote Repository] [Remote_Repository_URL.git]

# For example
git remote add ImExample https://github.com/maxwolf621/yoyoman.git
```

[註冊多個不同Remote Repositories到Local Repository](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/25.md#%E8%A8%BB%E5%86%8A%E9%81%A0%E7%AB%AF%E5%84%B2%E5%AD%98%E5%BA%AB)
```console
git remote add origin https://github.com/doggy8088/sandbox-empty2.git
git remote add jquery git remote add jquery https://github.com/jquery/jquery.git

# 利用 別名Alias 從遠端抓所有資料下來
git fetch origin
git fetch jquery
```

這些註冊進工作目錄的遠端儲存庫設定資訊，都儲存在`.git\config`設定檔中，其內容如下
```console
[remote "origin"]
	url = https://github.com/doggy8088/sandbox-empty2.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[remote "jquery"]
	url = https://github.com/jquery/jquery.git
	fetch = +refs/heads/*:refs/remotes/jquery/*
```
- `[remote "origin"]` 區段的設定，包含了遠端儲存庫的代表名稱`origin`，還有兩個重要的參數，分別是`url`與`fetch`這兩個，**所代表的意思是：「遠端儲存庫`URL`位址在 `https://github.com/doggy8088/sandbox-empty2.git`，然後`fetch`所指定的則是一個參照名稱對應規格(refspec)。」**
- `git ls-remote` 或 `git ls-remote origin` 即可列出所有遠端分支
- `branch -a`會列出所有遠端分支以及**本地追蹤(red mark)**

### refsepc

假設有個`[remote "origin"]`區段
```console
[remote "origin"]
       url = https://github.com/doggy8088/sandbox-empty2.git
       fetch = +refs/heads/master:refs/remotes/origin/master
       fetch = +refs/heads/TestBranch:refs/remotes/origin/TestBranch
```
- 表示只會`git fetch` remote repository目錄中的兩個分支分別是`/heads/master`以及`headers/TestBranch`
- `+` : 設定 `+` 加號，代表傳輸資料時，不會特別使用安全性確認機制。
- `refs/heads/*` : 「來源參照規格」，代表一個位於遠端儲存庫的遠端分支
- `:` : 這用來區隔 **｢來源分支｣** `:` **「目的分支」**
	- `左SOURCE : 右TARGET`
- `refs/remotes/origin/*` : 「目的參照規格」，代表一個位於本地儲存庫的本地追蹤分支

### `git push` 非 `master`(或`main`) Local Repository 的 Branch 

- [`git push` 非 `master`(或`main`) Local Repository 的 Branch](https://reurl.cc/0p071x)   

如果我們建立一個 `FixForCRLF` 本地分支，必須明確輸入完整的`git push origin FixForCRLF`才能將`FixForCRLF` push到遠端Repo，原因就出在我們沒有設定「本地分支」與「遠端儲存庫」之間的預設對應關係

**要將本地分支建立起跟Remote Repo的對應關係，只要在`git push`的時候加上`--set-upstream`參數，即可將本地分支註冊進`.git\config`設定檔，未來即可直接使用`git push`做推送**         
```console
[branch "FixForCRLF"]
	remote = origin
	merge = refs/heads/FixForCRLF
```

### `git reset` `HEAD` 或 `ORIG_HEAD`

**(未合併)** 如果你今天發生了Conflict，而又不知道如何解決，因為版本尚未被成功合併，所以你可以執行`rest`指令重置到目前的`HEAD`版本：`git reset --hard HEAD`  

**(已合併)** 如果你今天成功的**合併**了，但又想反悔這次的合併動作 : `git reset --hard ORIG_HEAD` 重置到`ORIG_HEAD`這個版本

## Different Branch in same remote Repository

- [Different Branch in same remote Repository](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/27.md)

當 `git clone` 一個 Remote Repository 後,預設都會有一個 `master`/`main` Branch  
實務上，也就是這個版本必須是乾淨且高品質的原始碼版本。  
所以，我們會要求所有人都不要用這個分支來建立任何版本，真正要建立版本時，一定會透過「合併」的方式來進行操作，以確保版本能夠更容易被追蹤
再開發過程中則會建立不同的分支方便專案管理,其中常見分支開發名稱

```diff
+ master或者main : 通常存放系統的穩定版本
+ develop : 開發版本
- feature/[branch_name] : 開發的功能
- hotfix/[branch_name] : 穩定版本的突發(Hot)錯誤 
```
- `git push --all`: 能將所有本地分支都`push`到某個Remote Repository內    
- `git push --tags`: 則是將所有本地分支的tags都`push`到某個Remote Repository內    
- [`git fetch --all --tags`: 告訴團隊將我所`git push`的本地分支全 `fetch` 下來](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/27.md#%E8%AB%8B%E5%9C%98%E9%9A%8A%E6%88%90%E5%93%A1%E4%B8%8B%E8%BC%89%E9%81%A0%E7%AB%AF%E5%84%B2%E5%AD%98%E5%BA%AB%E6%89%80%E6%9C%89%E7%89%A9%E4%BB%B6)    

## Generierte Commits überarbeiten oder rückgängig machen

* [commit版本控制基本原則](https://reurl.cc/DykGoj)  
* [git revert](https://reurl.cc/b280l3)  
* [git cherry-pick](https://reurl.cc/GxyWKG)
* [git reset](https://reurl.cc/WrQlvy)
* [git commit --amend](https://reurl.cc/QLAzZO)
* [git rebase COMMIT](https://reurl.cc/NAdVy9)   
	- [Example : Somebody else has pushed to master already, and   your `commit` is behind. Therefore you have to fetch, merge the changeset, and then you'll be able to push again.](https://github.com/maxwolf621/GitNote/blob/main/rebaseExample.sh)    
	- [! [rejected] master -> master (fetch first)](https://stackoverflow.com/questions/28429819/rejected-master-master-fetch-first)   

## 多人遠端合作問題

以下為幾個多人遠端合作常用的情境

### Q1 [`pull request`](https://gitbook.tw/chapters/github/pull-request.html)

- [`pull`](https://kingofamani.gitbooks.io/git-teach/content/chapter_5/pull.html)
- [Clone A Fork](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/28.md#%E4%BD%BF%E7%94%A8-fork-%E9%81%8E%E7%9A%84-git-%E9%81%A0%E7%AB%AF%E5%84%B2%E5%AD%98%E5%BA%AB)

使用情境     
UserB 從 UserOrigin fork 一份project_X，並`git clone`下來進行改寫(UserB有完整的權限對該forked project_X進行改寫),`git push`完後可以通知(Notify) UserOrigin 你在Forked Project_X 做了一些改寫， UserOrigin 看完後如果覺得比原本的好，則可以把UserB的Forked project_X所作的修改Merge到他(UserOrigin)的專案project_X    

### Q2 [多人共用Remote Repository專案不同步](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/26.md) 

- [Syncing A Fork(From Remote)](https://gitbook.tw/chapters/github/syncing-a-fork.html)

一個多人合作的專案進度可能會與你目前本地專案進度有所不同，例如   
```
origin--------------origin_NewVersion
'-- userX--userX_2      
'			          
'---userA--userA_1--userA_2
```
- 可以看到`userX`的分支進度明顯與遠端`origin`的分支進度還慢，這時候如果 userX 要 `push` 到 `origin` 會發生錯誤，為了避免兩者專案的差異性越來越大，我們就需要進行同步避免差異性

可以用以下方式解決
1. `git fetch` fetches Remote Repo所有分支以及`git merge origin/master`(merge遠端的分支)     

```diff
# In UserX Branch上 

# 抓取遠端目前分支上的所有commitments
(UserX) git fetch remotes/origin/main 
# UserX分支與遠端上分支進行合併
(UserX) git merge remotes/origin/main 
```

2. `git pull`直接取代`git fetch`　+ `git merge`     

合併後會變成像這樣
```
origin-------origin_NewVersion------+
 '                                  | (merge)
 '-----userX------------------------+----------userX-2
```
即完成同步的功能
