# Branch 

[YueLinHo - 認識 Git 物件的一般參照與符號參照](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/11.md)  

## 參照(Ref)

- Ref可以幫Branch取個好記的名稱(Aliases)
- 所有都是檔案存放在`.git/ref`下
  - 所有本地分支的ref都位於 `.git\refs\heads`
- **參照名稱可以指向任意Git物件，並沒有限定非要commit物件不可**

Under the Folder (`.git/ref`)
- Local  分支 : `.git/refs/heads/`
- Remote 分支 : `.git/refs/remotes/`
- Tag : `.git/refs/tags/`

利用Ref來查找分支版本資訊
```console
# Create new Local Branch f2e
pi@jian:~/Desktop/test$ git branch f2e
pi@jian:~/Desktop/test$ ls .git/refs/heads
f2e  main

# Show All the Refs
pi@jian:~/Desktop/test$ git show-ref
6b5748f8ef5623fa7de7ae0f1fcb238e653c0c93 refs/heads/f2e
6b5748f8ef5623fa7de7ae0f1fcb238e653c0c93 refs/heads/main
0f1743fb02b71ee57c87412122a32612b13c1685 refs/remotes/origin/HEAD
0f1743fb02b71ee57c87412122a32612b13c1685 refs/remotes/origin/main

# via commitId to checkout information
pi@jian:~/Desktop/test$ git cat-file -p 6b5748
tree 3a29533eb4820417cd550499986afb110ed44de4
parent 5466c9af32165b815bbcaf6c9c44b06d1793e7b5
author maxwolf621 <jervismayer@gmail.com> 1656255732 +0800
committer maxwolf621 <jervismayer@gmail.com> 1656315772 +0800

updated
here is amend a new commit

# via ref with absolute path
pi@jian:~/Desktop/test$ git cat-file -p refs/heads/f2e
tree 3a29533eb4820417cd550499986afb110ed44de4
parent 5466c9af32165b815bbcaf6c9c44b06d1793e7b5
author maxwolf621 <jervismayer@gmail.com> 1656255732 +0800
committer maxwolf621 <jervismayer@gmail.com> 1656315772 +0800

updated
here is amend a new commit

# via ref name
pi@jian:~/Desktop/test$ git cat-file -p f2e
tree 3a29533eb4820417cd550499986afb110ed44de4
parent 5466c9af32165b815bbcaf6c9c44b06d1793e7b5
author maxwolf621 <jervismayer@gmail.com> 1656255732 +0800
committer maxwolf621 <jervismayer@gmail.com> 1656315772 +0800

updated
here is amend a new commit

# git show where f2e's ref points to
pi@jian:~/Desktop/test$ git show f2e
commit 6b5748f8ef5623fa7de7ae0f1fcb238e653c0c93 (HEAD -> main, f2e)
Author: maxwolf621 <jervismayer@gmail.com>
Date:   Sun Jun 26 23:02:12 2022 +0800

    updated
    here is amend a new commit

diff --git a/create.md b/create.md
new file mode 100644
index 0000000..b4c191b
--- /dev/null
+++ b/create.md
@@ -0,0 +1 @@
+create new one
```

``git cat-file -p [REF]`查找過程
```diff
+ `git cat-file -p f2e` 
- .git/f2e --> 找不到此檔案
-  |- .git/refs/f2e --> 找不到此檔案
-  |---- .git/refs/tags/f2e --> 找不到此檔案
-  |------- .git/refs/heads/f2e --> 找到了參照名稱，以下就不繼續搜尋
-  |----------.git/refs/remotes/f2e
-  |-------------.git/refs/remotes/f2e/HEAD
```

## symref
`symref` references to `ref`

### 特別的符號參照

`HEAD` : 永遠會**指向Work Directory中所設定的「分支」當中的newest commit**   
每次`git commit`後，這個 HEAD 符號參照也會指向該分支最新的Commit物件。


`ORIG_HEAD` : 指向目前Commit物件的前一版**，經常用來復原上一次的版本變更


`FETCH_HEAD` : 使用遠端儲存庫時，可能會使用`git fetch`指令取回所有Remote Repo的物件。`FETCH_HEAD`則會**記錄遠端儲存庫中每個分支的`HEAD`的絕對名稱**


`MERGE_HEAD` : 執行合併工作時，**合併來源的Commit物件絕對名稱會被記錄在`MERGE_HEAD`中**

### Custom ref 

`git update-ref CUSTOM_REF CommitId` command can create a ref of a commit
```console
pi@jian:~/Desktop/diffExample $ git log
commit 2bba4398958622eaed6554fddc11c42a111e14ee (HEAD -> master, f2e)
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 00:52:54 2020 +0800

    2th version

commit 2a0a50f7822ab3b82015f6d9f8d25d86ac32820b
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 00:51:47 2020 +0800

    the first version

# CREATE A CUSTOM REF./git/InitialCommit
pi@jian:~/Desktop/diffExample $ git update-ref InitialCommit 2a0a 

pi@jian:~/Desktop/diffExample $ ls .git 
branches        config       HEAD   index  InitialCommit  objects
COMMIT_EDITMSG  description  hooks  info   logs           refs

pi@jian:~/Desktop/diffExample $ git cat-file -p InitialCommit
tree 54dec82800354e58e7979533aa5c56ef0d606c39
author Maxwolf621 <asdf@gmail.com> 1627663907 +0800
committer Maxwolf621 <asdf@gmail.com> 1627663907 +0800

the first version
```

## 相對名稱表示
- [認識 Git 物件的相對名稱](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/12.md)  
- [`git reflog`](https://www.atlassian.com/git/tutorials/refs-and-the-reflog)

![image](https://user-images.githubusercontent.com/68631186/127764031-90df1eba-72f0-4f0b-a40b-d9c1b7d8ac08.png)  

- 比較常見的 Git Repository，預設只會有一個*root Commit物件*，也就是我們最一開始建立的那個版本，又稱`Initial Commit`  
在一個 Git 儲存庫中，所有的 Commit物件 中，除了第一個Commit物件(Root Commit)外，任何其他Commit物件一定都會有一個以上的上層Commit物件(Parent commit)
	> 為什麼可能有多個Parent Commit物件? 因為你很有可能會合併兩個以上的分支到另一個分支裡，所以合併完成後的那個 Commit物件 就會有多個parent commit 物件
  
- [According to this](https://stackoverflow.com/questions/2221658/whats-the-difference-between-head-and-head-in-git)   
  > `~` : your ancestor  
  > `^` : your parents  
```diff
- G   H   I   J
   \ /     \ /
-   D   E   F
     \  |  / \
      \ | /   |
       \|/    |
-       B     C
         \   /
          \ /
-          A
A =      = A^0
B = A^   = A^1     = A~1
C = A^2
D = A^^  = A^1^1   = A~2
E = B^2  = A^^2
F = B^3  = A^^3
G = A^^^ = A^1^1^1 = A~3
H = D^2  = B^^2    = A^^^2  = A~2^2
I = F^   = B^3^    = A^^3^
J = F^2  = B^3^2   = A^^3^2
```
- 如果要找到`HEAD`的前一版本，我們會使用 `HEAD~` 或 `HEAD~1`
- 如果要找出另一個`f2e`分支的前兩個版本 (不含`f2e`的`HEAD`版本)，你則可以用`f2e~2`或用`f2e~~`

Both `~` and `^` on their own refer to the parent of the commit (`~~` and `^^` both refer to the grandparent commit, etc.)  

But they differ in meaning when they are used with numbers  
- `~2` means up two levels in the hierarchy, via the first parent if a commit has more than one parent  
- `^2` means the second parent where a commit has more than one parent (i.e. because it's a merge)  

如果你有一個ref為`C`，若要找到它的第一個上層 commit 物件
```diff
C^
C^1
C~
C~1
```
- 在沒有**分支**與**合併**的儲存庫中，關於`^1`與`~1`所表達的意思是完全相同的，都代表「前一版」，在有分支與合併的儲存庫中，他們有不同的意義


如果你要找到`C`的第二個上層 Commit物件 (在沒有合併的狀況下)
```diff
C^^
C^1^1
C~2
C~~
C~1~1
```
- 但你不能用`C^2`來表達*第二個上層 Commit物件*原因是在沒有合併的情況下，這個`C`只有一個上層物件而已，你只能用`C^2`代表｢your second parent 」

![image](https://user-images.githubusercontent.com/68631186/127706540-5ac47971-4c72-4aea-a778-44935e3351b7.png)  
![image](https://user-images.githubusercontent.com/68631186/127763923-ef3f28c6-61ab-4271-8638-54db6fa51cb2.png)  

## Tag 
[Note Taking](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/15.md)
- Git 物件包含 4 種物件類型，分別是 Blob, Tree, Commit 與 Tag 物件  
- 標籤的用途就是用來標記某一個「版本」或稱為「commit 物件」，以一個「好記的名稱」來幫助我們記憶【某個】版本。
- **Tag 物件會儲存在 Git 的物件儲存區當中 (`.git/objects/`)，並且會關聯到另一個 commit 物件，建立「標示標籤」時還能像建立 commit 物件時一樣包含「版本訊息**
- 在大部分的使用情境下，我們都會用「標示標籤」來建立「標籤物件」並且給予「版本訊息」，因為這種「標籤」才是 Git 儲存庫中「永久的物件」 
  > **儲存到「物件儲存庫(`.git/objects/`)」中的 Git Objects都是不變的，只有「Index」才是變動的**  

```console
pi@JianMayer:~/Desktop/diffExample $ git log -i
commit 2bba4398958622eaed6554fddc11c42a111e14ee (HEAD -> master, f2e)
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 00:52:54 2020 +0800

    2th version

commit 2a0a50f7822ab3b82015f6d9f8d25d86ac32820b
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 00:51:47 2020 +0800

    the first version
    
pi@JianMayer:~/Desktop/diffExample $ git tag first-Tag

pi@JianMayer:~/Desktop/diffExample $ ls .git/refs/tags
first-Tag
```

## Merge
[關於合併的基本觀念與使用方式](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/17.md)  

![image](https://user-images.githubusercontent.com/68631186/127764834-c8774d82-c305-4ec9-9ed9-6b4f265e8ad3.png)

```console
pi@JianMayer:~/Desktop/diffExample $ git checkout -b feature
Zu neuem Branch 'feature' gewechselt
# CHECK ALL BRANCHES
pi@JianMayer:~/Desktop/diffExample $ git branch
  f2e
* feature
  master
# CREATE/MODIFIED AND COMMIT
pi@jian:~/Desktop/diffExample $ echo 24 > ex.txt
pi@jian:~/Desktop/diffExample $ echo 25 > branchFeature.txt
pi@jian:~/Desktop/diffExample $ git add .

# Commit 
pi@jian:~/Desktop/diffExample $ git commit -m "Branch Features"
[feature 10b0d16] Branch Features
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 branchFeature.txt

# switch branch MASTER
pi@jian:~/Desktop/diffExample $ git checkout master
Zu Branch 'master' gewechselt

# CREATE/MODIFY/COMMIT
pi@jian:~/Desktop/diffExample $ echo new Line >> a.txt
pi@jian:~/Desktop/diffExample $ echo new Line >> ex.txt
pi@jian:~/Desktop/diffExample $ echo for master >> ex.txt
pi@jian:~/Desktop/diffExample $ cat ex.txt
4
new Line
for master
pi@jian:~/Desktop/diffExample $ git add .
pi@jian:~/Desktop/diffExample $ git commit -m "from master"
```
- 合併之前，要清楚自己在哪個分支
- 合併之前，請確保Work Directory是乾淨的
- 合併時請用`git merge [另一個分支]`來將另一個分支的變更合併回來
- **合併的過程會自動建立一個新Commit**

## Conflict 
合併不同分支時各分支版本不同造成的衝突
```console
# 在`master`以及`feature`上都有改到`ex.txt`的第一行
# 則在進行`git merge feature`時候會造成Conflict
pi@jian:~/Desktop/diffExample $ git merge feature
error: Mergen ist nicht m\u00f6glich, weil Sie nicht zusammengef\u00fchrte Dateien haben.
Hinweis: Korrigieren Sie dies im Arbeitsverzeichnis, und benutzen Sie
Hinweis: dann 'git add/rm <Datei>', um die Aufl\u00f6sung entsprechend zu markieren
Hinweis: und zu committen.
fatal: Beende wegen unaufgel\u00f6stem Konflikt.

# 利用git diff查看CONFLICT
pi@jian:~/Desktop/diffExample $ git diff
diff --cc ex.txt
index e8c8a77,a45fd52..0000000
--- a/ex.txt
+++ b/ex.txt
@@@ -1,3 -1,1 +1,7 @@@
++<<<<<<< HEAD
 +4
 +new Line
 +for master
++=======
+ 24
++>>>>>>> feature

# 利用git status查詢CONFLICT
pi@jian:~/Desktop/diffExample $ git status
Auf Branch master
Sie haben nicht zusammengef\u00fchrte Pfade.
 (beheben Sie die Konflikte und f\u00fchren Sie "git commit" aus)
  (benutzen Sie "git merge --abort", um den Merge abzubrechen)

Zum Commit vorgemerkte \u00c4nderungen:

	neue Datei:     branchFeature.txt

Nicht zusammengef\u00fchrte Pfade:
  (benutzen Sie "git add/rm <Datei>...", um die Aufl\u00f6sung zu markieren)

	von beiden ge\u00e4ndert:    ex.txt
# 利用gi ls-files查詢CONFLICT
pi@jian:~/Desktop/diffExample $ git ls-files -u
100644 b8626c4cff2849624fb67f87cd0ad72b163671ad 1	ex.txt
100644 e8c8a77933921240dfef482db46379e468d4b3e4 2	ex.txt
100644 a45fd52cc5891570d6299fab38643103c3955474 3	ex.txt
```
- 最爛的解決方法就是直接`git add .`後在`git commit`
  > 但會造成conflict的問題訊息也會一併`git commit`(可利用`git reset --hard ORIG_HEAD`回到`git commit`之前的一版)  

#### Best Solution For Conflict
手動解決
- 選擇是要來自`feature`分支的`ex.txt`內容還是`master`分支的`ex.txt`內容
```console
++<<<<<<< HEAD
 +4
 +new Line
 +for master
++=======
+ 24
++>>>>>>> feature
```
如果是選擇`master`的就刪除上述`+ 24`, `++>>>..feature` 以及 `++<<<...HEAD` 
```console
 +4
 +new Line
 +for master
```
刪除完儲存完後在`git add .`以及`git commit -m "Merge Commit"`  
