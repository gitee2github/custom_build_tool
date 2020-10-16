:<<!
 * Copyright (c) Huawei Technologies Co., Ltd. 2018-2019. All rights reserved.
 * iSulad licensed under the Mulan PSL v2.
 * You can use this software according to the terms and conditions of the Mulan PSL v2.
 * You may obtain a copy of Mulan PSL v2 at:
 *     http://license.coscl.org.cn/MulanPSL2
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
 * PURPOSE.
 * See the Mulan PSL v2 for more details.
 * Author: zhuchunyi
 * Create: 2020-10-16
 * Description: provide container buffer functions
!

set -e
######################
# make config before rpmbuild
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
