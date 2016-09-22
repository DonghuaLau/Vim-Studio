#! /bin/sh

# check command exists
function is_command_exist()
{
	cmd=$1
	exist=`whereis ${cmd} | wc -w | awk '{ if(int($1) > 1){ printf("1"); }else{ printf("0"); } }'`
	echo ${exist}
}

# check package installation
function is_package_installed()
{
	pkg=$1
	exist=`rpm -q ${pkg} | grep -v 'is not installed' | wc -l`
	echo ${exist}
}

# check vim installation
is=$(is_command_exist 'vim')
if [ ${is} == 1 ]; then
	echo "vim is found."
else
	echo "vim is not found, install vim first."
	exit
fi

# check the_silver_searcher installation
is=$(is_package_installed 'the_silver_searcher')
if [ ${is} == 1 ]; then
	echo "the_silver_searcher is found."
else
	echo "the_silver_searcher is not found, install the_silver_searcher first."
	echo ''
	echo "   rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm  (CentOS 7)"
	echo "   or"
	echo "   rpm -Uvh http://mirrors.yun-idc.com/epel/6/x86_64/epel-release-6-8.noarch.rpm  (CentOS 6)"
	echo "   yum install the_silver_searcher"
	echo ''
	exit
fi

# backup ~/.vim and ~/.vimrc
suffix=`date +"%Y%m%d%H%M"`
mv -rf ~/.vim ~/.vim_backup.${suffix}
cp -rf ~/.vimrc ~/.vimrc_backup.${suffix}

# install hua-vim
cp -rf ./vim ~/.vim
cat ./vimrc >> ~/.vimrc
