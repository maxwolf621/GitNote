# BranchUsage 

## 參照(ref)名稱
[Note Taking](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/11.md)  

- 幫Branch取個好記的名稱
- 所有「本地分支」的參照名稱皆位於 `.git\refs\heads`
- 所有參照名稱都是檔案存放在`.git/ref`下
- 參照名稱可以指向任意 Git 物件，並沒有限定非要 commit 物件不可

`git branch` 取得所有分支名稱，並發現目前「工作目錄」是指向 newbranch1 這個分支。
此時我們透過`git log --pretty=oneline`即可取得該分支的所有版本紀錄。預設這些分支的「參照名稱」會指向分支的「最新版」，我們只要打開 `.git\refs\heads\newbranch1` 檔案的內容，就可以看出這是一個純文字檔而已，而且是指向版本歷史紀錄(History)中的「最新版」。最後再以`git cat-file -p 0bd0`取得該 commit 物件的內容，以及用`git show 0bd0`取得該版本的變更紀錄，藉此證明這些檔案就是「參照名稱」的主要用途

### under `.git/ref`

- 本地分支：.git/refs/heads/
- 遠端分支：.git/refs/remotes/
- 標　　籤：.git/refs/tags/

所以如果建立一個`f2e`相對參照
```bash
$ git branch f2e
$ls .git/refs/heads
f2e  master
$ git show-ref
2bba4398958622eaed6554fddc11c42a111e14ee refs/heads/f2e
2bba4398958622eaed6554fddc11c42a111e14ee refs/heads/master
```

利用相對參照不使用CommitId
```bash 
$ git cat-file -p 2bba
tree 75f26843ecc6349d161934b72e6fb3c957179a45
parent 2a0a50f7822ab3b82015f6d9f8d25d86ac32820b
author Maxwolf621 <jervismayer@gmail.com> 1627663974 +0800
committer Maxwolf621 <jervismayer@gmail.com> 1627663974 +0800

2th version
#--------------------------------------------------------------
$ git cat-file -p refs/heads/f2e
tree 75f26843ecc6349d161934b72e6fb3c957179a45
parent 2a0a50f7822ab3b82015f6d9f8d25d86ac32820b
author Maxwolf621 <jervismayer@gmail.com> 1627663974 +0800
committer Maxwolf621 <jervismayer@gmail.com> 1627663974 +0800

2th version
#--------------------------------------------------------------
$ git cat-file -p f2e
tree 75f26843ecc6349d161934b72e6fb3c957179a45
parent 2a0a50f7822ab3b82015f6d9f8d25d86ac32820b
author Maxwolf621 <jervismayer@gmail.com> 1627663974 +0800
committer Maxwolf621 <jervismayer@gmail.com> 1627663974 +0800

2th version
#---------git show [ref]---------------------------------------------
commit 2bba4398958622eaed6554fddc11c42a111e14ee (HEAD -> master, f2e)
Author: Maxwolf621 <jervismayer@gmail.com>
Date:   Sat Jul 31 00:52:54 2021 +0800

    2th version

diff --git a/ex.txt b/ex.txt
index d00491f..b8626c4 100644
--- a/ex.txt
+++ b/ex.txt
@@ -1 +1 @@
-1
+4
```
```diff
git cat-file -p f2e查找過程
- .git/f2e --> 找不到此檔案
-  |- .git/refs/f2e --> 找不到此檔案
-  |---- .git/refs/tags/f2e --> 找不到此檔案
-  |------- .git/refs/heads/f2e --> 找到了參照名稱，以下就不繼續搜尋
-  |----------.git/refs/remotes/f2e
-  |-------------.git/refs/remotes/f2e/HEAD

```

### symref

`symref` reference to `ref`

#### 特別的符號參照
- HEAD 永遠會**指向「工作目錄」中所設定的「分支」當中的「最新版」**。
  > 所以當你在這個分支執行 git commit 後，這個 HEAD 符號參照也會更新成該分支最新版的那個 commit 物件。
- ORIG_HEAD
  > 簡單來說就是 **HEAD refs this commit 物件的「前一版」**，經常用來復原上一次的版本變更
- FETCH_HEAD
  > 使用遠端儲存庫時，可能會使用 git fetch 指令取回所有遠端儲存庫的物件。這個 FETCH_HEAD 符號參考則會**記錄遠端儲存庫中每個分支的 HEAD (最新版) 的「絕對名稱**
- MERGE_HEAD
  > 當你執行合併工作時，「合併來源｣的 commit 物件絕對名稱會被記錄在 MERGE_HEAD 這個符號參照中。


### Custom ref 

利用`git update-ref CUSTOM_REF CommitId`
```bash
$ git log
commit 2bba4398958622eaed6554fddc11c42a111e14ee (HEAD -> master, f2e)
Author: Maxwolf621 <jervismayer@gmail.com>
Date:   Sat Jul 31 00:52:54 2021 +0800

    2th version

commit 2a0a50f7822ab3b82015f6d9f8d25d86ac32820b
Author: Maxwolf621 <jervismayer@gmail.com>
Date:   Sat Jul 31 00:51:47 2021 +0800

    the first version
$ git update-ref InitialCommit 2a0a #Create a ./git/InitialCommit
$ ls .git 
branches        config       HEAD   index  InitialCommit  objects
COMMIT_EDITMSG  description  hooks  info   logs           refs
$ git cat-file -p InitialCommit
tree 54dec82800354e58e7979533aa5c56ef0d606c39
author Maxwolf621 <jervismayer@gmail.com> 1627663907 +0800
committer Maxwolf621 <jervismayer@gmail.com> 1627663907 +0800

the first version

```


## 相對名稱表示
[Note Taking](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/12.md)  
- Symbol:  `^` 跟 `~`   
  > `~`的意義，代表「第一個上層 commit 物件」的意思。
  > `^` 代表的意思則是「擁有多個上層 commit 物件時，要代表第幾個第一代的上層物件」
 
### For example 
- 如果要找到 HEAD 的前一版本，我們會使用 `HEAD~` 或 `HEAD~1` 來表示「HEAD 這個 commit 物件的前一版」
- 如果你要找出另一個`f2e`分支的前兩個版本 (不含 f2e 的 HEAD 版本)，你則可以用`f2e~2`或用`f2e~~`

在沒有**分支**與**合併**的儲存庫中，關於`^1`與`~1`所表達的意思是完全相同的，都代表「前一版」
> 事實上在有分支與合併的儲存庫中，他們有不同的意義

比較常見的 Git 儲存庫，預設只會有一個「根 commit 物件」，也就是我們最一開始建立的那個版本，又稱「初始送交」(Initial Commit)。
> 「在一個 Git 儲存庫中，所有的 commit 物件中，除了第一個 commit 物件外，任何其他的 commit 物件一定都會有一個以上的上層 commit 物件(parent commit)」
>> 為什麼有可能有「一個以上」的上層 commit 物件呢？因為你很有可能會合併兩個以上的分支到另一個分支裡，所以合併完成後的那個 commit 物件就會有多個 parent commit 物件。

我們用個簡單的例子來證明這點，我們用 git cat-file -p [object_id] 來取得最前面兩筆 commit 物件的內容，藉此了解到每個 commit 物件確實一定會有 parent 屬性，並指向上層 commit 物件的絕對名稱，唯獨第一筆 commit 物件不會有 parent 屬性。如下圖示


如果你有一個[參照名稱](參照名稱)為 C，若要找到它的第一個上層 commit 物件：
C^
C^1
C~
C~1

如果你要找到它的第二個上層 commit 物件 (在沒有合併的狀況下)
C^^
C^1^1
C~2
C~~
C~1~1
```diff
- 但你不能用 C^2 來表達「第二個上層 commit 物件」
! 原因是在沒有合併的情況下，這個 C 只有一個上層物件而已，你只能用 C^2 代表｢上一層物件的第二個上層物件」
```
![image](https://user-images.githubusercontent.com/68631186/127706540-5ac47971-4c72-4aea-a778-44935e3351b7.png)

## Tag 
[Note Taking](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/15.md)
- 標籤的用途就是用來標記某一個「版本」或稱為「commit 物件」，以一個「好記的名稱」來幫助我們記憶【某個】版本。
- - Git 物件包含 4 種物件類型，分別是 Blob, Tree, Commit 與 Tag 物件  
- Tag 物件會儲存在 Git 的物件儲存區當中 (`.git\objects\`)，並且會關聯到另一個 commit 物件，建立「標示標籤」時還能像建立 commit 物件時一樣包含「版本訊息」
- 在大部分的使用情境下，我們都會用「標示標籤」來建立「標籤物件」並且給予「版本訊息」，因為這種「標籤」才是 Git 儲存庫中「永久的物件」。( 儲存到物件儲存庫中的 Git 物件都是不變的，只有索引才是變動的 )

```bash
$ git log -i
commit 2bba4398958622eaed6554fddc11c42a111e14ee (HEAD -> master, f2e)
Author: Maxwolf621 <adf@gmail.com>
Date:   Sat Jul 31 00:52:54 2021 +0800

    2th version

commit 2a0a50f7822ab3b82015f6d9f8d25d86ac32820b
Author: Maxwolf621 <asdf@gmail.com>
Date:   Sat Jul 31 00:51:47 2021 +0800

    the first version
$ git tag first-Tag
$ ls .git/refs/tags
first-Tag
```

## Merge
[Note Taking](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/17.md)  
```bash
# to branch feature
pi@JianMayer:~/Desktop/diffExample $ git checkout -b feature
Zu neuem Branch 'feature' gewechselt
# check all the branchs
pi@JianMayer:~/Desktop/diffExample $ git branch
  f2e
* feature
  master
# modified ex.txt
pi@JianMayer:~/Desktop/diffExample $ echo 24 > ex.txt
# stage area
pi@JianMayer:~/Desktop/diffExample $ echo 25 > branchFeature.txt
pi@JianMayer:~/Desktop/diffExample $ git add .
pi@JianMayer:~/Desktop/diffExample $ git commit -m "Branch Features"
[feature 10b0d16] Branch Features
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 branchFeature.txt
# to master
pi@JianMayer:~/Desktop/diffExample $ git checkout master
Zu Branch 'master' gewechselt

# modify and create a.txt and ex.txt
pi@JianMayer:~/Desktop/diffExample $ echo new Line >> a.txt
pi@JianMayer:~/Desktop/diffExample $ echo new Line >> ex.txt
pi@JianMayer:~/Desktop/diffExample $ echo for master >> ex.txt
pi@JianMayer:~/Desktop/diffExample $ cat ex.txt
4
new Line
for master
pi@JianMayer:~/Desktop/diffExample $ git staus
git: 'staus' ist kein Git-Befehl. Siehe 'git --help'.

Der \u00e4hnlichste Befehl ist
	status
pi@JianMayer:~/Desktop/diffExample $ git add .
pi@JianMayer:~/Desktop/diffExample $ git commit -m "from master"
```
```diff
- 合併之前，先看清楚自己在哪個分支
- 合併之前，請確保工作目錄是乾淨的
- 合併時請用 git merge [另一個分支] 來將另一個分支的變更合併回來
- 合併成功後，你可以利用 git log 查看版本紀錄，你可以發現「合併」的過程會自動建立一個新版本
```


### Confilict
在Master以及Feature的Branch上都有改到`ex.txt`的第一行,則在進行merge時候會造成Conflict
```bash
$ git merge feature
error: Mergen ist nicht m\u00f6glich, weil Sie nicht zusammengef\u00fchrte Dateien haben.
Hinweis: Korrigieren Sie dies im Arbeitsverzeichnis, und benutzen Sie
Hinweis: dann 'git add/rm <Datei>', um die Aufl\u00f6sung entsprechend zu markieren
Hinweis: und zu committen.
fatal: Beende wegen unaufgel\u00f6stem Konflikt.
#利用git diff查看
$ git diff
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

# --- 利用status查詢衝突的檔案 ---
pi@JianMayer:~/Desktop/diffExample $ git status
Auf Branch master
Sie haben nicht zusammengef\u00fchrte Pfade.
 (beheben Sie die Konflikte und f\u00fchren Sie "git commit" aus)
  (benutzen Sie "git merge --abort", um den Merge abzubrechen)

Zum Commit vorgemerkte \u00c4nderungen:

	neue Datei:     branchFeature.txt

Nicht zusammengef\u00fchrte Pfade:
  (benutzen Sie "git add/rm <Datei>...", um die Aufl\u00f6sung zu markieren)

	von beiden ge\u00e4ndert:    ex.txt
# --- files 查詢衝突檔案---
 git ls-files -u
100644 b8626c4cff2849624fb67f87cd0ad72b163671ad 1	ex.txt
100644 e8c8a77933921240dfef482db46379e468d4b3e4 2	ex.txt
100644 a45fd52cc5891570d6299fab38643103c3955474 3	ex.txt
```
- 最爛的解決方法就是`git add .`在`git commit`則conflict的問題也會一併Commit
  > 可利用`git reset --hard ORIG_HEAD`回到`git commit`之前的一版 

選擇是要來自feature的`ex.txt`內容還是master的`ex.txt`內容
```console
++<<<<<<< HEAD
 +4
 +new Line
 +for master
++=======
+ 24
++>>>>>>> feature
```
如果是選擇Master的就刪除上述`+ 24`, `++>>>..feature` 以及 `++<<<...HEAD` 
```console
 +4
 +new Line
 +for master
```
刪除完儲存完後在`git add .`以及`git commit -m "..."`然後do `merge` 