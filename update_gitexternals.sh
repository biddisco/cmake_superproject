find . -type d -depth 1 -print0 | xargs -0 bash -c 'D=`pwd`; for filename; do cd $D/"$filename"; echo "#" $filename $(git config --get remote.$(git config --get branch.master.remote).url) $(git rev-parse HEAD); done' >> .gitexternals

