# Git

## Centralized Version (Zentrale Versionsverwaltung) und Distributed version control(Verteilte Versionsverwaltung)


[ref](https://git-scm.com/book/de/v2/Erste-Schritte-Was-ist-Versionsverwaltung%3F)  
Git : Verteilte Versionverwaltung   
SVN : Zentrale Versionverwaltung  

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208200656794.png"/> </div><br>


#### Zentrale Versionsverwaltung
- 有安全性問題 (mit dem sich viele Leute dann konfrontiert sahen)
- If that server goes down for an hour, then during that hour nobody can collaborate at all or save versioned changes to anything they’re working on. If the hard disk the central database is on becomes corrupted, and proper backups haven’t been kept, you lose absolutely everything 
- 每一個Fork支相當於kopieren一份完整的Repository

#### Verteilte Versionsverwaltung
Auf diese Weise kann, wenn ein Server beschädigt wird, jedes beliebige Repository von jedem beliebigen Anwenderrechner zurückkopiert werden und der Server so wiederhergestellt werden. Jede Kopie, ein sogenannter Klon (engl. clone), ist ein vollständiges Backup der gesamten Projektdaten.  
Auf diese Weise kann, wenn ein Server beschädigt wird, jedes beliebige Repository von jedem beliebigen Anwenderrechner zurückkopiert werden und der Server so wiederhergestellt werden.   
Jede Kopie, ein sogenannter Klon (engl. clone), ist ein vollständiges Backup der gesamten Projektdaten.  


## Branching Workflows

```console
# Ein Git-Repository anlegen
# Create A Git repository 
cd new_repository
git init
```
- Git Repository中Stage 的暫存區以及 History Git-Repository，History 存储所有Forks訊息，也會有一個`HEAD` Pointer指向目前Fork

![image](https://user-images.githubusercontent.com/68631186/127678754-c72c04c1-ddf4-4696-a408-29f238a2e6af.png)

- git add file/directories 
  > It means to track the file  
  > ![image](https://user-images.githubusercontent.com/68631186/127679125-d613cd95-08e6-4c31-932a-b71ee17f491e.png)  
  > The git add command takes a path name for either a file or a directory;   
  > if it’s a directory, the command adds all the files in that directory recursively.  
- git commit 把暂存区的修改提交到当前分支，提交之后Stage Area就被清空了
- git reset -- files 使用当前分支上的修改覆盖暂存区，用来撤销最后一次 git add files
- git checkout -- files 使用暂存区的修改覆盖工作目录，用来撤销本地修改

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208200014395.png"/> </div><br>

可以跳过暂存区域直接从分支中取出修改，或者直接提交修改到分支中。
- git commit -a 直接把所有文件的修改添加到暂存区然后执行提交
- git checkout HEAD -- files 取出最后一次修改，可以用来进行回滚操作

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208200543923.png"/> </div><br>

## 分支实现

使用指针将每个提交连接成一条时间线，HEAD 指针指向当前分支指针。

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203219927.png"/> </div><br>

新建分支是新建一个指针指向时间线的最后一个节点，并让 HEAD 指针指向新分支，表示新分支成为当前分支。

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203142527.png"/> </div><br>

每次提交只会让当前分支指针向前移动，而其它分支指针不会移动。

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203112400.png"/> </div><br>

合并分支也只需要改变指针即可。

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203010540.png"/> </div><br>

## 冲突

当两个分支都对同一个文件的同一行进行了修改，在分支合并时就会产生冲突。

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203034705.png"/> </div><br>

Git 会使用 \<\<\<\<\<\<\< ，======= ，\>\>\>\>\>\>\> 标记出不同分支的内容，只需要把不同分支中冲突部分修改成一样就能解决冲突。

```
<<<<<<< HEAD
Creating a new branch is quick & simple.
=======
Creating a new branch is quick AND simple.
>>>>>>> feature1
```

## Fast forward
Fast Forward是將mian分支指向合併的fork，但在這種模式下進行分支合併將會丟失丢分支訊息，也就不能在分支歷史上看出分支訊息  

避免此狀況,可以在合并時候加上`--no-ff`參數禁用Fast forward mode, 并且加上`-m` 在合并時產生一個新的commit    
```
$ git merge --no-ff -m "merge with no-ff" dev   
```

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/image-20191208203639712.png"/> </div><br>

## Stashing
在一个分Fork上操作之后，如果尚未有將修改commit到Fork上，此時進行切換Fork，則會導致另一个Fork上也能看到新的修改
> 因為所有分支都共用一个Work Dir

故可以使用`git stash`將當前Fork的修改做Stashing，當前Work dir的所有修改都將會被存到Stack中而不是Work Dir, 此時就可以安全的切换到別的分之上

```
$ git stash
Saved working directory and index state \ "WIP on master: 049d078 added the index file"
HEAD is now at 049d078 added the index file (To restore them type "git stash apply")
```

该功能可以用于 bug 分支的实现。如果当前正在 dev 分支上进行开发，但是此时 master 上有个 bug 需要修复，但是 dev 分支上的开发还未完成，不想立即提交。在新建 bug 分支并切换到 bug 分支之前就需要使用 git stash 将 dev 分支的未提交修改储藏起来。

## SSH 

- Git Repository和 Github 中心Repository透過SSH協定做傳輸

如果work dir不存在`.ssh`目錄，或`.ssh`文件下沒有`id_rsa`和`id_rsa.pub`的文件則可以利用該command建立ssh key
```console
$ ssh-keygen -t rsa -C "maxwolf@gmail.com"
```
- 生成的public key `id_rsa.pub` 的内容複製到Github Account settings的SSH Keys中

## .gitignore 文件

忽略以下文件：

- 操作系统自动生成的文件，比如缩略图；
- 编译生成的中间文件，比如 Java 编译产生的 .class 文件；
- 自己的敏感信息，比如存放口令的配置文件。

不需要全部自己编写，可以到 [https://github.com/github/gitignore](https://github.com/github/gitignore) 中进行查询。

## Git 命令一览

<div align="center"> <img src="https://cs-notes-1256109796.cos.ap-guangzhou.myqcloud.com/7a29acce-f243-4914-9f00-f2988c528412.jpg" width=""> </div><br>

比较详细的地址：http://www.cheat-sheets.org/saved-copy/git-cheat-sheet.pdf

### git diff
[More Detail](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/09.md#%E7%AC%AC-09-%E5%A4%A9%E6%AF%94%E5%B0%8D%E6%AA%94%E6%A1%88%E8%88%87%E7%89%88%E6%9C%AC%E5%B7%AE%E7%95%B0)

Diff (Unterschied)
> Es gibt verschiedene Möglichkeiten, die Unterschiede zwischen Commits anzuzeigen.  

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
# the newst version
commit 2bba4398958622eaed6554fddc11c42a111e14ee (HEAD -> master)
Author: asdf <1234@gmail.com>
Date:   Sat Jul 31 00:52:54 2020 +0800

    2th version

# the oder version
commit 2a0a50f7822ab3b82015f6d9f8d25d86ac32820b
Author: asdf <1234@gmail.com>
Date:   Sat Jul 31 00:51:47 2020 +0800

    the first version
```

`git diff commit commitId前四碼 commitId2前四碼`
```bash
$ git diff 2bba sa0a
diff --git a/ex.txt b/ex.txt
index d00491f..b8626c4 100644
--- a/ex.txt
+++ b/ex.txt
@@ -1 +1 @@
-1
+4
```
- `---` the older ex.txt
- `+++` the newer ex.txt
- `@@ -1 +1 @@`  `-` : older , `+` : new andd 1 means the headlines  

- 最常用的指令是 `git diff HEAD`，因為這代表你要拿「工作目錄」與「當前分支的最新版」進行比對。這種比對方法，不會去比對「索引」的狀態，所以各位必須區分清楚，你到底比對的是甚麼 tree 物件的來源
- `git diff --cached HEAD`，這個語法代表的是「當前的索引狀態」與「當前分支的最新版」進行比對。這種比對方法，不會去比對「工作目錄」的檔案內容，而是直接去比對「索引」與「目前最新版」之間的差異，這有助於你在執行 git commit 之前找出那些變更的內容，也就是你將會有哪些變更被建立版本的意思。
- `git diff commit1 commit2` 最常用的是 `git diff HEAD HEAD^` 這個命令可以跳過「索引」與「工作目錄」的任何變更，而是直接比對特定兩個版本。事實上 Git 是比對特定兩個版本 commit 物件內的那個 tree 物件。  
