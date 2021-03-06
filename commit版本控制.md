###### tags : `git`
# Git版本控制

- [Note Taking](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/18.md)  



## 版本控管的基本原則

**維持一個良好的版本紀錄有助於我們追蹤每個版本的更新歷程,當軟體的BUG發生的時候，我們會需要去追蹤特定**BUG的歷史紀錄，查出該BUG真正發生的原因，這個時候就是版本控管帶來最大價值的時候

原則 : Project只要有做細小的修改(modified)就建立版本(commit)附上註解，這樣未來才容易追蹤變更, 盡量不要一次commit Project多處部分的修改
  > 有邏輯、有順序的修正功能，確保相關的版本修正可以**按順序提交(commit)**，這樣才便於追蹤(e.g 利用`git log`)

## 修正`commit`歷史紀錄的理由

**大部分的Git操作都著重在Local Repo，也就是在工作目錄下的版本管控，這個Repository就位於`.git/`目錄下**, 但「遠端儲存庫」的應用，就牽涉一個TEAM的不同Member不同版本的管控,在Git版本控管中，**只要同一份儲存庫有多人共用的情況下，若有人任意竄改版本，那麼 Git 版本控管一樣會無法正常運作**  

For example，有三個版本
```diff
[A] -> [B] -> [C] 
```
可能會發生以下情況
1. `[C]`版本你發現`commit`錯了，必須刪除這一版本所有變更
2. (測試程式碼) `commit`了之後才發現`[C]`這個版本其實只有測試程式碼，你也想刪除他
3. (錯字) 其中有些版本的紀錄訊息有錯字，你想修改訊息文字，但不影響檔案的變更歷程
4. (更改commit版本順序) 想把這些版本的`commit`順序調整為 `[A] -> [C] -> [B]`，讓版本演進更有邏輯性
5. (某個版本遺漏的重要檔案) 發現`[B]`這個版本忘了加入一個重要的檔案就`commit`了，你想事後補救這次變更
6. 在你打算分享分支出去時，發現了程式碼有瑕疵，你可以修改完後再分享出去

### 修正`commit`歷史紀錄的注意事項

**Git保留了「修改版本歷史紀錄」的機制，主要是希望能在「自我控管版本」到了一定程度後，自己整理一下版本紀錄的各種資訊，好讓我們將版本發布出去後，讓其他人能夠更清楚的理解這些發布的版本到底做了哪些修改**

修改版本歷史紀錄時，有些事情必須特別注意
- 一個 Repository 可以有許多Branchs 
    - (預設分支名稱為 main)
- **分享 Git 原始碼的最小單位是以 Branch 為單位**
- 你可以任意修改某個 Branch 上的版本，只要你還沒「分享」給其他人
- 當你「分享」特定 Branch 給其他人之後，這些已分享(Commit)的版本歷史紀錄就別再改了

## `git revert`  (凡走下必留痕跡)
[According to gitbook.tw](https://gitbook.tw/chapters/rewrite-history/reset-revert-and-rebase.html)   

藉由新增一個`commit`來**反轉(Revert)/撤銷(Withdraw)**某一個`commitment`，被`revert`的comitments還是會保留在歷史紀錄中
- 使用`rvert`會增加Commitment，通常比較適用於已經推出去的Commit，或是不允許使用`reset`或`rebase`之修改歷史紀錄的指令的場合    

- 如果是自己一個人做的專案，有點雞肋，大部份都是直接使用Reset就好。但如果對於多人共同協作的專案，也許因為團隊開發的政策，你不一定有機會可以使用Reset指令，**這時候就可以`revert`指令來做出一個「Revert/Withdraw」的 Commit，對其它人來說也不算是「修改歷史」，而是新增一個 Commit，只是剛好這個 Commit 是跟某個 Commit 反向的操作而已**

For example
```console
# commit 
pi@JianMayer:~/Desktop/diffExample $ echo 123 > revert.txt
pi@JianMayer:~/Desktop/diffExample $ git add revert.txt
pi@JianMayer:~/Desktop/diffExample $ git commit -m "add revert.txt"
[master b29b246] add revert.txt
 1 file changed, 1 insertion(+)
 create mode 100644 revert.txt

# check the newst commit
pi@JianMayer:~/Desktop/diffExample $ git log -1
commit b29b2464feec76d5f5a792bed4aabddd0492a793 (HEAD -> master)
Author: Maxwolf621 <1234@gmail.com>
Date:   Sun Aug 1 01:56:48 2020 +0800

    add revert.txt

# to revert the commit b29b2464 to new one via `git revert commit_id`
pi@JianMayer:~/Desktop/diffExample $ git revert b29b2464
[master e659d5e] Revert "add revert.txt" Execute git revert b29b2364
 1 file changed, 1 deletion(-)
 delete mode 100644 revert.txt
```

After `git revert b29b2464` 
```console
Revert "add revert.txt"
Execute git revert b29b2364

This reverts commit b29b2464feec76d5f5a792bed4aabddd0492a793.

# Bitte geben Sie eine Commit-Beschreibung f\u00fcr Ihre \u00c4nderungen ein. Zeilen,
# die mit '#' beginnen, werden ignoriert, und eine leere Beschreibung
# bricht den Commit ab.
#
# Auf Branch master
# Zum Commit vorgemerkte \u00c4nderungen:
#       gel\u00f6scht:       revert.txt
#
# Unversionierte Dateien:
#       asbacvsd
#
```

```console
pi@JianMayer:~/Desktop/diffExample $ # Check out latest commit
pi@JianMayer:~/Desktop/diffExample $ git log -1
commit e659d5ecd2a1e0cd17e5d7e304e1a08e0d4c8b3a (HEAD -> master)
Author: Maxwolf621 <jervismayer@gmail.com>
Date:   Sun Aug 1 01:58:27 2021 +0800

    Revert "add revert.txt"
    Execute git revert b29b2364
    
    This reverts commit b29b2464feec76d5f5a792bed4aabddd0492a793.
pi@JianMayer:~/Desktop/diffExample $ git show b29b2464
commit b29b2464feec76d5f5a792bed4aabddd0492a793
Author: Maxwolf621 <jervismayer@gmail.com>
Date:   Sun Aug 1 01:56:48 2021 +0800

    add revert.txt

diff --git a/revert.txt b/revert.txt
new file mode 100644
index 0000000..190a180
--- /dev/null
+++ b/revert.txt
@@ -0,0 +1 @@
+123
```
- 如果有發生Conflict則無法使用`git revert`

### revert完是不自動commit

`git revert -n commitId`
- revert該commitId之後不會自動提交,要提交得用`git revert --continue`
- 如果要abort這次的revert操作, 則得用`git revert --abort`

`git revert --continue`
- 代表你已經完成所有操作，並且**建立一個新版本**，與`git commit`類似。

`git revert --abort`
- 代表你準備放棄這次revert的動作，執行這個命令會讓所有變更狀態還原，也就是刪除的檔案又會被加回來。

## `git cherry-pick`

- [Note Taking](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/21.md)    

cherry-pick : 從別人籃子中的 cherry 挑(pick up)幾個自己要的到自己的籃子內
- **從某個分支挑幾個自己想要的(commitments)到自己的分支**
 
For example, to pick up `branch1`'s commitments to main
-  `A,B,C` represent commitments of main and `branch1` 
```diff
mian_A---main_B--------------------------------main_C
     '
     '---branch1_A---branch1_B---branch1_C
```

```console
~$ git log branch1 -3 　# only show up first three logs of branch1 

brach1_A-->branch1_B-->bracn1_C
```

If we only want `branch1_B` and copy it to `main`   
Assume `branch1_B` commit Id is `dc07017....f2e5`  
```console
~$ git checkout main
~$ git cherry-pick dc07017
```

After `main` cherry-picks `branch1_B` 
```
mian_A--main_B------------------------------->main_C-->main_branch1_B
     '
     '--branch1_A-->branch1_B-->branch1_C
```
- 使用 `git cherry-pick` 跟使用 `git revert` 非常相似，也是讓你「挑選」任意一個或多個版本，然後套用在當前指定分支的最新版上，但主要差異則在於 `git revert` 執行的是相反的合併，而 `git cherry-pick` 則是重新套用完全相同的變更  

Branch main picks commit from Branch topic
![image](https://user-images.githubusercontent.com/68631186/127745456-aa5a7270-6fcd-41f8-a2b3-7ce16b9e8089.png)
- `git cherry-pick 2c33a -x` 則新增版本會提交`cherry picked from commit 2c33a....`訊息
- `git cherry-pick 2c33a -e`提交之前輸入自己要的訊息
- `git cherry-pick 2c33a -n`不會自動提交,待使用者自己更改`2c33a`的內容後並`git commit`,此時該新增版本`git log`會顯示該使用者的Author & Date 資訊

使用`git cherry-pick`時，work directory必須是乾淨，工作目錄下的Stage Area不能有任何準備要 commit 的檔案 (staged files) 在裡面，否則將會無法執行。

## `git reset COMMITID`

For example，我們有三個版本，如下  
![image](https://user-images.githubusercontent.com/68631186/127735620-a25ecda4-3c0a-462c-baf8-a3e071fca411.png)  

使用`git reset --hard HEAD^` 或 `git reset 9e5e6a4`  
![image](https://user-images.githubusercontent.com/68631186/127735671-591b07c9-b69d-4a5a-928b-8adcac4b9c73.png)  

使用 `git reset --hard ORIG_HEAD` 還原 master 上一次指的位置

`reset`的Mode
- 復原修改過的索引的狀態(mixed)
- 徹底取消最近的提交(hard)
- 只取消提交(soft)

| Mode    | HEAD的位置	| INDEX   |	Working Directory |
|---------|----------- |-------|----------|
| soft	  |  修改	    | 不修改 |  不修改  |
| mixed	  |  修改	    | 修改	  |  不修改  |
| hard	  |  修改	    | 修改	  |  修改    |


## Changing the Last Commit `git commit --amend`

[More Details](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History#_git_amend)  

如果不小心執行了`git commit`動作，但還有些檔案忘了加進去 (`git add [filepath]`) 或只是`紀錄訊息`寫錯，想重新補上的話，直接執行`git commit --amend`即可。  
- **這個動作，會把目前紀錄在索引中的變更檔案，全部添加到當前最新版之中，並且要求你修改原本的紀錄訊息**  

Add a new file in commit-version `b533ea`
```console
pi@JianMayer:~/Desktop/diffExample $ git log
commit b533ea4a2c6b5221efe2a6105e84c54b67397c85 (HEAD -> master)
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 05:32:29 2020 +0800

    using master

commit 13fe2431967e98aaf0d35c00901f671c6553a4d3
Merge: 9cdb14a 10b0d16
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 05:30:03 2020 +0800

    using ex.txt from master
```

To amend commit (e.g, add a new file, modify file ....)
```console
pi@JianMayer:~/Desktop/diffExample $ echo AddFileb533ea >> amend.txt
pi@JianMayer:~/Desktop/diffExample $ git add .

# amend a commit
pi@JianMayer:~/Desktop/diffExample $ git commit --amend
[master c48b2e1] using master AMENDING this COMMIT-VERSION BY ADDING NEW FILE NAMED amend.txt
 Date: Sat Jul 31 05:32:29 2021 +0800
 2 files changed, 1 insertion(+), 4 deletions(-)
 create mode 100644 amend.txt

# after amending commit
pi@JianMayer:~/Desktop/diffExample $ git log
commit c48b2e19f3b139566648a7fa7024a6a24a7331cf (HEAD -> master)
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 05:32:29 2020 +0800

    using master
    AMENDING this COMMIT-VERSION BY ADDING NEW FILE NAMED amend.txt
```


## rebase
- [git-scm](https://git-scm.com/book/zh/v2/Git-%E5%88%86%E6%94%AF-%E5%8F%98%E5%9F%BA)     
- [doggy8088](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/22.md)    

![image](https://user-images.githubusercontent.com/68631186/127741064-2d8f2263-a555-4e0e-8393-679df2b1c8f2.png)
- (topic) `git rebase main` : 從分歧點`169a6` rebase 到 branch main上

[Error `bash: $'\302\203git': command not found` for checking remote branches (in the remote repo)](https://newbedev.com/shell-bash-302-203git-command-not-found-code-example)   

```console
Schmi@MSI MINGW64 ~/Desktop/SpringBootFrontend (probieren) 
$ git remote -r

bash: $'\302\203git': command not found
```

After that we push current local commitment to remote repository's `main`  

```console
Schmi@MSI MINGW64 ~/Desktop/SpringBootFrontend (probieren) 
$ git push origin remotes/origin/main

Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To https://github.com/maxwolf621/SpringBootFrontend.git
 * [new reference]   origin/main -> origin/main
```

## Head detached

It means pointer `Head` does not point to any node, it might often happen when we `git checkout` the remote branch.
To solve such problem we can `checkout` a branch or `checkout -b` a new branch   

## `git merge` or `git rebase` the branches

![image](https://user-images.githubusercontent.com/68631186/127736291-d26756fc-3ab8-4fba-adea-4c51ed836c37.png)   

### Use `merge` to integer the branches
It performs a three-way merge between the two latest branch snapshots (`C3` and `C4`) and the most recent common ancestor of the two (`C2`), creating a new snapshot (and `commit`).   
![image](https://user-images.githubusercontent.com/68631186/127736382-d3ec1d77-ac2b-4eab-bd1e-537d6d42c0a3.png)  

### Use `rebase` instead of `merge`
With `rebase` you can take the patch of the change that was introduced in `C4` and reapply it on top of` C3`.  
- With this command , **you can take all the changes that were committed on one branch and replay them on a different branch.**

For this example, you (Owner of Local Repo) would check out the experiment branch, and then rebase it onto the master branch as follows:
```console
$ git checkout experiment # Go branch experiments
$ git rebase master       # experiments take master as its base branch
First, rewinding head to replay your work on top of it...
Applying: added staged command
```
**This operation works by going to the common ancestor of the two branches**  (the branch you’re on (`experiment`) and the one you’re rebasing onto(`master`)), **getting the diff introduced by each commit of the branch you’re on, saving those diffs to temporary files**, **resetting the current branch to the same commit as the branch you are rebasing onto(`C3`), and finally applying each change(temporary files) in turn.**

![image](https://user-images.githubusercontent.com/68631186/127736475-4f95bbcc-5442-4ec2-b73e-efef990a8a02.png)   
At this point, you (maintainer) can go back to the master branch and do a `fast-forward` merge.

```bash
$ git checkout master
$ git merge experiment
```
![image](https://user-images.githubusercontent.com/68631186/127736624-de257a44-dbe7-49a6-8c8b-6772116b57fa.png)

#### Diagram of merge and rebase

![image](https://user-images.githubusercontent.com/68631186/127771473-eaf43412-5841-4c4a-ad03-8f1192450adb.png)
- `bugFix` commits a new version `C6` that merges what master and bugFix* refs to  

![image](https://user-images.githubusercontent.com/68631186/127771480-56575fed-0915-44a7-961f-23c59234f7fc.png)
- 在做`rebase`時，實際動作是複製`C2`與`C3`這兩個commitments並把複製品(Copies)依序接到Branch master 上面，然後標註`C3'`是為Branch `bugFix`

The snapshot pointed to by `C4'` is exactly the same as the one that was pointed to by `C5` in the merge example. (is same snapshot )  

Rebase還可以用來修改某分支中特定的Commitments
- [範例](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/23.md#rebase-%E8%83%BD%E5%81%9A%E7%9A%84%E4%BA%8B)    
- 調換 commit 的順序
- 修改 commit 的訊息
- 插入一個 commit
- 編輯一個 commit
- 拆解一個 commit
- 壓縮一個 commit，且保留訊息紀錄
- 壓縮一個 commit，但丟棄版本紀錄
- 刪除一個 commit

`git merge -squash [branch_X]` 把branch_X每個commitments都**存在一個節點**並merge到你的branch上  
![image](https://user-images.githubusercontent.com/68631186/132136587-4ab304d0-1f8b-4365-8c04-b2b5aa90f9e2.png)   

`git rebase -i`   
![image](https://user-images.githubusercontent.com/68631186/132136600-93bfa772-b2db-4c1e-a4fc-c704bc0f8afa.png)


### Difference `rebase` with `merge` 

#### Good about Rebasing is that it makes for a cleaner history. 
- **It looks like a linear history in `git log`**
- It appears that all the work happened in series, even when it originally happened in parallel.

Doing this to make sure your commits apply cleanly on a remote branch — perhaps in a project to which you’re trying to contribute but that you don’t maintain.   
(一般我們這樣做的目的是為了確保在向Remote Branches推送時能保持提交歷史的整潔——例如向某個被其他人維護的項目貢獻程式碼時)

In this case, you’d do your work in a branch and then rebase your work onto `origin/master` when you were ready to submit your patches to the main project. That way, the maintainer doesn’t have to do any integration work — just a `fast-forward` or a clean apply.   
(在這種情況下，我們會先在自己的分支里進行開發，當開發完成時你需要先將你要commit程式碼變Rebase到`origin/master`上，然後再向main提交修改(`git commit`)。 這樣的話，該項目的維護者就不再需要進行整合工作，只需要快進合並(`fast forward`)便可)  

#### It’s only the history that is different.

Rebasing replays changes from one line of work onto another in the order they were introduced(`rebase`是把某Branch一系列commitments有時間順序性的依次加入到我們要rebase的Branch上), whereas merging takes the endpoints and merges them together(`merge`是將Branchs的Endpoints結合在(同時ref到)一個新的node).

```diff
rebae 
a--b--c--d--g--copy_of_h--copy_of_j--copy_of_k--copy_of_l
'--h--j--k--l

merge
a--b--c--d-g----NEW_NODE
'--h--j--k--l-----'
```
[DIAGRAM](https://dannyliu.me/%E4%BD%BF%E7%94%A8git-rebase%E4%BE%86%E5%90%88%E4%BD%B5%E5%88%86%E6%94%AF/)   

## `git pull –rebase` 

![image](https://user-images.githubusercontent.com/68631186/132130880-e2dca919-6423-4fe3-a961-0fd4ec41794a.png)
1.  take commitments out and put them to statsh to keep work directory clean
2. `pull` the branch from remote repository 
3. `merge` the branch from remote repository and the these we put in the stat 


Error `Cannot rebase: You have unstaged changes`
1. use `git status` to check if there are any modified files which havn't been committed
2. use `git add -A` instead of `git add .` to add all the files (`git add -u` : keep only modified and deletion files (No new created files allow)) 
