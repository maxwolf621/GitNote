###### tags : `git`
# Git版本控制

## 版本控管的基本原則
[Note Taking](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/18.md)  

維持一個良好的版本紀錄有助於我們追蹤每個版本的更新歷程,在實務上，當軟體的臭蟲(Bug)發生的時候，我們會需要去追蹤特定**臭蟲的歷史紀錄**，以查出該臭蟲真正發生的原因，這個時候就是版本控管帶來最大價值的時候。

原則
- 做一個小功能修改(Modifiedd)就建立版本(commit)，這樣才容易追蹤變更
- 千萬不要累積一大堆修改後才建立一個「大版本」
- 有邏輯、有順序的修正功能，確保相關的版本修正可以**按順序提交(commit)**，這樣才便於追蹤


## 修正 commit 歷史紀錄的理由
**大部分的 Git 操作都還專注在本地端，也就是在工作目錄下的版本管控，這個儲存庫就位於你的 .git/ 目錄下**, 但「遠端儲存庫」的應用，到時就不只一個人擁有儲存庫，所需要注意的細節也就更多。

在 Git 版本控管中，**只要同一份儲存庫有多人共用的情況下，若有人任意竄改版本，那麼 Git 版本控管一樣會無法正常運作**  

### 更改使用情境

假設我們現在有三個版本如下 
```diff
[A] -> [B] -> [C] 
```
可能會發生以下情況
1. `[C]`版本你發現`commit`錯了，必須刪除這一版本所有變更
2. `commit`了之後才發現`[C]`這個版本其實只有測試程式碼，你也想刪除他
3. 其中有些版本的紀錄訊息有錯字，你想修改訊息文字，但不影響檔案的變更歷程
4. 想把這些版本的`commit`順序調整為 `[A] -> [C] -> [B]`，讓版本演進更有邏輯性
5. 發現`[B]`這個版本忘了加入一個重要的檔案就`commit`了，你想事後補救這次變更
6. 在你打算分享分支出去時，發現了程式碼有瑕疵，你可以修改完後再分享出去

### 修正 commit 歷史紀錄的注意事項

**Git保留了「修改版本歷史紀錄」的機制，主要是希望你能在「自我控管版本」到了一定程度後，自己整理一下版本紀錄的各種資訊，好讓你將版本「發布」出去後，讓其他人能夠更清楚的理解你對這些版本到底做了哪些修改。**

修改版本歷史紀錄時，有些事情必須特別注意:
```diff
- 一個Repository可以有許多Branchs (預設分支名稱為 main)
- 分享 Git 原始碼的最小單位是以「分支」為單位
- 你可以任意修改某個支線上的版本，只要你還沒「分享」給其他人
- 當你「分享」特定分支給其他人之後，這些「已分享」的版本歷史紀錄就別再改了
```


## `git revert` 

[According to gitbook.tw](https://gitbook.tw/chapters/rewrite-history/reset-revert-and-rebase.html)   
**新增一個Commit 來反轉（或說取消）另一個Commit 的內容，原本的 Commit 依舊還是會保留在歷史紀錄中。雖然會因此而增加 Commit 數，但通常比較適用於已經推出去的 Commit，或是不允許使用 Reset 或 Rebase 之修改歷史紀錄的指令的場合**    
> 如果是自己一個人做的專案，用 Revert 指令其實有點過於「禮貌」了，大部份都是直接使用 Reset 就好。但如果對於多人共同協作的專案，也許因為團隊開發的政策，你不一定有機會可以使用 Reset 指令，**這時候就可以 Revert 指令來做出一個「取消」的 Commit，對其它人來說也不算是「修改歷史」，而是新增一個 Commit，只是剛好這個 Commit 是跟某個 Commit 反向的操作而已。**


for example
```console
pi@JianMayer:~/Desktop/diffExample $ echo 123 > revert.txt
pi@JianMayer:~/Desktop/diffExample $ git add revert.txt
pi@JianMayer:~/Desktop/diffExample $ git commit -m "add revert.txt"
[master b29b246] add revert.txt
 1 file changed, 1 insertion(+)
 create mode 100644 revert.txt
pi@JianMayer:~/Desktop/diffExample $ git log -1
commit b29b2464feec76d5f5a792bed4aabddd0492a793 (HEAD -> master)
Author: Maxwolf621 <1234@gmail.com>
Date:   Sun Aug 1 01:56:48 2020 +0800

    add revert.txt
pi@JianMayer:~/Desktop/diffExample $ git revert b29b2464
[master e659d5e] Revert "add revert.txt" Execute git revert b29b2364
 1 file changed, 1 deletion(-)
 delete mode 100644 revert.txt
```
After enter `git revert b29b2464`
```bash
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

After editing and committing
```console
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

```diff
- 如果有發生Conflict則無法使用`git revert`反悔
```
### revert完不自動commit

```diff
git revert -n commitId
- revert 該commitId之後不自動提交,之後如果要提交得用`git revert --continue`
- 如果要withdraw這次的revert操作, 則得用`git revert --abort`

git revert --continue 
- 代表你已經完成所有操作，並且建立一個新版本，就跟執行 git commit 一樣。
git revert --abort 
- 代表你準備放棄這次復原的動作，執行這個命令會讓所有變更狀態還原，也就是刪除的檔案又會被加回來。
```

## `git cherry-pick`
[Note Taking](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/21.md)  

```diff
- cherry-pick : 從別人籃子中的cherry挑(pick)幾個自己要的到籃子內(從別的分支挑幾個自己想要的到自己的分支)

+ For example
+ soruce tree (main, branch1)

mian_A--main_B------------------------------->main_C
     '--branch1_A-->branch1_B-->branch1_C

! git log branch1 -3 #only show up first three logs

...--brach1_A-->branch1_B-->bracn1_c

# If we only want branch1_B and copy it to master 
# Assume branch1_B commit is dc07017....f2e5
! $ git cherry-pick dc07017

mian_A--main_B------------------------------->main_C-->main_branch1_B
     '--branch1_A-->branch1_B-->branch1_C
```

使用`git cherry-pick`跟使用`git revert`非常相似，也是讓你「挑選」任意一個或多個版本，然後套用在目前分支的最新版上，但主要差異則在於「`git revert`執行的是相反的合併，而`git cherry-pick` 則是重新套用完全相同的變更」  

![image](https://user-images.githubusercontent.com/68631186/127745456-aa5a7270-6fcd-41f8-a2b3-7ce16b9e8089.png)
- `git cherry-pick 2c33a -x` 則新增版本會提交`cherry picked from commit 2c33a....`訊息
- `git cherry-pick 2c33a -e`提交之前輸入自己要的訊息
- `git cherry-pick 2c33a -n`不會自動提交,待使用者自己更改`2c33a`的內容後並`git commit`,此時該新增版本`git log`會顯示該使用者的Author & Date 資訊

```diff
! 使用`git cherry-pick`時，當前「工作目錄」必須是乾淨，工作目錄下的Stage Area不能有任何準備要 commit 的檔案 (staged files) 在裡面，否則將會無法執行。
```

## `git reset COMMITID`

例如我們有三個版本  
![image](https://user-images.githubusercontent.com/68631186/127735620-a25ecda4-3c0a-462c-baf8-a3e071fca411.png)  

使用`git reset --hard HEAD^` OR `git reset 9e5e6a4`  
![image](https://user-images.githubusercontent.com/68631186/127735671-591b07c9-b69d-4a5a-928b-8adcac4b9c73.png)  

使用`git reset --hard ORIG_HEAD`還原master上一次指的位置

## Changing the Last Commit `git commit --amend`

[More Details](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History#_git_amend)  

如果不小心執行了`git commit`動作，但還有些檔案忘了加進去 (`git add [filepath]`) 或只是`紀錄訊息`寫錯，想重新補上的話，直接執行`git commit --amend`即可。  
- **這個動作，會把目前紀錄在索引中的變更檔案，全部添加到當前最新版之中，並且要求你修改原本的紀錄訊息**  


```bash
#---add a new file in commit-version b533ea---
pi@JianMayer:~/Desktop/diffExample $ git log
commit b533ea4a2c6b5221efe2a6105e84c54b67397c85 (HEAD -> master)
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 05:32:29 2020 +0800

    usng master

commit 13fe2431967e98aaf0d35c00901f671c6553a4d3
Merge: 9cdb14a 10b0d16
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 05:30:03 2020 +0800

    using ex.txt from master
pi@JianMayer:~/Desktop/diffExample $ echo AddFileb533ea >> amend.txt
pi@JianMayer:~/Desktop/diffExample $ git add .
pi@JianMayer:~/Desktop/diffExample $ git commit --amend
[master c48b2e1] usng master AMENDING this COMMIT-VERSION BY ADDING NEW FILE NAMED amend.txt
 Date: Sat Jul 31 05:32:29 2021 +0800
 2 files changed, 1 insertion(+), 4 deletions(-)
 create mode 100644 amend.txt
pi@JianMayer:~/Desktop/diffExample $ git log
commit c48b2e19f3b139566648a7fa7024a6a24a7331cf (HEAD -> master)
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 05:32:29 2020 +0800

    usng master
    AMENDING this COMMIT-VERSION BY ADDING NEW FILE NAMED amend.txt
```

## rebase

[note taking](https://git-scm.com/book/zh/v2/Git-%E5%88%86%E6%94%AF-%E5%8F%98%E5%9F%BA)    
[from doggy8088 note taking](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/22.md)   

![image](https://user-images.githubusercontent.com/68631186/127741064-2d8f2263-a555-4e0e-8393-679df2b1c8f2.png)
- 從分歧點`169a6`rebase到main這條branch上

## Example 
![image](https://user-images.githubusercontent.com/68631186/127736291-d26756fc-3ab8-4fba-adea-4c51ed836c37.png)
#### Use `merge` to interage the branches
It performs a three-way merge between the two latest branch snapshots (`C3` and `C4`) and the most recent common ancestor of the two (`C2`), creating a new snapshot (and `commit`).   
![image](https://user-images.githubusercontent.com/68631186/127736382-d3ec1d77-ac2b-4eab-bd1e-537d6d42c0a3.png)  

#### Use `rebase` instead of `merge`

With `rebase` you can take the patch of the change that was introduced in `C4` and reapply it on top of` C3`.  
- With this command , **you can take all the changes that were committed on one branch and replay them on a different branch.**

For this example, you would check out the experiment branch, and then rebase it onto the master branch as follows:
```bash
$ git checkout experiment
$ git rebase master
First, rewinding head to replay your work on top of it...
Applying: added staged command
```

**This operation works by going to the common ancestor of the two branches**  (the one you’re on(`experiment`) and the one you’re rebasing onto(`master`)),**getting the diff introduced by each commit of the branch you’re on, saving those diffs to temporary files**, **resetting the current branch to the same commit as the branch you are rebasing onto(`C3`), and finally applying each change(temporary files) in turn.**

![image](https://user-images.githubusercontent.com/68631186/127736475-4f95bbcc-5442-4ec2-b73e-efef990a8a02.png)

At this point, you can go back to the master branch and do a fast-forward merge.
```bash
$ git checkout master
$ git merge experiment
```
![image](https://user-images.githubusercontent.com/68631186/127736624-de257a44-dbe7-49a6-8c8b-6772116b57fa.png)


### Compare `rebase` with `merge` 

the snapshot pointed to by `C4'` is exactly the same as the one that was pointed to by `C5` in the merge example. (is same snapshot )

Good about Rebasing is that it makes for a cleaner history. 
- It looks like a linear history in `git log`
  > It appears that all the work happened in series, even when it originally happened in parallel.

Doing this to make sure your commits apply cleanly on a remote branch — perhaps in a project to which you’re trying to contribute but that you don’t maintain.    
In this case, you’d do your work in a branch and then rebase your work onto `origin/master` when you were ready to submit your patches to the main project.  
That way, the maintainer doesn’t have to do any integration work — just a fast-forward or a clean apply.
> 一般我们这样做的目的是为了确保在向远程分支推送时能保持提交历史的整洁——例如向某个其他人维护的项目贡献代码时。 在这种情况下，你首先在自己的分支里进行开发，当开发完成时你需要先将你的代码变基到 origin/master 上，然后再向主项目提交修改。 这样的话，该项目的维护者就不再需要进行整合工作，只需要快进合并便可

> It’s only the history that is different.
>> Rebasing replays changes from one line of work onto another in the order they were introduced(把某Branch一系列commits有時間順序性的依次應用到rebase的Branch上), whereas merging takes the endpoints and merges them together(將branchs的endpoints結合在一起).


[DIAGRAM](https://dannyliu.me/%E4%BD%BF%E7%94%A8git-rebase%E4%BE%86%E5%90%88%E4%BD%B5%E5%88%86%E6%94%AF/)

![image](https://user-images.githubusercontent.com/68631186/127771473-eaf43412-5841-4c4a-ad03-8f1192450adb.png)
- bugFix commits and merges what master refs to  
![image](https://user-images.githubusercontent.com/68631186/127771480-56575fed-0915-44a7-961f-23c59234f7fc.png)
- 在做rebase時，git實際動作是複製C2與C3這兩個commit並把複製品接到master上面，然後標註C3'是bugFix分支
### Rebase 能做的事
- 將某個分支當成自己目前分支的「基礎版本」。除了這件事以外，你還可以用來修改某個分支中「特定一段」歷程的紀錄，你可以做的事情包括：
```diff
- 調換 commit 的順序
- 修改 commit 的訊息
- 插入一個 commit
- 編輯一個 commit
- 拆解一個 commit
- 壓縮一個 commit，且保留訊息紀錄
- 壓縮一個 commit，但丟棄版本紀錄
- 刪除一個 commit
```
[範例](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/23.md#rebase-%E8%83%BD%E5%81%9A%E7%9A%84%E4%BA%8B)  
