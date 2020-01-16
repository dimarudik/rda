find $ORACLE_BASE/diag/rdbms/${ORACLE_SID,,}_n/$ORACLE_SID/trace/ -maxdepth 1 -type f -name "*HAD*.trc" -mmin -80 | xargs grep "dump location:" | awk '{print ($4)}' | uniq
sed -n '/XCTEND.*32011705617666/,/XCTEND.*32011729496779/p' SIEBEL_ora_107197.trc > ttt.out
| awk 'BEGIN{a=0}{a+=$1}END{print a}'
[root@m1-db07-oel ~]# cat d
alpha 12
beta 11
alpha 1
beta 2
gamma 3
alpha 1
cat d | awk ‘BEGIN{}{a[$1]++;b[$1]+=$2}END{for (i in a) print i ” ” b[i]}’
