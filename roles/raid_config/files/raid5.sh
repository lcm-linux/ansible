#显示物理磁盘信息 通过这条命令来确认32冒号后的数字
#/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aAll -Nolog
#!/bin/bash

#清理foreign
/opt/MegaRAID/MegaCli/MegaCli64 -CfgForeign -Clear -a0 -Nolog

#无热备
#/opt/MegaRAID/MegaCli/MegaCli64 -CfgLdAdd -r5 [32:0,32:1,32:2,32:3,32:4,32:5,32:6] WB RA Direct CachedBadBBU -strpsz256 -a0 -NoLog


#有热备
/opt/MegaRAID/MegaCli/MegaCli64 -CfgLdAdd -r5 [32:0,32:1,32:2,32:3,32:4,32:5,32:6,32:7,32:8,32:9,32:10] WB RA Direct CachedBadBBU -strpsz256 -Hsp [32:11] -a0 -NoLog
