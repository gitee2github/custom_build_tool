#!/bin/bash
# Author: yhon
# Copyright Huawei Technologies Co., Ltd. 2010-2018. All rights reserved.
set -e
######################
# make config before rpmbuild
# Globals:
# Arguments:
# Returns:
######################
function config_rpmbuild()
{
    rpmbuild="/usr/bin/rpmbuild"
    mkdir -p /home/abuild
    cp -a /usr/bin/chmod /home/abuild/chmod
    chmod 4777 /home/abuild/chmod
    mv $rpmbuild "${rpmbuild}"-orig
cat <<END > $rpmbuild
#!/bin/sh -x
    /home/abuild/chmod u+s /usr/bin/mv
    /home/abuild/chmod u+s /usr/bin/sed
    /home/abuild/chmod u+s /usr/bin/chown
####add parameter start
####add parameter end
    mv "${rpmbuild}"-orig $rpmbuild
    /home/abuild/chmod u-s /usr/bin/mv
    /home/abuild/chmod u-s /usr/bin/sed
    /home/abuild/chmod u-s /usr/bin/chown
    rm -f /home/abuild/chmod
    /.build.command
END

    chmod 755 $rpmbuild
}

config_rpmbuild
