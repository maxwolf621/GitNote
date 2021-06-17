############################################################################# 
#[reference](https://opensource.com/article/19/7/create-pull-request-github)#
#############################################################################

#########################
#Downloading the Project# 
#########################
#* git clone https://github.com/<YourUserName>/<Your_Downloading_ProjectName_From_Github>
git clone https://github.com/maxwolf621/OauthUser


######################################################################
# Once the repo is cloned, you need to do two things to creat a Fork #
######################################################################
#* Create a new branch by issuing the command: 
git checkout -b new_branch

#* Create a new remote for the `upstream repo` with the command:
#* In this case, "upstream repo" refers to the original repo you created your fork from.
git remote add upstream https://github.com/maxwolf621/OauthUser

#* Now you can make changes to the code. The following code creates a new branch, makes an arbitrary change, and pushes it to new_branch:


#################################################################################################################
# delete file and push it to github                                                                             #
# [reference](https://stackoverflow.com/questions/2047465/how-can-i-delete-a-file-from-a-git-repository/2047477)#
#################################################################################################################


#* To remove the file from the Git repository and the filesystem, use:
git rm file1.txt
git commit -m "remove file1.txt"

#* To remove the file only from the Git repository and not remove it from the filesystem, use:
git rm --cached file1.txt
git commit -m "remove file1.txt"
#* And to push changes to remote repo
git push origin branch_name
