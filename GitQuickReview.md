# Git Auf Grundlage zurückblicken

## Centralized Version Control(Zentrale Versionsverwaltung) und Distributed Version Control(Verteilte Versionsverwaltung)
[Reference](https://git-scm.com/book/de/v2/Erste-Schritte-Was-ist-Versionsverwaltung%3F)    

![image](https://user-images.githubusercontent.com/68631186/127731972-f44b02bd-493f-408a-b991-9a83a5ec3eda.png)
- Git : Verteilte Versionsverwaltung   
- SVN : Zentrale Versionsverwaltung  

#### Zentrale Versionsverwaltung
- Sicherheitsproblem, mit dem sich viele Leute dann konfrontiert sahen
- If the server goes down for an hour, then during that hour nobody can collaborate at all or save versioned changes to anything they’re working on. If the hard disk the central database is on becomes corrupted, and proper backups haven’t been kept, you lose absolutely everything 
- **每一個Branch支相當於kopieren一份完整的Repository**

#### Verteilte Versionsverwaltung
- Auf diese Weise kann, wenn ein Server beschädigt wird, jedes beliebige Repository von jedem beliebigen Anwenderrechner zurückkopiert werden und der Server so wiederhergestellt werden. Jede Kopie, ein sogenannter Klon (engl. clone), ist ein vollständiges Backup der gesamten Projektdaten.  

## Branching Workflows
[Branch Einführung](https://backlog.com/git-tutorial/tw/stepup/stepup1_1.html)  
[Git Objects](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/07.md)   

![image](https://user-images.githubusercontent.com/68631186/131378392-cf52c378-b7f0-43a3-9eec-a1ccfb549f10.png)

Wenn wir ein Git Repository anlegen
```console
# Create A Git repository 
cd new_repository
git init
```
![image](https://user-images.githubusercontent.com/68631186/127678754-c72c04c1-ddf4-4696-a408-29f238a2e6af.png)  
- Die vier oben in der Grafik erwähnten Kommandos kopieren Dateien zwischen dem **Arbeitsverzeichnis(Work Dir)**, dem **Index (stage)** und dem **Projektarchiv (history)**.
  > ![image](https://user-images.githubusercontent.com/68631186/127700556-02dd0d20-bfae-4f9a-9207-3dd2d8a012dd.png)
- `git add file/directories` 
  > kopiert die Dateien aus dem Arbeitsverzeichnis in ihrem aktuellen Zustand in den Index.
  > ![image](https://user-images.githubusercontent.com/68631186/127679125-d613cd95-08e6-4c31-932a-b71ee17f491e.png)  
  > The git add command takes a path name for either a file or a directory; if it’s a directory, the command adds all the files in that directory recursively.  
- `git commit -m`把Stage Area的Modified `commit`到Current Branch
  > Es speichert einen Schnappschuss des Indexes als Commit im Projektarchiv.
  > After `commit`, Stage Area會將Stage File(s)清除 
- `git reset -- files` 使用目前Branch上的Modified在Stage Area內的Stage Files，用来撤銷(withdraw)最後一次的`git add files`
  > es entfernt geänderte Dateien aus dem Index; dazu werden die Dateien des letzten Commits in den Index kopiert. Damit kannst du ein `git add Dateien` rückgängig machen. Mit `git reset` kannst du alle geänderten Dateien aus dem Index entfernen.
- `git checkout -- files` 使用Stage Area的Modified更新Work Directory撤銷(withdraw)本地Modified
   >  kopiert Dateien aus dem Index in das Arbeitsverzeichnis. Damit kannst du die Änderungen im Arbeitsverzeichnis verwerfen.  
- [`git status`](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/07.md#git-status)

Es ist auch möglich, den Index zu überspringen und Dateien direkt aus dem Archiv (history) auszuchecken oder Änderungen im Arbeitsverzeichnis direkt zu committen
1. Directly Fetch Modified for Branch
2. `commit` Modified to Branch
![image](https://user-images.githubusercontent.com/68631186/127697166-273744d4-d796-44d6-b71d-65ec07831035.png)

```bash
git commit -a 
```
- Es ist gleichbedeutend mit `git add` auf allen **im letzten Commit bekannten Dateien**, gefolgt von einem `git commit`.


```bash
git commit files
```
- Es erzeugt einen neuen Commit mit dem Inhalt aller aufgeführten Dateien aus dem Arbeitsverzeichnis. Zusätzlich werden die Dateien in den Index kopiert.


```bash
git checkout HEAD --files 
```
- Es kopiert die Dateien vom letzten Commit sowohl in den Index als auch in das Arbeitsverzeichnis.

## Branch Diagram
- [Branch Usage](BranchUsage.md)  
- [Branch](https://medium.com/i-think-so-i-live/git%E4%B8%8A%E7%9A%84%E4%B8%89%E7%A8%AE%E5%B7%A5%E4%BD%9C%E6%B5%81%E7%A8%8B-10f4f915167e)
- [doggy8088](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/08.md)  

使用Pointer將Each Commit連接成一條時間線，其中HEAD指向Current Branch   
<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203219927.png"/> </div><br>

#### git branch

`git Branch newBranch`新建一個Ref指向最後(最新的)一個node 
- [symref `HEAD`](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#symref)

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203142527.png"/> </div><br>


#### git commit -m
`git commit -m COMMIT_COMMENT`後會讓Current Branch的Ref向前移動(其他Branch的ref不做改變)
<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203112400.png"/> </div><br>

#### git merge 

`git merge BRANCH`改變ref指向的地方
<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203010540.png"/> </div><br>

## [Conflict](https://github.com/maxwolf621/GitNote/blob/main/BranchUsage.md#confilict)

兩個分支同個文件同時修改造成修改後內容不一致導致使用`git merge BRANCH`時候產生Conflict    
![image](https://user-images.githubusercontent.com/68631186/127732570-470a1cc0-4a1a-4d0e-87e1-660ec34f7e75.png)

解決方法

```bash
# 選擇使用issue2,或者issue1其中一方的內容
# 此時文檔內容會出像兩個issue的不一樣之處
++<<<<<<< HEAD
+4
+new Line
+for master
++=======
+ 24
++>>>>>>> feature
```

選擇issue1 (把其它不屬於issue1的內容刪掉)
```
+4
+new Line
+for master
```
更改內容後提交
```bash
git add .
git commit -m "COMMIT_INFORMATION_NOTE"
```

## Fast Forward Mode(Rebase)

Fast Forward Mode是將(branch) main指向要合併的Branch，但在這種模式下進行分支合併將會丟失分支的Information(造成不能在分支歷史上看出個別分支訊息)   

要避免這種狀況,可以在`merge`時候加上`--no-ff`禁用Fast Forward, 再額外加上`-m`則merge時會產生一個新的Commit    
```console
git merge --no-ff -m "merge with no-ff" dev   
```
<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203639712.png"/> </div><br>

## Stashing

To store or hide something, especially a large amount

當在某個Branch X上進行維護時，未能將Modified Files做commit時，就進行切換至另一個Branch Y，會導致Y也能看到X上面的Modified Files, 這是因為所有Branches都共用一个Work Directory  

所以可以使用`git stash`將當前Branch X的上未commit的Modified Files做Stashing，此時Work directory的所有Modified Files都將會被存到Stack中而不是Work Directory內, 就可以安全的切换到別的Branch上   

For example :: 假如目前正在Branch dev上進行開發(Develope)，但此時Branch main上有個bug需要處理, 但dev上的tasks目前未完成, 又不想立即提交`commit`, 我們可以在切换Branch main之前利用`git stash`將dev上未完成還沒有commit的Modified Data `stash`起來  　　
```bash
git stash

Saved working directory and index state \ "WIP on master: 049d078 added the index file"
HEAD is now at 049d078 added the index file (To restore them type "git stash apply")
```

## SSH 
Git Repository和Github中Repository透過SSH協定做傳輸   

如果Work Directory不存在`.ssh`目錄，或`.ssh`文件下沒有`id_rsa`和`id_rsa.pub`的文件則可以利用該command建立ssh key   
```console
ssh-keygen -t rsa -C "maxwolf@gmail.com"
```
- 將該指令所生成的public key `id_rsa.pub`的内容複製到Github Account settings中的SSH Keys中

## .gitignore 文件
[More Details](https://www.atlassian.com/git/tutorials/saving-changes/gitignore)  

> [.gitignore Templates](https://github.com/github/gitignore)

Told Git 忽略(ignore) 以下文件：
1. O.S (自動產的Hidden System)的文件
   > e.g `DS_Store` and `thumbs.db` ...etc
2. Compiled Code
   > e.g Java `.class`, `pyc` ...etc
3. personal IDE config files
   > e.g. `.idea/workspace.xml` ...etc
4. files generated at runtime
   > e.g. `.log`, `.lock` or `.tmp`
5. dependency caches
   > the contents of `/node_modules` or `/packages`
6. Build output directories
   > e.g. `/bin`, `/out`, or `/target`

  
## Git Cheat Sheet

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/7a29acce-f243-4914-9f00-f2988c528412.jpg" width=""> </div><br>

- [Cheat Sheet PDF download](http://www.cheat-sheets.org/saved-copy/git-cheat-sheet.pdf)  

## git diff
- [More Detail](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/09.md#%E7%AC%AC-09-%E5%A4%A9%E6%AF%94%E5%B0%8D%E6%AA%94%E6%A1%88%E8%88%87%E7%89%88%E6%9C%AC%E5%B7%AE%E7%95%B0)

Diff (Unterschied) ::
Es gibt verschiedene Möglichkeiten, **die Unterschiede zwischen Commits anzuzeigen.**

Nachfolgend ein paar Beispiele.  
![image](https://user-images.githubusercontent.com/68631186/127685366-ca3dd94b-285a-428a-b6a3-f1d3fc9c096b.png)

```bash
~/Desktop/diffExample $ echo 1 > ex.txt
~/Desktop/diffExample $ echo 2 > ex2.txt
~/Desktop/diffExample $ git add .
~/Desktop/diffExample $ git commit "the first version"
~/Desktop/diffExample $ echo 3 > ex.txt
~/Desktop/diffExample $ echo 4 > ex.txt
~/Desktop/diffExample $ git add .
~/Desktop/diffExample $ git commit -m "2th version"
```

```bash
# using git log to get commit id
~/Desktop/diffExample $ git log
# the newest version
commit 2bba4398958622eaed6554fddc11c42a111e14ee (HEAD -> master)
Author: asdf <1234@gmail.com>
Date:   Sat Jul 31 00:52:54 2020 +0800

    2th version

# the older version
commit 2a0a50f7822ab3b82015f6d9f8d25d86ac32820b
Author: asdf <1234@gmail.com>
Date:   Sat Jul 31 00:51:47 2020 +0800

    the first version
```


#### `git diff commit commitId_前四碼 commitId2_前四碼`
- [commitId絕對名稱](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/10.md)

```console
$ git diff 2bba sa0a
diff --git a/ex.txt b/ex.txt
index d00491f..b8626c4 100644
--- a/ex.txt
+++ b/ex.txt
@@ -1 +1 @@
-1
+4
```
```diff
! `---`  : the older ex.txt
! `+++` : the newer ex.txt
- `@@ -1 +1 @@` : 
-      `-` : older , `+` : newer 
-        1 : means the total of headlines  
```

![image](https://user-images.githubusercontent.com/68631186/175825708-6ff42f8f-8eb1-4ceb-a5d6-df870cf0c429.png)
- (OFTEN) `git diff HEAD` allows you to compare the file version in your working directory with the file version last committed in your remote repository.
- `git diff --cached HEAD`，**表「當前的索引狀態」與「當前分支的最新版」進行比對**  
這種比對方法，不會去比對「工作目錄」的檔案內容，而是直接去比對「索引」與「目前最新版」之間的差異，助於在`git commit`之前找出那些變更的內容
- `git diff commit1 commit2` 最常用的是 `git diff HEAD HEAD^` 這個命令可以**跳過「索引」與「工作目錄」的任何變更**，而是直接比對特定兩個版本, 事實上 Git 是比對特定兩個版本 commit 物件內的那個 tree 物件。  
