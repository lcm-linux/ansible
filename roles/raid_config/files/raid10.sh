#!/usr/bin/env bash
#显示物理磁盘信息 通过这条命令来确认32冒号后的数字
#/opt/MegaRAID/MegaCli/MegaCli64 -PDList -aAll -Nolog
#清理foreign
/opt/MegaRAID/MegaCli/MegaCli64 -CfgForeign -Clear -a0 -Nolog
#!/bin/bash
/opt/MegaRAID/MegaCli/MegaCli64 -CfgSpanAdd -r10 -Array0 [32:0,32:1] -Array1 [32:2,32:3] -a0 -Nolog