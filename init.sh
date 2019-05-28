#!/bin/bash
#判断当前目录是否已经有数据,如果有，则执行hexo clean 如果没有，则执行hexo init
	hexo init 2> /dev/null
	if [ $? -eq 0 ];then
	 hexo server
	else
	 hexo clean && hexo g && hexo server
	fi
