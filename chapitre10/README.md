# Chapitre 10

## Job jenkins

```
/opt/build/scripts/start-build.sh XXXX
/opt/build/scripts/build-java.sh XXXX
/opt/build/scripts/build-configure.sh XXXX DEV
```

5EBE2294ECD0E0F08EAB7690D2A6EE69

/job/CI_BUILD_DEV/build?token=5EBE2294ECD0E0F08EAB7690D2A6EE69


vi home.html

<h1 class="display-4">Bienvenue les amis !</h1>

Modification home page
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Committer: root <root@localhost.localdomain>
#
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   home.html
#

root@localhost templates]# vi home.html 
[root@localhost templates]# git push origin master
Username for 'http://localhost': root
Password for 'http://root@localhost': 
Counting objects: 13, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (7/7), 573 bytes | 0 bytes/s, done.
Total 7 (delta 3), reused 0 (delta 0)
To http://localhost/root/appex-front-end.git
   12038cb..9d8dfb2  master -> master


