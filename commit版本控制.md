
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

## `git reset COMMIT_VERSION`

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
